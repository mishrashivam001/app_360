import 'package:flutter/material.dart';

import '../../core/constants/app_theme.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData = AppTheme.lightTheme;

  ThemeData getTheme() => _themeData;

  void toggleTheme() {
    _themeData = _themeData == AppTheme.darkTheme
        ? AppTheme.lightTheme
        : AppTheme.darkTheme;
    notifyListeners();
  }
}
