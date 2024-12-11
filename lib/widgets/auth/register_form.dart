import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mbap_project_app/services/firebase_service.dart';
import 'package:mbap_project_app/widgets/auth/subtitle_widget.dart';
import 'package:mbap_project_app/widgets/auth/authtitle_widget.dart';

class RegisterForm extends StatelessWidget{

  FirebaseService fbService = GetIt.instance<FirebaseService>();

  String? username;
  String? email;
  String? password;
  String? confirmPassword;
  var form = GlobalKey<FormState>();

  register(context){
    bool isValid = form.currentState!.validate();

    if (isValid){
      form.currentState!.save();
    

    if(password != confirmPassword){
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password and Confirm Password does not match!"))
      );
    }

    fbService.register(email, password).then((value){
      User? user = value.user;
      if(user!=null){
        fbService.addUser(user.uid, email!, username!).then((value){
          FocusScope.of(context).unfocus();
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("User is registered successfully!"))
          );
        });
      }
      
    }).catchError((error){
      FocusScope.of(context).unfocus();
      String message = error.toString();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)));
    });
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
                
                        //Sign in title
                        AuthTitleWidget(authText: 'Sign Up'),
                        SizedBox(height: 7),
                          
                        //Usename tab
                        SubtitleWidget(logintext: 'Username'),
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
                            hintText: "Username",
                          ),
                          validator: (value){
                            if (value == null)
                              return "Please provide a username.";
                            else
                              return null;
                          },
                          onSaved: (value){
                            username = value;
                          }
                        ),
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
                            hintText: "Password",
                          ),
                          obscureText: true,
                          validator: (value){
                            if (value == null)
                              return "Please provide a password.";
                            else if (value.length<8)
                              return "Password must have minimum 8 characters";
                            else if (!RegExp('[!@#%^&*()<>?":{}|<>]').hasMatch(value))
                              return ("Password must contain special characters");
                            else
                              return null;
                          },
                          onSaved: (value){
                            password = value;
                          }
                        ),
                        SizedBox(height: 10),
                          
                          
                        //Confirm Password tab
                        SubtitleWidget(logintext: 'Confirm Password'),
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
                            hintText: "Retype the password filled",
                          ),
                          obscureText: true,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value){
                            if (value == null)
                              return "Please provide a password.";
                            else if (value.length<8)
                              return "Password must have minimum 8 characters";
                            else if (!RegExp('[!@#%^&*()<>?":{}|<>]').hasMatch(value))
                              return ("Password must contain special characters");
                            else
                              return null;
                          },
                          onSaved: (value){
                            confirmPassword= value;
                          }
                          
                        ),
                        SizedBox(height:20),
                      ],
                    ),
                
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                          
                        //Sign Up button tab
                        TextButton(
                        onPressed: () {register(context);},

                        style: TextButton.styleFrom(
                        backgroundColor: Color.fromRGBO(92, 129, 128, 0.09)
                        ),

                        //label text of the button
                        child:Text("Sign Up",
                          style: TextStyle(
                            fontFamily: 'EBGaramond',
                            fontSize: 22,
                            fontStyle:FontStyle.normal,
                            fontWeight: FontWeight.normal,
                            color: Color.fromRGBO(88, 102, 108, 1)
                          ),
                        ),
                      ),
                        SizedBox(height: 7),
                        
                      ],
                    )
                  ],
                ),
              ),
    );
  }
}