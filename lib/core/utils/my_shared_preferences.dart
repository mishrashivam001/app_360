// import 'dart:convert';
// import 'package:app_360/data/models/register_app_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MySharedPreferences {
//   static Future<void> setRegisterAppData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final registerAppData = RegisterAppData.fromJson({

//     });
//     final jsonString = json.encode(registerAppData);
//     prefs.setString('myJsonData', jsonString);
//   }

//   static Future getRegisterAppData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? intValue = prefs.getString('mobileNumber');
//     return intValue;
//   }
// }
