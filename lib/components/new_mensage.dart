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
      final msg = await ChatService().save(_message, user);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0, left: 10),
            child: TextField(
              controller: _messageController,
              onChanged: (msg) => setState(() => _message = msg),
              decoration: InputDecoration(labelText: 'Enviar mensagem...'),
            onSubmitted: (_) {
              if(_message.trim().isNotEmpty) {
                _sendMessage();
              }
            },
            ),
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
