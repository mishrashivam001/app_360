import 'dart:convert';

import 'package:app_360/data/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/network/api_service.dart';
import '../../locator.dart';
import '../base_view_model.dart';

class LoginViewModel extends BaseViewModel {
  final _api = locator<ApiServices>();
  bool _isChecked = false;

  bool get isChecked => _isChecked;

  Future<LoginData?> login(String email, String password) async {
    final userLogin = await _api.loginwithEmail(
      email,
      password,
    );

    if (userLogin != null) {
      final pref = await SharedPreferences.getInstance();
      await pref.setString('user_login_data', jsonEncode(userLogin.toJson()));
      await pref.setString('loggedIn', userLogin.refreshToken ?? '');
      await pref.setInt('userId', userLogin.userID ?? 0);
      await pref.setString('userEmail', userLogin.email ?? '');
      // await pref.setString('userEmail', userLogin. ?? '');
      await pref.setBool('remember_me', _isChecked);
      print('ffff$_isChecked');
    }
    print(userLogin);
    return (userLogin);
  }

  setCheckbox(bool isChecked) {
    _isChecked = isChecked;
    notifyListeners();
  }
}
