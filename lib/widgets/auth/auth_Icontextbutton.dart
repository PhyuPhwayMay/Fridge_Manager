import 'package:flutter/material.dart';

//creating a reusable textbutton for login screen
class AuthTextButtonIconWidget extends StatelessWidget{

  //button properties
  final String buttontext;
  final String imagePath;
  final Color backgroundcolor;
  final Function()? onPressedFunction;

  const AuthTextButtonIconWidget({required this.buttontext, required this.imagePath, required this.backgroundcolor, required this.onPressedFunction});


  @override
  Widget build (BuildContext context){
    return Material(
        child: Container(
          color: Color.fromRGBO(240, 239, 226, 1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),

            child: TextButton.icon(

              //configuration of onpressed
              onPressed: onPressedFunction,

              style: TextButton.styleFrom(
                backgroundColor: backgroundcolor
              ),

              //icon image
              icon: SizedBox(
                height:30,
                width: 30,
                child: Image.asset(imagePath)
              ),


              //label of the text button
              label:Text(buttontext,
              style: TextStyle(
                fontFamily: 'EBGaramond',
                fontSize: 20,
                fontStyle:FontStyle.normal,
                fontWeight: FontWeight.normal,
                color: Color.fromRGBO(88, 102, 108, 1)
              )
              ),
            ),
          ),
        ),
    );
  }
}