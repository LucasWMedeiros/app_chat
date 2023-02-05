import 'package:app_chat/core/models/chat_menssage.dart';
import 'package:app_chat/core/models/chat_user.dart';
import 'package:app_chat/core/services/chat/chat_firebase_service.dart';
import 'package:app_chat/core/services/chat/chat_mock_service.dart';

abstract class ChatService {
  Stream<List<ChatMessage>> messagesStream();
  Future<ChatMessage?>save(String text, ChatUser user);

  factory ChatService() {
    // return ChatMockService();
    return ChatFirebaseService();
  }
}