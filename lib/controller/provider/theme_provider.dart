import 'package:shared_preferences/shared_preferences.dart';

class MyThemePreferences {
  static const THEME_KEY = "theme_key";
  setTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(THEME_KEY, value);
  }

  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(THEME_KEY) ?? false;
  }

  static Future setMobileNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('mobileNumber', "8888888888");
  }

  static Future getMobileNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? intValue = prefs.getString('mobileNumber');
    return intValue;
  }

  static Future saveGender(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('gender', value);
  }

  static Future getGender() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? gender = prefs.getString('gender');
    return gender;
  }
}
