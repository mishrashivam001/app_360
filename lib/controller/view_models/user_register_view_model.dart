import 'dart:convert';

import 'package:app_360/controller/base_view_model.dart';
import 'package:app_360/core/constants/data.dart';
import 'package:app_360/core/utils/common.dart';
import 'package:app_360/data/database/data.dart';
import 'package:app_360/data/models/ip_model.dart';
import 'package:app_360/data/network/api_service.dart';
import 'package:app_360/locator.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/login_model.dart';
import '../../data/models/user_register_model.dart';

class UserRegisterViewModel extends BaseViewModel {
  final ApiServices _api = locator<ApiServices>();
  String _prefix = '';
  bool _isChecked = false;
  String _password = '';
  IpData? _ipData;
  String? _ip;

  String get prefix => _prefix;
  bool get isChecked => _isChecked;
  String get password => _password;

  init() async {
    setLoading();
    _ip = await Ipify.ipv4();

    if (_ip == null) {
      setError('message');
      return;
    }
    print(_ip);
    _ipData = await _api.loadIp(_ip!);
    if (_ipData == null) {
      setError('message');
      return;
    }
    _prefix = _ipData!.prefix?.toString() ?? '';
    await getToken();
    setSuccess();
  }

  // Future check() async {
  //   try {
  //     final responseRegisterUser =
  //         UserRegisterResponse.fromJson(registerResponse);
  //     print(responseRegisterUser.data?.toJson());
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  Future<LoginData?> register(String fName, String lName, String email,
      String phone, String password) async {
    print('register');
    final userRegister = await _api.registerUser(fName, lName, email, password,
        phone, _ipData?.prefix ?? 0, _ipData?.iSO2 ?? '', _ip!);

    if (userRegister != null) {
      print(userRegister);

      final pref = await SharedPreferences.getInstance();
      LoginData loginData = LoginData.fromJson(userRegister.toJson());
      await pref.setString('user_login_data', jsonEncode(loginData.toJson()));
      return loginData;
    }
    // return userRegister;
    // if (userRegister != null) {
    //   setSuccess();
    // } else {
    //   // setError('Error ');
    // }
    // notifyListeners();
  }

  setCheckbox(bool isChecked) {
    _isChecked = isChecked;
    notifyListeners();
  }

  setPassword(String password) {
    _password = password;
    notifyListeners();
  }
}
