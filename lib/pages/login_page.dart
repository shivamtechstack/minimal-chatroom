import 'package:flutter/material.dart';
import 'package:minimalchatroom/components/my_button.dart';
import 'package:minimalchatroom/components/my_textfield.dart';

import '../auth/auth_service.dart';

class LoginPage extends StatelessWidget{

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final void Function()? onTap;

  LoginPage({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.message, size: 60,color: Theme.of(context).colorScheme.primary,),

            const SizedBox(height: 15,),

            Text("Welcome",style: TextStyle(fontSize: 50, color: Theme.of(context).colorScheme.primary),),

            const SizedBox(height: 25,),

            MyTextField(hintText: "email", obscureText: false, controller: _emailController,),

            const SizedBox(height: 15,),

            MyTextField(hintText: "password", obscureText: true, controller: _passwordController,),

            const SizedBox(height: 25,),

            MyButton(text: "Login", onTap: () => login(context),),

            const SizedBox(height: 40,),

            Row (
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not a member?",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),

                const SizedBox(width: 5,),

                GestureDetector(
                  onTap: onTap,
                  child: Text("Register Now",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }

  void login(BuildContext context) async{
    try{
    await AuthService()
        .signInWithEmailPassword(_emailController.text, _passwordController.text);
  }catch(e){
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text(e.toString()),
      ));
    }
  }


}