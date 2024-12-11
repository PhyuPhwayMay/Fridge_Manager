
import 'package:flutter/material.dart';
import 'package:mbap_project_app/screens/login_form.dart';
import 'package:mbap_project_app/screens/reset_password_screen.dart';
import 'package:mbap_project_app/widgets/auth/register_form.dart';

import 'package:mbap_project_app/widgets/logo_widget.dart';

class AuthScreen extends StatefulWidget{

  static String routeName = '/auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool loginScreen = true;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 239, 226, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.only(left: 1),
            child: LogoWidget()
          ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Column(
            children: [loginScreen? LoginForm() : RegisterForm(),
            const SizedBox(height: 5),
            loginScreen? TextButton(
              onPressed: (){
                setState(() {
                  loginScreen = false;
                });
              }, 
              child: const Text('New User? Sign up here')) :
              TextButton(
                onPressed: (){setState(() {
                  loginScreen = true;
                });
                }, 
                child: const Text("Existing User? Log in here!")),
              loginScreen? TextButton(
                onPressed: (){
                  Navigator.of(context).pushNamed(ResetPasswordScreen.routeName);
                  },  
                  child: const Text("Forgot Password")) : const Center()],
          ),
          )
      ),
    );
  }
}