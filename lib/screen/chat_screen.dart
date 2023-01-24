import 'package:app_chat/components/messages.dart';
import 'package:app_chat/components/new_mensage.dart';
import 'package:app_chat/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hunter Chat'),
        centerTitle: true,
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Container(
                  child: Row(
                    children:const  [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.black87,
                      ),
                      SizedBox(width: 10,),
                      Text('Sair')
                    ],
                  ),
                ),
              )
            ],
            onChanged: (value) {
              if(value == 'logout') {
                AuthService().logout();
              }
            },
          )
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
    );
  }
}
