import 'package:flutter/material.dart';

class BannerText extends StatelessWidget{

  final String text;

  const BannerText({required this.text});
  @override
  Widget build (BuildContext context){
    return  Text(
      text,
      style: TextStyle(
        fontFamily: 'EBGaramond',
        fontSize: 20,
        color: Color.fromRGBO(82, 102, 108, 1),
      ),
    );
  }
}