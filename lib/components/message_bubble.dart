// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:app_chat/core/models/chat_menssage.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  static const _defaultImage = 'assets/images/avatar.png';
  final ChatMessage message;
  final bool belongsToCurrentUser;
  const MessageBubble({
    required this.message,
    required this.belongsToCurrentUser,
    Key? key,
  }) : super(key: key);

  Widget _showUserImage(String imageUrl) {
    ImageProvider? provider;
    final uri = Uri.parse(imageUrl);

    if(uri.path.contains(_defaultImage)){
      provider = AssetImage(_defaultImage);
    } else if(uri.scheme.contains('http')){
      provider = NetworkImage(uri.toString());
    } else{
      provider = FileImage(File(uri.toString()));
    }

    return CircleAvatar(
            backgroundImage: provider,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: belongsToCurrentUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: belongsToCurrentUser
                    ? Colors.grey.shade300
                    : Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: belongsToCurrentUser ? Radius.circular(12) : Radius.zero,
                  bottomRight: belongsToCurrentUser ? Radius.zero : Radius.circular(12),
                ),
              ),
              width: 180,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 8,
              ),
              child: Column(
                children: [
                  Text(
                    message.userName,
                    style: TextStyle(
                      color: belongsToCurrentUser ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    message.text,
                    style: TextStyle(
                      color: belongsToCurrentUser ? Colors.black : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: belongsToCurrentUser ? null : 165,
          right: belongsToCurrentUser ? 165 : null,
          child: _showUserImage(message.userImageURL)
        ),
      ],
    );
  }
}
