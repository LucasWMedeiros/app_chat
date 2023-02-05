import 'dart:async';
import 'dart:math';
import 'package:app_chat/core/models/chat_menssage.dart';
import 'package:app_chat/core/models/chat_user.dart';
import 'package:app_chat/core/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatFirebaseService implements ChatService {
  Stream<List<ChatMessage>> messagesStream() {
    return Stream<List<ChatMessage>>.empty();
  }

  Future<ChatMessage?> save(String text, ChatUser user) async {
    final store  = FirebaseFirestore.instance;
    store.collection('chat').add({
      'text': text,
      'createdAt': DateTime.now(),
      'userId': user.id,
      'userName': user.name,
      'userImageURL': user.imageUrl,
    });
    return null;
  }
}
