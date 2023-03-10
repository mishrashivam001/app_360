import 'dart:convert';
import 'package:app_360/controller/base_view_model.dart';
import 'package:app_360/data/models/coins_get_model.dart';
import 'package:app_360/data/models/login_model.dart';
import 'package:app_360/data/models/user_register_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/network/api_service.dart';
import '../../locator.dart';

class PortfolioViewModel extends BaseViewModel {
  final _api = locator<ApiServices>();
  Brands? _rates;
  Brands? get rates => _rates;

  bool _load = true;
  bool get load => _load;

  List<Items>? _items;
  List<Items>? _unfilteredRateLists;
  List<Items>? get items => _items;

  init() async {
    print('rates');
    setLoading();
    final pref = await SharedPreferences.getInstance();
    String? data = pref.getString('user_login_data');

    if (data?.isNotEmpty == true) {
      LoginData loginData = LoginData.fromJson(jsonDecode(data!));
      if (loginData.brands?.isNotEmpty == true) {
        _rates = loginData.brands![0];
      }
    }
    setSuccess();
    _load = true;
    final getCoins = await _api.getCoinsData();
    if (getCoins?.data?.items?.isNotEmpty == true) {
      // GetCoinsData getCoinsData =
      //     GetCoinsData.fromJson(jsonDecode(getCoins!.data!.items![0].symbol!));

      _items = _unfilteredRateLists = getCoins!.data!.items;
      print("Items => $_items");
    }
    _load = false;
    notifyListeners();
  }

  void query(String string) {
    if (string.isEmpty) {
      _items = _unfilteredRateLists;
    } else {
      _items = _unfilteredRateLists
          ?.where((e) => e.symbol?.contains(string) ?? false)
          .toList();
    }
    notifyListeners();
  }
}
