import 'dart:async';
import 'dart:math';
import 'package:app_chat/core/models/chat_menssage.dart';
import 'package:app_chat/core/models/chat_user.dart';
import 'package:app_chat/core/services/chat/chat_service.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _msgs = [
    ChatMessage(
      id: '1',
      text: 'Bem-Vindo',
      createdAt: DateTime.now(),
      userId: '123',
      userName: 'Roberto',
      userImageURL: 'app_chat/assets/images/avatar.png',
    ),
    ChatMessage(
      id: '2',
      text: 'Bem-Vindo',
      createdAt: DateTime.now(),
      userId: 'Bem vindo ao aplicativo de chat!',
      userName: 'Julia',
      userImageURL: 'app_chat/assets/images/avatar.png',
    ),
    ChatMessage(
      id: '3',
      text: 'Muito Obrigado',
      createdAt: DateTime.now(),
      userId: '321',
      userName: 'Jonas',
      userImageURL: 'app_chat/assets/images/avatar.png',
    ),
  ];
  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _msgsStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    controller.add(_msgs);
  });

  Stream<List<ChatMessage>> messagesStream() {
    return _msgsStream;
  }

  Future<ChatMessage> save(String text, ChatUser user) async {
    final _newMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageURL: user.imageUrl,
    );
    _msgs.add(_newMessage);

    _controller?.add(_msgs);

    return _newMessage;
  }
}
