import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mbap_project_app/services/firebase_service.dart';
import 'package:mbap_project_app/widgets/auth/auth_textbutton.dart';
import 'package:mbap_project_app/widgets/logo_widget.dart';

class ResetPasswordScreen extends StatelessWidget{

  static String routeName = '/reset-password';

  FirebaseService fbService = GetIt.instance<FirebaseService>();

  String? email;

  var form=GlobalKey<FormState>();

  reset(context){
    bool isValid = form.currentState!.validate();

    if (isValid){
      form.currentState!.save();

      return fbService.forgotPassword(email).then((value){
        FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please check your email to reset your password')));
        Navigator.of(context).pop();
      }).catchError((error){
        FocusScope.of(context).unfocus();
        String message = error.toString();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      });
    }
  }

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
          child: Form(
            key: form,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Column(
                children: [
                  TextFormField(
                  decoration: 
                    InputDecoration(
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
                const SizedBox(height: 20,),
                TextButton(
                        onPressed: () {reset(context);},

                        style: TextButton.styleFrom(
                        backgroundColor: Color.fromRGBO(92, 129, 128, 0.09)
                        ),

                        //label text of the button
                        child:Text("Reset Password",
                          style: TextStyle(
                            fontFamily: 'EBGaramond',
                            fontSize: 22,
                            fontStyle:FontStyle.normal,
                            fontWeight: FontWeight.normal,
                            color: Color.fromRGBO(88, 102, 108, 1)
                          ),
                        ),
                      ),
              ]
            )
          )
        )
      )
    );
  }
}