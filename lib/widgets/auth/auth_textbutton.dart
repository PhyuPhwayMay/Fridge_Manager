import 'package:flutter/material.dart';

//creating a reusable textbutton for login screen
class AuthTextButtonWidget extends StatelessWidget{

  //button properties
  final String buttontext;
  final Color backgroundColor;
  final Function()? onPressedFunction;

  const AuthTextButtonWidget({required this.buttontext, required this.backgroundColor, this.onPressedFunction});


  @override
  Widget build (BuildContext context){
    return TextButton(

              //configuration of onpressed
              onPressed: () => onPressedFunction,

              style: TextButton.styleFrom(
                backgroundColor: backgroundColor
              ),

              //label text of the button
              child:Text(buttontext,
              style: TextStyle(
                fontFamily: 'EBGaramond',
                fontSize: 22,
                fontStyle:FontStyle.normal,
                fontWeight: FontWeight.normal,
                color: Color.fromRGBO(88, 102, 108, 1)
              ),
            ),
              
            
    );
  }
}