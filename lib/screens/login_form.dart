
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:mbap_project_app/services/firebase_service.dart';
import 'package:mbap_project_app/widgets/auth/auth_Icontextbutton.dart';

import 'package:mbap_project_app/widgets/auth/subtitle_widget.dart';
import 'package:mbap_project_app/widgets/auth/authtitle_widget.dart';


class LoginForm extends StatelessWidget{
  FirebaseService fbService = GetIt.instance<FirebaseService>();

  String? email;

  String? password;

  var form=GlobalKey<FormState>();

  login(context){
    bool isValid = form.currentState!.validate();

    if(isValid){
      form.currentState!.save();

      fbService.login(email, password).then((value){
        FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Successfully"))
        );
      }).catchError((error){
        FocusScope.of(context).unfocus();
        String message = error.toString();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message))
        );
      });
    }
  }

  handleGoogleSignIn () async{
    UserCredential userCredential = await fbService.signInWithGoogle();
      User? user = userCredential.user;
      if(user!=null){
        bool exists = await fbService.userExists(user);
        if(!exists){
          String? username = user.displayName;
          await fbService.addUser(user.uid, user.email!, username?? '', profilePic: user.photoURL);
        }
      
    }
  }

  @override
  Widget build(BuildContext context){
    return Form(
            key: form,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              
                      //Log in title
                      AuthTitleWidget(authText: 'Log In',),
                      SizedBox(height: 10),
              
              
                      //Email tab
                      SubtitleWidget(logintext: 'Email'),
                      SizedBox(height: 7,),
                      TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Color.fromRGBO(112, 112, 112, 1)), //border margin color when unfocused
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Color.fromRGBO(92, 129, 128, 0.09)) //border margin color when focused
                          ),
                          //textfield color
                          fillColor: Color.fromRGBO(92, 129, 128, 0.09),
                          filled: true,

                          //hint text for the users to know what to type in
                          hintText: "Email",
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value){
                          if (value == null)
                            return "Please provide an email address.";
                          else if (!value.contains('@'))
                            return "Please provide a valid email address.";
                          else
                            return null;
                        },
                        onSaved: (value){
                          email = value;
                        }
                      ),

                      SizedBox(height: 10),
                      
                      //Password tab
                      SubtitleWidget(logintext: 'Password'),
                      SizedBox(height:7),
                      TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Color.fromRGBO(112, 112, 112, 1)), //border margin color when unfocused
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(color: Color.fromRGBO(92, 129, 128, 0.09)) //border margin color when focused
                          ),
                          //textfield color
                          fillColor: Color.fromRGBO(92, 129, 128, 0.09),
                          filled: true,
                          //hint text for the users to know what to type in
                          hintText: "Password",
                        ),
                        obscureText: true,
                        validator: (value){
                          if (value == null)
                            return "Please provide a password.";

                          //minimum 8 characters
                          else if (value.length<8)
                            return "Password must have minimum 8 characters";

                          //include special characters
                          else if (!RegExp('[!@#%^&*()<>?":{}|<>]').hasMatch(value))
                            return ("Password must contain special characters");
                          else
                            return null;
                        },
                        onSaved: (value){
                          password = value;
                        }
                      ),
                    SizedBox(height:7),
                  ],
                ),
              
                
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      
                      //Log in button
                      TextButton(
                        onPressed: () {login(context);},

                        style: TextButton.styleFrom(
                        backgroundColor: Color.fromRGBO(92, 129, 128, 0.09)
                        ),

                        //label text of the button
                        child:Text("Log In",
                          style: TextStyle(
                            fontFamily: 'EBGaramond',
                            fontSize: 22,
                            fontStyle:FontStyle.normal,
                            fontWeight: FontWeight.normal,
                            color: Color.fromRGBO(88, 102, 108, 1)
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      
                      //Divider Row
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                          ),
                          Text('Or Sign in with',
                          style: TextStyle(fontSize: 15),),
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 15,),
                      
                      //Google button
                      AuthTextButtonIconWidget(buttontext: 'Google', imagePath: 'images/google.png', backgroundcolor: Color.fromRGBO(92, 129, 128, 0.09),onPressedFunction:() => handleGoogleSignIn()),
                      SizedBox(height: 15,),
                      
                      //Facebook button
                      AuthTextButtonIconWidget(buttontext: 'Facebook', imagePath: 'images/facebook.png', backgroundcolor: Color.fromRGBO(92, 129, 128, 0.09), onPressedFunction: (){}, )
                    ],
                  )
                ],
              ),
            ),
    );
  }
}