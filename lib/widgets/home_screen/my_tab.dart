import 'package:flutter/material.dart';

//Creating my tab for the tabbar
class MyTab extends StatelessWidget{
  final String tabname;

  const MyTab({super.key, required this.tabname});
  @override
  Widget build(BuildContext context){
    return Tab(
      height: 39,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const  Color.fromRGBO(92, 129, 128, 0.09),
          borderRadius: BorderRadius.circular(15)
        ),
        child: Text(tabname))
      );
  }
}