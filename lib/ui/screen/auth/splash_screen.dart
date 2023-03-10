// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'package:app_360/core/constants/app_colors.dart';
import 'package:app_360/core/router/screen_routes.dart';
import 'package:app_360/core/utils/sizer.dart';
import 'package:app_360/data/network/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/login_model.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  Future<void> _chekRegistration(BuildContext context) async {
    final pref = await SharedPreferences.getInstance();
    String? data = pref.getString('user_login_data');
    bool remember = pref.getBool('remember_me') ?? false;

    print('reme: $remember $data');
    if (data?.isNotEmpty == true && remember) {
      LoginData loginData = LoginData.fromJson(jsonDecode(data!));
      if (loginData.brands?.isNotEmpty == true) {
        Navigator.pushReplacementNamed(context, ScreenRoutes.dashboardScreen,
            arguments: loginData);
        return;
      }
    } else if (!remember) {
      await pref.setString('user_login_data', '');
    }
    Navigator.pushReplacementNamed(context, ScreenRoutes.userLogin);
  }

  @override
  Widget build(BuildContext context) {
    ApiServices.instance.initApp();
    Timer(const Duration(seconds: 5), () => _chekRegistration(context));
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [
            0.1,
            0.9,
          ],
          colors: [
            AppColors.appIconColor,
            Color.fromARGB(255, 102, 136, 153),
          ],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            SvgPicture.asset(
              "assets/app_logo.svg",
              height: 30.w,
              width: 20.w,
              color: Colors.white,
            ),
            SizedBox(
              height: 2.h,
            ),
            const Spacer(),
            Text(
              "BitSoft",
              style: TextStyle(fontSize: 12.sp, color: Colors.white),
            ),
            SizedBox(
              height: 2.h,
            )
          ],
        ),
      ),
    );
  }
}
