import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
      appBarTheme: const AppBarTheme(
        titleTextStyle: lightHeadingText1,
        color: AppColors.darkSecondaryColor,
        iconTheme: IconThemeData(color: AppColors.lightOnPrimaryColor),
      ),
      colorScheme: const ColorScheme.light(
        primary: AppColors.iconTopColor,
        secondary: AppColors.iconMidColor,
        onSecondary: AppColors.iconMidColor,
        onPrimary: AppColors.lightOnPrimaryColor,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.iconTopColor,
      ),
      textTheme: _lightTextTheme,
      dividerTheme: const DividerThemeData(color: Colors.black12));

  static final ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.darkPrimaryVariantColor,
      // brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        color: AppColors.darkPrimaryVariantColor,
        titleTextStyle: darkHeadingText1,
        iconTheme: IconThemeData(color: AppColors.darkSecondaryColor),
      ),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.darkPrimaryColor,
        secondary: AppColors.darkSecondaryColor,
        onPrimary: AppColors.darkSecondaryColor,
        background: Colors.white12,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.iconTopColor,
      ),
      textTheme: _darkTextTheme,
      dividerTheme: const DividerThemeData(color: Colors.black));

  static const TextTheme _lightTextTheme = TextTheme(
    headline1: lightHeadingText1,
  );

  static const TextTheme _darkTextTheme = TextTheme(
    headline1: darkHeadingText1,
  );

  static const TextStyle lightHeadingText1 = TextStyle(
      fontSize: 26.0,
      fontWeight: FontWeight.bold,
      color: AppColors.lightOnPrimaryColor,
      fontFamily: "Roboto");

  static const TextStyle darkHeadingText1 = TextStyle(
      fontSize: 26.0,
      fontWeight: FontWeight.bold,
      color: AppColors.darkSecondaryColor,
      fontFamily: "Roboto");
}
