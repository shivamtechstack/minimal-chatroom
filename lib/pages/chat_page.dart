import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimalchatroom/auth/auth_service.dart';
import 'package:minimalchatroom/components/my_textfield.dart';

import '../components/chat_bubble.dart';
import '../services/chat/chat_service.dart';

class ChatPage extends StatelessWidget{

  final String receiversEmail;
  final String receiverID;
  ChatPage({super.key, required this.receiversEmail, required this.receiverID});

  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void sendMessage() async {
    if(_messageController.text.isNotEmpty){
      await _chatService.sendMessage(receiverID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[300],
        title: Text(receiversEmail),
        centerTitle: true,
      ),
      body: Column(

        children: [
          Expanded(
              child: _buildMessageList()
          ),

          _buildUserInput()
    ]
      ),
    );
  }

  Widget _buildMessageList(){
    String senderId = _authService.currentUser!.uid;
    return StreamBuilder(stream: _chatService.getMessages(receiverID, senderId),
        builder: (context, snapshot){
      if(snapshot.hasError){
        return const Text("Error");
      }

      if(snapshot.connectionState == ConnectionState.waiting){
        return const Center(child: CircularProgressIndicator());
      }

      return ListView(
        children:
          snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),

      );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data["senderID"] == _authService.currentUser!.uid;

    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        alignment: alignment,
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(message: data["message"], isCurrentUser: isCurrentUser),
          ],
        )
    );
  }

  Widget _buildUserInput(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 50, right: 10),
      child: Row(
        children: [
          Expanded(
              child: MyTextField(
                  hintText: "Type a message",
                  obscureText: false,
                  controller: _messageController
              )
          ),
          IconButton(onPressed: sendMessage, icon: Icon(Icons.send,size: 35,color: Colors.orange,))
        ],
      ),
    );
  }
}