// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:async';

import 'package:app_chat/core/models/chat_user.dart';
import 'package:app_chat/core/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthFirebaseService implements AuthService {
  static ChatUser? _currentUser;
  static final _userStream = Stream<ChatUser?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();
    await for (final user in authChanges) {
      _currentUser = user == null ? null : _toChatUser(user);
      controller.add(_currentUser);
    }
  });

  ChatUser? get currentUser {
    return _currentUser;
  }

  Stream<ChatUser?> get UserChanges {
    return _userStream;
  }

  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  ) async {

    final signup = await Firebase.initializeApp(
      name: 'userSignup',
      options: Firebase.app().options,
    );

    final auth = FirebaseAuth.instanceFor(app: signup);
    UserCredential credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user != null) {


    final imageName = '${credential.user!.uid}.jpg';
    final imageUrl = await _uploadUserImage(image, imageName);

    await credential.user?.updateDisplayName(name);
    await credential.user?.updatePhotoURL(imageUrl);

    await login(email, password);

    await _saveChatUser(_toChatUser(credential.user!, imageUrl));
    
    }
    await signup.delete();
  }

  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  Future<String?> _uploadUserImage(File? image, String imageName) async {
    if (image == null) return null;

    final storage = FirebaseStorage.instance;
    final imageRef = storage.ref().child('user_images').child(imageName);
    await imageRef.putFile(image).whenComplete(() => {});
    return await imageRef.getDownloadURL();
  }

  Future<void> _saveChatUser(ChatUser user) async {
    final store = FirebaseFirestore.instance;
    final docRef = store.collection('users').doc(user.id);
    
    return docRef.set({
      'name': user.name,
      'email': user.email,
      'imageURL': user.imageUrl,
    });
  }

  static ChatUser _toChatUser(User user, [String? imageURL]) {
    return ChatUser(
      id: user.uid,
      name: user.displayName ?? user.email!.split('@'[0]).toString(),
      email: user.email!,
      imageUrl: imageURL ??  user.photoURL ?? 'app_chat/assets/images/avatar.png',
    );
  }
}
