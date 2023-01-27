import 'package:app_chat/core/models/chat_notification.dart';
import 'package:flutter/cupertino.dart';

class ChatNotificationService with ChangeNotifier{
  List<ChatNotification> _items = [
    ChatNotification(title: 'Teste', body: 'Notificação de teste')
  ];

  int get itemsCount {
    return _items.length;
  }

  List<ChatNotification> get items {
    return [..._items];
  }

  void add(ChatNotification notification){
    _items.add(notification);
    notifyListeners();
  }

  void remove(int i){
    _items.removeAt(i);
    notifyListeners();
  }
}
