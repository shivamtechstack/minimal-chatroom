import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget{
  final String message;
  final bool isCurrentUser;

  const ChatBubble({super.key,
    required this.message,
    required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: isCurrentUser ? Colors.grey[200]: Colors.green[200],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10),
      child: Text(message, style: TextStyle(fontSize: 16),),
    );
  }

}