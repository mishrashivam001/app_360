import 'dart:convert';
import 'package:app_360/controller/base_view_model.dart';
import 'package:app_360/data/models/coins_post_response.dart';
import 'package:app_360/data/models/login_model.dart';
import 'package:app_360/data/models/rate_list_model.dart';
import 'package:app_360/data/models/user_register_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/network/api_service.dart';
import '../../locator.dart';

class RatesViewModel extends BaseViewModel {
  final _api = locator<ApiServices>();

  List<RateListData>? _rateLists;

  List<RateListData>? _unfilteredRateLists;
  List<RateListData>? get rateList => _rateLists;

  Brands? _rates;
  Brands? get rates => _rates;

  bool _isLoadingChart = true;
  bool get isLoadingChart => _isLoadingChart;

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

    _isLoadingChart = true;
    setSuccess();
    final rt = await _api.getRatesData();
    if (rt?.data?.isNotEmpty == true) {
      _rateLists = _unfilteredRateLists = rt!.data;

      await pref.setStringList(
          'symbols', _rateLists!.map((e) => e.symbol!).toList());
      // await pref.setString("symbol", rateList![_index].symbol!);
      // String? symbol = pref.getString("symbol");
      // print(symbol);
      print("rateLists => $_rateLists");
    }
    _isLoadingChart = false;

    notifyListeners();
  }

  Future<CoinsPostData?> coinsData(String symbol, String count) async {
    final userCoins = await _api.sendCoins(symbol, count);
    print(userCoins);
    return userCoins;
  }

  void query(String string) {
    if (string.isEmpty) {
      _rateLists = _unfilteredRateLists;
    } else {
      _rateLists = _unfilteredRateLists
          ?.where((e) => e.symbol?.contains(string) ?? false)
          .toList();
    }
    notifyListeners();
  }
}
