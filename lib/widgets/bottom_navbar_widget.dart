import 'package:flutter/material.dart';

class BottomNavBarWidget extends StatelessWidget{
  final int currentIndex;
  final Function(int) onTabSelected;

  BottomNavBarWidget({required this.currentIndex, required this.onTabSelected});
  

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color.fromRGBO(14, 61, 67, 0.46),
      unselectedItemColor: Color.fromRGBO(88, 102, 108, 1),
      selectedItemColor: Color.fromRGBO(14, 61, 67, 1),
      currentIndex: currentIndex,
      onTap: onTabSelected,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant_menu_outlined),
          label: 'Recipe Book'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Guidelines'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile'
        ),
      ]
    );
  }
}

