import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
 static final String _usesDarkTheme = "usesDarkTheme";
 static final String _numberOfCases = "numberOfCases";

 static Future<bool> getUsesDarkTheme() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
   return prefs.getBool(_usesDarkTheme);
 }

 static Future<bool> setUsesDarkTheme(bool value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
   return prefs.setBool(_usesDarkTheme, value);
 }

  static Future<int> numberOfCases() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
   return prefs.getInt(_numberOfCases);
 }


}