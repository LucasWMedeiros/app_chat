
import 'package:app_chat/core/models/chat_user.dart';
import 'package:app_chat/core/services/auth/auth_mock_service.dart';
import 'package:app_chat/screen/auth_screen.dart';
import 'package:app_chat/screen/chat_screen.dart';
import 'package:app_chat/screen/loading_screen.dart';
import 'package:flutter/material.dart';

class AuthOrAppScreen extends StatelessWidget {
  const AuthOrAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ChatUser?>(
        stream: AuthMockService().UserChanges,
        builder: (ctx, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return LoadingScreen();
          } else {
            return snapshot.hasData ? ChatScreen() : AuthScreen();
          }
        },
      )
    );
  }
}