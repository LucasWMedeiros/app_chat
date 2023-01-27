import 'dart:math';

import 'package:app_chat/components/messages.dart';
import 'package:app_chat/components/new_mensage.dart';
import 'package:app_chat/core/models/chat_notification.dart';
import 'package:app_chat/core/services/auth/auth_service.dart';
import 'package:app_chat/core/services/notifications/chat_notifications_service.dart';
import 'package:app_chat/screen/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hunter Chat'),
        centerTitle: true,
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Container(
                    child: Row(
                      children: const [
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.black87,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Sair')
                      ],
                    ),
                  ),
                )
              ],
              onChanged: (value) {
                if (value == 'logout') {
                  AuthService().logout();
                }
              },
            ),
          ),
          Provider.of<ChatNotificationService>(context).items.isNotEmpty
              ? Stack(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return NotificationScreen();
                        }));
                      },
                      icon: Icon(Icons.notifications),
                    ),
                    // ignore: prefer_const_constructors
                    Positioned(
                      top: 5,
                      right: 5,
                      child: CircleAvatar(
                        backgroundColor: Colors.red.shade800,
                        maxRadius: 10,
                        child: Text(
                          '${Provider.of<ChatNotificationService>(context).itemsCount}',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) {
                      return NotificationScreen();
                    }));
                  },
                  icon: Icon(Icons.notifications),
                ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMensage(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     Provider.of<ChatNotificationService>(
      //       context,
      //       listen: false,
      //     ).add(ChatNotification(
      //       title: 'Notificação de Teste!',
      //       body: Random().nextDouble().toString(),
      //     ));
      //   },
      // ),
    );
  }
}
