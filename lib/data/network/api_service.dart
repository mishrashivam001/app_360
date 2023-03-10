import 'dart:convert';
// import 'package:app_360/controller/view_models/user_register_view_model.dart';
import 'package:app_360/core/utils/common.dart';
import 'package:app_360/data/models/chart_list_model.dart';
import 'package:app_360/data/models/coins_get_model.dart';
import 'package:app_360/data/models/coins_post_response.dart';
import 'package:app_360/data/models/ip_model.dart';
import 'package:app_360/data/models/login_model.dart';
import 'package:app_360/data/models/rate_list_model.dart';
import 'package:app_360/data/models/user_register_model.dart';
// import 'package:dart_ipify/dart_ipify.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:wifi_info_plugin_plus/wifi_info_plugin_plus.dart';
import 'package:app_360/data/models/register_app_model.dart';
import 'package:http/http.dart' as https;
import 'package:uuid/uuid.dart';
// ignore: depend_on_referenced_packages

class ApiServices {
  static ApiServices instance = ApiServices._();
  final url = "https://api.planetgraphdevs.top/";
  final urlRates = "http://46.166.131.77/api.php";

  String? _authToken;

  ApiServices._();

  Future regenerateToken() async {
    final pref = await SharedPreferences.getInstance();

    _authToken = await createToken();
    print(_authToken);
    if (_authToken != null) {
      await pref.setString('x-api-token', _authToken!);
    }
  }

  Future<bool> initApp() async {
    String? token = await getToken();
    if (token != null) {
      _authToken = token;
      return true;
    }

    final uuid = const Uuid().v4();
    try {
      final response = await https.post(
        Uri.parse("${url}mobile-apps/register"),
        body: {
          'Name': 'Mobile Funnel',
          'uuid': uuid,
        },
      );
      if (response.statusCode == 200) {
        final responseRegisterApp =
            ResgisterApp.fromJson(jsonDecode(response.body));
        if (responseRegisterApp.data != null) {
          final pref = await SharedPreferences.getInstance();
          await pref.setInt('id', responseRegisterApp.data?.id ?? 0);
          await pref.setString('uuid', uuid);
          await pref.setString(
              'secret', responseRegisterApp.data?.secret ?? '');
          await pref.setString(
              'app', jsonEncode(responseRegisterApp.data!.toJson()));
          // print(responseRegisterApp.data!.secret);
          // print(responseRegisterApp.data!.id);
          _authToken = await createToken();
          print(_authToken);
          return _authToken != null;
        }
      }

      // Handle the response from the server here
    } catch (e) {
      // Handle any errors that may occur during the request here
    }
    return false;
  }

  Future<IpData?> loadIp(String ip) async {
    try {
      final token = _authToken;
      if (token == null) return null;
      Map<String, String> headers = {
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "application/json",
        "X-Api-Token": token,
      };

      final response = await https.get(
          Uri.parse(
            "${url}geo-ip/$ip",
          ),
          headers: headers);
      if (response.statusCode == 401) {
        _authToken = null;
        await regenerateToken();
        return loadIp(ip);
      }
      // if (response.statusCode == 200) {
      print('response=> ${response.body}');

      IpResponse ipResponse = IpResponse.fromJson(jsonDecode(response.body));
      if (ipResponse.data != null) {
        IpData? data = IpResponse.fromJson(jsonDecode(response.body)).data;
        final pref = await SharedPreferences.getInstance();
        await pref.setInt('prefix', data?.prefix ?? 0);
        await pref.setString('country', data?.name ?? '');
        return data;
      } else if (ipResponse.error != null &&
          ipResponse.error == 'Expired API Token') {
        _authToken = null;
        await regenerateToken();
        return loadIp(ip);
      }
      // } else {
      //   print('response=> ${response.statusCode} , ${response.body}');
      // }
      // Handle the response from the server here
    } catch (e) {
      // Handle any errors that may occur during the request here
    }
    return null;
  }

  Future<UserRegisterData?> registerUser(
      String fName,
      String lName,
      String email,
      String password,
      String phone,
      int prefix,
      String country,
      String ip) async {
    try {
      final token = _authToken;
      if (token == null) return null;
      Map<String, String> headers = {
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "application/json",
        "X-Api-Token": token,
      };
      print(token);
      print('Register called');
      final pref = await SharedPreferences.getInstance();
      String? userAgent;

      try {
        await FkUserAgent.init();
        userAgent = FkUserAgent.userAgent;
        print(FkUserAgent.userAgent);
      } catch (e) {
        print('Error agent: $e');
      }

      int? id = pref.getInt('id');
      print('ID: $id');
      final data = jsonEncode({
        'FirstName': fName,
        'LastName': lName,
        'Email': email,
        'Password': password,
        'Phone': phone,
        'PhonePrefix': prefix.toString(),
        'Country': country,
        'UserAgent': userAgent ??
            'Mozilla/5.0 (Linux; Android 5.1.1; SM-G928X Build/LMY47X) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.83 Mobile Safari/537.36',
        'ClientIp': ip,
        'LoggedIn': 'true',
        // 'PhonePrefix':loadIp().pre,
      });
      print('ID: $data');

      final response = await https.post(
          Uri.parse("${url}mobile-apps/$id/user-register"),
          body: data,
          headers: headers);
      // print("url=> ${url}mobile-apps/$id/user-register");
      print(
          'response=> ${response.statusCode}  ${response.request!.url.toString()} , ${response.body}');
      if (response.statusCode >= 200 && response.statusCode < 500) {
        if (response.statusCode == 401) {
          _authToken = null;
          await regenerateToken();
          return registerUser(
              fName, lName, email, password, ip, prefix, phone, country);
        }
        final responseRegisterUser =
            UserRegisterResponse.fromJson(jsonDecode(response.body));
        if (responseRegisterUser.data != null) {
          final pref = await SharedPreferences.getInstance();
          await pref.setString(
              'userRegister', jsonEncode(responseRegisterUser.data!.toJson()));
          debugPrint(responseRegisterUser.data.toString());
          return responseRegisterUser.data;
        }
      } else {
        print('response=> ${response.statusCode} , ${response.body}');
      }
    } catch (e) {
      print('error=> $e');
      // Handle any errors that may occur during the request here
    }
    return null;
  }

  Future<LoginData?> loginwithEmail(String email, String password) async {
    try {
      final token = _authToken;
      if (token == null) return null;
      Map<String, String> headers = {
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "application/json",
        "X-Api-Token": token,
      };
      print(token);
      print('Login called');
      final pref = await SharedPreferences.getInstance();

      int? id = pref.getInt('id');
      print('ID: $id');
      final loginData = jsonEncode({
        'Email': email,
        'Password': password,
      });
      print('ID: $loginData');

      final response = await https.post(
          Uri.parse("${url}mobile-apps/$id/login"),
          body: loginData,
          headers: headers);
      print(
          'response=> ${response.statusCode}  ${response.request!.url.toString()} , ${response.body}');
      if (response.statusCode >= 200 && response.statusCode < 500) {
        if (response.statusCode == 401) {
          _authToken = null;
          await regenerateToken();
          return loginwithEmail(email, password);
        }
        final responseLoginUser =
            LoginResponse.fromJson(jsonDecode(response.body));
        if (responseLoginUser.data != null) {
          // final pref = await SharedPreferences.getInstance();
          // await pref.setString(
          //     'userLogin', jsonEncode(responseLoginUser.data!.toJson()));
          debugPrint(responseLoginUser.data.toString());
          return responseLoginUser.data;
        }
      } else {
        print('response=> ${response.statusCode} , ${response.body}');
      }
    } catch (e) {
      print('error=> $e');
      // Handle any errors that may occur during the request here
    }
    return null;
  }

  Future<RateListResponse?> getRatesData() async {
    try {
      final token = _authToken;
      if (token == null) return null;
      Map<String, String> headers = {
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "application/json",
      };
      print(token);
      print('user called');
      final pref = await SharedPreferences.getInstance();
      int? id = pref.getInt('id');
      print('ID: $id');

      Map<String, dynamic> rateData = {
        "Auth": token.toString(),
        "UserID": id.toString(),
        "Service": "getRates"
      };

      Uri rateUri = Uri.parse(urlRates);
      final finalUri = rateUri.replace(queryParameters: rateData);
      final response = await https.get(
        finalUri,
        headers: headers,
      );

      print(
          'response=> ${response.statusCode}  ${response.request!.url.toString()} , ${response.body}');
      if (response.statusCode >= 200 && response.statusCode < 500) {
        if (response.statusCode == 401) {
          _authToken = null;
          await regenerateToken();
          print("auth Token=> $_authToken");
          return getRatesData();
        }
        final rateListResponse =
            RateListResponse.fromJson(jsonDecode(response.body));
        debugPrint(rateListResponse.toString());
        return rateListResponse;
      } else {
        print('response=> ${response.statusCode} , ${response.body}');
      }
    } catch (e) {
      print('error=> $e');
      // Handle any errors that may occur during the request here
    }
    return null;
  }

  Future<ChartListResponse?> chartsData(String symbol) async {
    try {
      final token = _authToken;
      if (token == null) return null;
      Map<String, String> headers = {
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "application/json",
      };
      print(token);
      print('user called');
      final pref = await SharedPreferences.getInstance();
      int? id = pref.getInt('id');
      print('ID: $id');

      Map<String, dynamic> rateData = {
        "Auth": token.toString(),
        "UserID": id.toString(),
        "Service": "getHistoricalRate",
        "Symbol": symbol.toString(),
      };

      Uri rateUri = Uri.parse(urlRates);
      final finalUri = rateUri.replace(queryParameters: rateData);
      final response = await https.get(
        finalUri,
        headers: headers,
      );

      print(
          'response=> ${response.statusCode}  ${response.request!.url.toString()} , ${response.body}');
      if (response.statusCode >= 200 && response.statusCode < 500) {
        // if (response.statusCode == 401) {
        //   _authToken = null;
        //   await regenerateToken();
        // }
        if (response.statusCode == 401) {
          _authToken = null;
          await regenerateToken();
          return chartsData(symbol);
        }
        final rateListResponse =
            ChartListResponse.fromJson(jsonDecode(response.body));
        if (rateListResponse.data?.isNotEmpty == true) {
          debugPrint(rateListResponse.toString());
          return rateListResponse;
        }
      } else {
        print('response=> ${response.statusCode} , ${response.body}');
      }
    } catch (e) {
      print('error=> $e');
      // Handle any errors that may occur during the request here
    }
    return null;
  }

  Future<CoinsPostData?> sendCoins(String symbol, String count) async {
    try {
      final token = _authToken;
      if (token == null) return null;
      Map<String, String> headers = {
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "application/json",
        "X-Api-Token": token,
      };
      print(token);
      print('Login called');
      final pref = await SharedPreferences.getInstance();

      int? id = pref.getInt('id');
      print('ID: $id');
      final coinsData = jsonEncode({
        'Symbol': symbol,
        'Count': count.toString(),
      });
      print('ID: $coinsData');

      final response = await https.post(
          Uri.parse("${url}mobile-apps/$id/coins"),
          body: coinsData,
          headers: headers);
      print(
          'response=> ${response.statusCode}  ${response.request!.url.toString()} , ${response.body}');
      if (response.statusCode >= 200 && response.statusCode < 500) {
        if (response.statusCode == 401) {
          _authToken = null;
          await regenerateToken();
          return sendCoins(symbol, count);
        }
        final responseLoginUser =
            CoinsResponse.fromJson(jsonDecode(response.body));
        if (responseLoginUser.data != null) {
          // final pref = await SharedPreferences.getInstance();
          // await pref.setString(
          //     'userLogin', jsonEncode(responseLoginUser.data!.toJson()));
          debugPrint(responseLoginUser.data.toString());
          return responseLoginUser.data;
        }
      } else {
        print('response=> ${response.statusCode} , ${response.body}');
      }
    } catch (e) {
      print('error=> $e');
      // Handle any errors that may occur during the request here
    }
    return null;
  }

  Future<CoinsGetResponse?> getCoinsData() async {
    try {
      final token = _authToken;
      if (token == null) return null;
      Map<String, String> headers = {
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "application/json",
        "X-Api-Token": token
      };
      print(token);
      print('user called');
      final pref = await SharedPreferences.getInstance();
      int? id = pref.getInt('id');
      print('ID: $id');

      Map<String, dynamic> rateData = {"expand": "info"};

      Uri rateUri = Uri.parse("${url}mobile-apps/$id/coins");
      final finalUri = rateUri.replace(queryParameters: rateData);
      final response = await https.get(
        finalUri,
        headers: headers,
      );

      print(
          'response=> ${response.statusCode}  ${response.request!.url.toString()} , ${response.body}');
      if (response.statusCode >= 200 && response.statusCode < 500) {
        if (response.statusCode == 401) {
          _authToken = null;
          await regenerateToken();
          print("auth Token=> $_authToken");
          return getCoinsData();
        }
        final coinsListResponse =
            CoinsGetResponse.fromJson(jsonDecode(response.body));
        debugPrint(coinsListResponse.toString());
        return coinsListResponse;
      } else {
        print('response=> ${response.statusCode} , ${response.body}');
      }
    } catch (e) {
      print('error=> $e');
      // Handle any errors that may occur during the request here
    }
    return null;
  }
}



//tXBsQg9YkYj6xOICajxf0PScZo9UIKWH
// {"id":1563027,"funnelCode":"APP-BTSFT-360-T6","timestamp":1676457423,"type":"mobile_funnel","uuid":"a5a7fd70-5f06-4fab-91c2-f14d7dbe3276"}
// hmac: c0b910cb1762c0408bdb826fe6b52744682593304ad69fd968f899971a4fac63
// tokenJson: {"id":1563027,"funnelCode":"APP-BTSFT-360-T6","hmac":"c0b910cb1762c0408bdb826fe6b52744682593304ad69fd968f899971a4fac63","timestamp":1676457423,"type":"mobile_funnel","uuid":"a5a7fd70-5f06-4fab-91c2-f14d7dbe3276"}
//  eyJpZCI6MTU2MzAyNywiZnVubmVsQ29kZSI6IkFQUC1CVFNGVC0zNjAtVDYiLCJobWFjIjoiYzBiOTEwY2IxNzYyYzA0MDhiZGI4MjZmZTZiNTI3NDQ2ODI1OTMzMDRhZDY5ZmQ5NjhmODk5OTcxYTRmYWM2MyIsInRpbWVzdGFtcCI6MTY3NjQ1NzQyMywidHlwZSI6Im1vYmlsZV9mdW5uZWwiLCJ1dWlkIjoiYTVhN2ZkNzAtNWYwNi00ZmFiLTkxYzItZjE0ZDdkYmUzMjc2In0=
// {"success":true,"data":{"id":99,"Name":"India","ISO2":"IN","ISO3":"IND","Prefix":91,"Flag":"https://countryflagsapi.com/png/in"}}
