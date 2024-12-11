import 'package:flutter/material.dart';

//creating a reusable textfield for authentication purpose
class AuthTextField extends StatelessWidget{

  //textfield properties
  final String hint;
  final bool obscureText;

  const AuthTextField({required this.hint, required this.obscureText});

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),

      //Using sized box to configure the size of the text field
      child: SizedBox(
        height: 55,
        width: 330,

        child: TextFormField(
          
          //obscure text to hide the password
          obscureText: obscureText,

          //decoration of the textfield
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
              hintText: hint,
          ),
          ),
      )
      );
  }
}