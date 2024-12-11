import 'package:flutter/material.dart';

//creating a reusable textbutton 
class TextButtonIconWidget extends StatelessWidget{

  final String buttontext;
  final String routename;
  final Icon icon;
  final Color backgroundcolor;
  final Color outercolor;

  const TextButtonIconWidget({required this.buttontext, required this.routename, required this.icon, required this.backgroundcolor, required this.outercolor});


  @override
  Widget build (BuildContext context){
    return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),

            child: ElevatedButton.icon(
              onPressed: (){
                Navigator.of(context).pushReplacementNamed(routename);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundcolor
              ),
              icon: SizedBox(
                height:30,
                width: 30,
                child: icon),


              label:Text(buttontext,
              style: TextStyle(
                fontFamily: 'EBGaramond',
                fontSize: 26,
                fontStyle:FontStyle.normal,
                fontWeight: FontWeight.normal,
                color: Color.fromRGBO(88, 102, 108, 1)
                )
              ), 
            ),
          
        
    );
  }
}