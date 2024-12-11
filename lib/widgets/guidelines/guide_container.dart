import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mbap_project_app/models/guide.dart';

//creating guide container for the guide screen
class GuideContainer extends StatelessWidget{

  final Guide guide; //importing Guide model as guide

  GuideContainer({required this.guide}); 


  @override
  Widget build(BuildContext context){
    return TextButton(
      onPressed: () {
        debugPrint('Tapped');
      },

      style: TextButton.styleFrom(
        shape:ContinuousRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: EdgeInsets.all(10),
        backgroundColor: Color.fromRGBO(92, 129, 128, 0.11),
        fixedSize: Size(380, 100),
      ),
      
      child: Text(
        guide.question, //displaying the question of the current Index
        maxLines: 2,
        style: TextStyle(
        fontFamily: 'EBGaramond',
        fontSize: 28,
        fontStyle:FontStyle.normal,
        fontWeight: FontWeight.w500,
        color: Color.fromRGBO(92, 129, 128, 1)
        ),
      ),
    );
  }
}