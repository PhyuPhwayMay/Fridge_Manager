
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mbap_project_app/widgets/themedata.dart/dark_theme.dart';
import 'package:mbap_project_app/widgets/themedata.dart/light_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  StreamController<ThemeData> themeStreamController = StreamController<ThemeData>.broadcast();
  SharedPreferences? prefs;

  Stream<ThemeData> getThemeStream(){
    return themeStreamController.stream;
  }

  void setTheme (ThemeData selectedTheme, String stringTheme){
    themeStreamController.add(selectedTheme);
    prefs!.setString('selectedTheme', stringTheme);
    debugPrint("Theme: "+ stringTheme);
  }

  void loadTheme() async {
    prefs = await SharedPreferences.getInstance();
    ThemeData currentTheme = lightTheme;

    if(prefs!.containsKey('selectedTheme')){
      String? selectedTheme = prefs!.getString('selectedTheme');
      if (selectedTheme == 'light') currentTheme = lightTheme;
      if (selectedTheme == 'dark') currentTheme = darkTheme;
    }

    themeStreamController.add(currentTheme);
  }
}