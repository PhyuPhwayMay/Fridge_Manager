import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    return Container(
      height: 60,
      width: 60,
      child: Image.asset('images/fridge_manager_logo.png', width: 92 , height: 60));
  }
}