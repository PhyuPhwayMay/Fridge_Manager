import 'package:flutter/material.dart';

//Creating subtitle widget
class SubtitleWidget extends StatelessWidget{

  //subtitle property
  final String logintext;

  const SubtitleWidget({required this.logintext});


  @override
  Widget build (BuildContext context){
    return Material(
        child: Container(
          color: Color.fromRGBO(240, 239, 226, 1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              logintext,
              style: TextStyle(
                fontFamily: 'EBGaramond',
                fontSize: 26,
                fontStyle:FontStyle.normal,
                fontWeight: FontWeight.normal,
                color: Color.fromRGBO(88, 102, 108, 1)
              )
            ),
          ),
        ),
    );
  }
}