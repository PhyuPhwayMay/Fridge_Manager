import 'package:flutter/material.dart';

class Text1Widget extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    return Text(
          'My Fridge',
          style: TextStyle(
            fontFamily: 'EBGaramond',
            fontSize: 26,
            fontStyle:FontStyle.normal,
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(88, 102, 108, 1)
          )
        
    );
  }
}