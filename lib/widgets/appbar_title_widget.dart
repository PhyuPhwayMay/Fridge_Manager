import 'package:flutter/material.dart';

class AppBarTitleWidget extends StatelessWidget{

  final String title;

  const AppBarTitleWidget({required this.title});
  @override
  Widget build (BuildContext context){
    return Text(
            title,
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