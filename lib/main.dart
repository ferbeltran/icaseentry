import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icaseentry/pages/home.dart';
import 'package:icaseentry/pages/login.dart';
import 'package:icaseentry/pages/settings.dart';
import 'package:icaseentry/utils/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';




bool usesDarkTheme; 
SharedPreferences preferences;

void main() async {
  preferences = await SharedPreferences.getInstance();
  usesDarkTheme = preferences.getBool("usesDarkTheme") ?? false;
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  
  runApp(CaseEntryApp());
}

class CaseEntryApp extends StatelessWidget {

  Widget _showLoginOrHomePage(ThemeBloc themeBloc) {
    if (preferences.getBool('isLogged') == true)
      return HomePage(themeBloc: themeBloc);
    else {
      return LoginPage();
    }
  }

  @override
  Widget build(BuildContext context) {

    final ThemeBloc themeBloc = ThemeBloc();
    return StreamBuilder<ThemeData>(
      initialData: usesDarkTheme ? themeBloc.darkTheme().data : themeBloc.lightTheme().data,
      stream: themeBloc.themeDataStream,
      builder: (context, snapshot) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: _showLoginOrHomePage(themeBloc),
          routes: <String, WidgetBuilder>{
            '/login': (BuildContext context) => LoginPage(),
            '/home': (BuildContext context) => HomePage(themeBloc: themeBloc,),
            '/settings': (BuildContext context) => SettingsPage(themeBloc: themeBloc,)
          },
          theme: snapshot.data,
      )
    );
  }
}
