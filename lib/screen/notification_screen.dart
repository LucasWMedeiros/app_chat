import 'dart:developer';

import 'package:app_chat/core/services/notifications/chat_notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _service = Provider.of<ChatNotificationService>(context);
    final _items = _service.items;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Minhas Notificações'),
        ),
        body: ListView.builder(
          itemCount: _service.itemsCount,
          itemBuilder: (ctx, i) => ListTile(
            title: Text(_items[i].title),
            subtitle: Text(_items[i].body),
            onTap: () => _service.remove(i)
        )));
  }
}
