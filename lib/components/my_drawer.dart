import 'package:flutter/material.dart';

import '../auth/auth_service.dart';
import '../pages/settings_page.dart';

class MyDrawer extends StatelessWidget{
  const MyDrawer({super.key});

  void logout(){
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Center(
                  child: Icon(Icons.message,
                  size: 50,
                  color: Theme.of(context).colorScheme.primary,),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: Text('H O M E'),
                  leading: Icon(Icons.home),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: Text('S E T T I N G S'),
                  leading: Icon(Icons.settings),
                  onTap: (){
                    Navigator.pop(context);
                    //navigate to settings
                    Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(),
                    ));
                  },
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 25,bottom: 30),
            child: ListTile(
            title: Text('L O G O U T'),
              leading: Icon(Icons.logout),
              onTap: (){
                logout();
              },
            ),
          )
        ],
      ),
    );
  }
  
}