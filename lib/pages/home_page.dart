import 'package:flutter/material.dart';

import '../auth/auth_service.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  void logout(){
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("Home Page"),
        centerTitle: true,

        actions: [
          IconButton(onPressed: logout, icon: Icon(Icons.logout))        ],
      ),
    );
  }

}