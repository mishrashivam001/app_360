import 'dart:convert';
import 'package:app_360/controller/base_view_model.dart';
import 'package:app_360/data/models/chart_list_model.dart';
import 'package:app_360/data/models/login_model.dart';
import 'package:app_360/data/models/user_register_model.dart';
import 'package:app_360/data/network/api_service.dart';
import 'package:app_360/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChartsScreenViewModel extends BaseViewModel {
  final _api = locator<ApiServices>();
  String? _selectCurrency;
  List<String>? _symbolList;
  Brands? _rates;
  Brands? get rates => _rates;

  List<String>? get symbolList => _symbolList;
  String? get selectCurrency => _selectCurrency;

  List<ChartListData>? _chartList;
  List<ChartListData>? get chartList => _chartList;

  bool _isLoadingChart = true;
  bool get isLoadingChart => _isLoadingChart;

  setSelected(String? value) async {
    _selectCurrency = value;

    if (_selectCurrency != null) {
      _isLoadingChart = true;
      notifyListeners();
      final chartData = await _api.chartsData(selectCurrency!);
      if (chartData?.data?.isNotEmpty == true) {
        _chartList = chartData?.data;
        print("length : ${_chartList!.length}");
      }
      _isLoadingChart = false;
      notifyListeners();
    }
  }

  init() async {
    print('ChartsList');
    setLoading();
    final pref = await SharedPreferences.getInstance();
    String? data = pref.getString("user_login_data");
    _symbolList = pref.getStringList('symbols');

    if (data?.isNotEmpty == true) {
      LoginData loginData = LoginData.fromJson(jsonDecode(data!));
      if (loginData.brands?.isNotEmpty == true) {
        _rates = loginData.brands![0];
        print("rates=> $_rates");
      }
    }
    _isLoadingChart = true;
    setSuccess();
    if (symbolList?.isNotEmpty == true) {
      _selectCurrency = _symbolList![0];
    }

    if (_selectCurrency != null) {
      final chartData = await _api.chartsData(selectCurrency!);
      if (chartData?.data?.isNotEmpty == true) {
        _chartList = chartData?.data;
        print("$_chartList");
      }

      _isLoadingChart = false;
      setSuccess();
      return;
    }
    _isLoadingChart = false;
    setError('message');
  }
}
