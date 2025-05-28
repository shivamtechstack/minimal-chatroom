import 'package:flutter/material.dart';
import 'package:minimalchatroom/components/my_drawer.dart';
import 'package:minimalchatroom/services/chat/chat_service.dart';

import '../auth/auth_service.dart';
import '../components/user_tile.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget{
  HomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[300],
        title: Text("Home Page"),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList(){
    return StreamBuilder(stream: _chatService.getUsersStream(), builder: (context, snapshot){

      if(snapshot.hasError){
        return const Text("Error");
      }

      if(snapshot.connectionState == ConnectionState.waiting){
        return const Center(child: CircularProgressIndicator());
      }

      return ListView(
        children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData, context)).toList(),
      );
    });
  }

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context){

    if(userData["email"] != _authService.currentUser!.email){
      return UserTile(
        text: userData['email'],
        onTap: (){
          // Navigate to chat screen
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(
            receiversEmail: userData['email'],
            receiverID: userData['uid'],
          ),));
        },
      );
    }else{
      return Container();
    }
  }

}