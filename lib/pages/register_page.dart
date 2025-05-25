import 'package:flutter/material.dart';

import '../auth/auth_service.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatelessWidget{
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final void Function()? onTap;

  RegisterPage({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.message, size: 60,color: Theme.of(context).colorScheme.primary,),

            const SizedBox(height: 10,),

            Text("Lets Create an Account",style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.primary),),

            const SizedBox(height: 25,),

            MyTextField(hintText: "email", obscureText: false, controller: _emailController,),

            const SizedBox(height: 15,),

            MyTextField(hintText: "password", obscureText: true, controller: _passwordController,),

            const SizedBox(height: 15,),

            MyTextField(hintText: "confirm password", obscureText: true, controller: confirmPasswordController),

            const SizedBox(height: 25,),

            MyButton(text: "Register",onTap: () => register(context),),

            const SizedBox(height: 40,),

            Row (
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already a member?",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),

                const SizedBox(width: 5,),

                GestureDetector(
                  onTap: onTap,
                  child: Text("Login Now",
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

  void register(BuildContext context){
    final authService = AuthService();
    if(_passwordController.text != confirmPasswordController.text){
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
       content : Text("Passwords do not match!")
     ));
    }else{
    authService.signUpWithEmailPassword(_emailController.text, _passwordController.text);
    }
  }

}