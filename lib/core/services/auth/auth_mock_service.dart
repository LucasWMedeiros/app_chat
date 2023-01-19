import 'dart:io';

import 'package:app_chat/core/models/chat_user.dart';
import 'package:app_chat/core/services/auth/auth_service.dart';

class AuthMockService implements AuthService {
  ChatUser? get currentUser{}

  Stream<ChatUser?> get UserChanges{}

  Future<void> signup(
      String nome, String email, String password, File image) async {}

  Future<void> login(String email, String password) async {}

  Future<void> logout() async {}
}
