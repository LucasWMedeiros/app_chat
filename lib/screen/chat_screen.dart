import 'package:app_chat/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Chat page'),
          TextButton(
            onPressed: () {
              AuthService().logout();
            },
            child: const Text('Logout'),
          )
        ],
      ),
    );
  }
}
