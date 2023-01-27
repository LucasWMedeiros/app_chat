import 'package:app_chat/core/services/auth/auth_service.dart';
import 'package:app_chat/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class NewMensage extends StatefulWidget {
  const NewMensage({Key? key}) : super(key: key);

  @override
  State<NewMensage> createState() => _NewMensageState();
}

class _NewMensageState extends State<NewMensage> {
  String _message = '';
  TextEditingController _messageController = TextEditingController();

  Future<void> _sendMessage() async {
    final user = AuthService().currentUser;

    if (user != null) {
      await ChatService().save(_message, user);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            onChanged: (msg) => setState(() => _message = msg),
            decoration: InputDecoration(labelText: 'Enviar mensagem...'),
          ),
        ),
        IconButton(
          onPressed: _message.trim().isEmpty ? null : _sendMessage,
          icon: Icon(Icons.send),
        ),
      ],
    );
  }
}
