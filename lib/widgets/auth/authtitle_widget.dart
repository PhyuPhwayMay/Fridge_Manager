import 'package:flutter/material.dart';

class AuthTitleWidget extends StatelessWidget{

  final String authText;

  AuthTitleWidget({required this.authText});

  @override
  Widget build (BuildContext context){
    return Material(
        child: Container(
          color: Color.fromRGBO(240, 239, 226, 1),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(
              authText,
              style: TextStyle(
                fontFamily: 'EBGaramond',
                fontSize: 30,
                fontStyle:FontStyle.normal,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(88, 102, 108, 1)
              )
            ),
          ),
        ),
    );
  }
}