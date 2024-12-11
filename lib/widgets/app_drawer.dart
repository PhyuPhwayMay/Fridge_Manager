import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mbap_project_app/screens/calendar_screen.dart';
import 'package:mbap_project_app/services/theme_service.dart';
import 'package:mbap_project_app/widgets/themedata.dart/dark_theme.dart';
import 'package:mbap_project_app/widgets/themedata.dart/light_theme.dart';

class AppDrawer extends StatelessWidget{

  ThemeService themeService = GetIt.instance<ThemeService>();
  @override
  Widget build (BuildContext context){
    return Drawer(
    child: Column(
      children: [
        AppBar(
          title: const Text("Drawer"),
        ),
        
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Themes'),
              TextButton(onPressed: (){themeService.setTheme(lightTheme, 'light');}, child: Text("light")),
              TextButton(onPressed: (){themeService.setTheme(darkTheme, 'dark');}, child: Text("dark"))
            ],
          )
        ),
        ListTile(
          leading: Icon(Icons.calendar_month),
          title: Text('Calendar'),
          onTap: () => Navigator.of(context).pushNamed(CalendarScreen.routeName),
        )
      ],),
    );
  }
}