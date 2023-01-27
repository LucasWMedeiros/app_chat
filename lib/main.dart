import 'package:app_chat/components/auth_form.dart';
import 'package:app_chat/core/services/notifications/chat_notifications_service.dart';
import 'package:app_chat/screen/auth_or_app_screen.dart';
import 'package:app_chat/screen/auth_screen.dart';
import 'package:app_chat/screen/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChatNotificationService(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AuthOrAppScreen(),
      ),
    );
  }
}
