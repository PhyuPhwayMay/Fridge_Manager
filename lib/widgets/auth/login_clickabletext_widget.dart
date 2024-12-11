import 'package:flutter/material.dart';

//creating a reusable textbutton for login screen
class ClickableTextWidget extends StatelessWidget{

  //clickable text properties
  final String clickabletext;
  final String routename;

  const ClickableTextWidget({required this.clickabletext, required this.routename});


  @override
  Widget build (BuildContext context){
    return Material(
        child: Container(
          color: Color.fromRGBO(240, 239, 226, 1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),

            //Using gesture detector to know what gesture is done and what to proceed next according to the gesture done
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).pushReplacementNamed(routename);
              },

              //text label of this clickable text
              child:Text(
                clickabletext,
                style: TextStyle(
                  fontFamily: 'EBGaramond',
                  fontSize: 18,
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