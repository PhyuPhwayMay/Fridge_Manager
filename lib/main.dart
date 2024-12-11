import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mbap_project_app/firebase_options.dart';
import 'package:mbap_project_app/screens/add_item_screen.dart';
import 'package:mbap_project_app/screens/add_recipe_screen.dart';
import 'package:mbap_project_app/screens/auth_screen.dart';
import 'package:mbap_project_app/screens/calendar_screen.dart';
import 'package:mbap_project_app/screens/edit_item_screen.dart';
import 'package:mbap_project_app/screens/edit_recipe_screen.dart';
import 'package:mbap_project_app/screens/guidelines_screen.dart';
import 'package:mbap_project_app/screens/home_screen.dart';
import 'package:mbap_project_app/screens/profile_screen.dart';
import 'package:mbap_project_app/screens/recipe_feed_screen.dart';
import 'package:mbap_project_app/screens/reset_password_screen.dart';
import 'package:mbap_project_app/services/firebase_messaging.dart';
import 'package:mbap_project_app/services/firebase_service.dart';
import 'package:mbap_project_app/services/theme_service.dart';
import 'package:mbap_project_app/widgets/themedata.dart/light_theme.dart';

final navigatorKey = GlobalKey<NavigatorState>(); 
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  GetIt.instance.registerLazySingleton(() => FirebaseService());
  GetIt.instance.registerLazySingleton(() => ThemeService());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseService fbService = GetIt.instance<FirebaseService>();
  final ThemeService themeService = GetIt.instance<ThemeService>();
  @override
  Widget build(BuildContext context) {

    themeService.loadTheme();

    return StreamBuilder<User?>(
      stream: fbService.getAuthUser(),
      builder: (context, snapshot) {
        return StreamBuilder<ThemeData>(
          stream: themeService.getThemeStream(),
          initialData: lightTheme,
          builder: (contextTheme, snapshotTheme) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: snapshotTheme.data ?? ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor:  Color(0xfff0efe2)),
                useMaterial3: true,
              ),
              home: snapshot.connectionState != ConnectionState.waiting && snapshot.hasData? HomeScreen() : AuthScreen(),
              routes: {
                HomeScreen.routeName : (_){return HomeScreen();},
                RecipeFeedScreen.routeName : (_){return RecipeFeedScreen();},
                GuidelinesScreen.routeName : (_){return GuidelinesScreen();},
                ProfileScreen.routeName : (_){return ProfileScreen();},
                AddItemScreen.routeName:(_){return AddItemScreen();},
                EditItemScreen.routeName:(_){return EditItemScreen();},
                AddRecipeScreen.routeName:(_){return AddRecipeScreen();},
                EditRecipeScreen.routeName:(_){return EditRecipeScreen();},
                AuthScreen.routeName: (_){return AuthScreen();},
                ResetPasswordScreen.routeName:(_){return ResetPasswordScreen();},
                CalendarScreen.routeName: (_){return CalendarScreen();}
              },
            );
          }
        );
      }
    );
  }
}