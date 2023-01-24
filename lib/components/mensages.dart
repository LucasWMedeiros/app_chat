import 'package:app_chat/core/models/chat_menssage.dart';
import 'package:app_chat/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChatMessage>>(
      stream: ChatService().messagesStream(),
      builder: (ctx, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Sem Dados! Vamos conversar?'),);
        } else {
          final msg =snapshot.data!;
          return ListView.builder(
            reverse: true,
            itemCount: msg.length,
            itemBuilder: (ctx, i) => Text(msg[i].text),
          );
        }
      });
  }
}