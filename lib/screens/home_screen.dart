import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mbap_project_app/screens/guidelines_screen.dart';
import 'package:mbap_project_app/screens/profile_screen.dart';
import 'package:mbap_project_app/screens/recipe_feed_screen.dart';
import 'package:mbap_project_app/services/firebase_service.dart';
import 'package:mbap_project_app/widgets/bottom_navbar_widget.dart';
import 'package:mbap_project_app/widgets/home_screen/main_column1_widget.dart';

class HomeScreen extends StatefulWidget{
  static String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  //setting the currentindex
  int _currentIndex = 0;

  //list of screens for the bottom nav bar to load
  final List<Widget> _screens = [
    MainColumnWidget(), //contains the home screen items
    RecipeFeedScreen(),
    GuidelinesScreen(),
    ProfileScreen()
  ];

  //changning the index to the screen that is currently selected
  void _onTabSelected (int index){
    setState((){
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: _screens[_currentIndex]
        ),
      bottomNavigationBar: BottomNavBarWidget(currentIndex: _currentIndex, onTabSelected: _onTabSelected),

    );
  }
}