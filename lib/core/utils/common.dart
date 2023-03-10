import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';

const String type = "mobile_funnel";
const String funnelCode = "APP-BTSFT-360-T6";

Future<String?> getToken() async {
  final pref = await SharedPreferences.getInstance();
  String? token = pref.getString('x-api-token');
  if (token != null) {
    return token;
  }
  token = await createToken();
  if (token != null) {
    await pref.setString('x-api-token', token);
  }
  return null;
}

Future<String?> createToken() async {
  final pref = await SharedPreferences.getInstance();

  String? uuid = pref.getString('uuid');
  String? secret = pref.getString('secret');
  int? id = pref.getInt('id');

  if (uuid == null || secret == null || id == null) {
    return null;
  }
  var timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  final json = jsonEncode({
    'id': id,
    'funnelCode': funnelCode,
    'timestamp': timestamp,
    'type': type,
    'uuid': uuid
  });
  print("json :$json");
  final messageBytes = utf8.encode(json);
  final hmac = Hmac(sha256, utf8.encode(secret)); //Save
  final digest = hmac.convert(messageBytes);
  final hmacStr = digest.toString();
  print(hmacStr);
  await pref.setString("hmac", hmacStr);

  final tokenJson = jsonEncode({
    'id': id,
    'funnelCode': funnelCode,
    'hmac': hmacStr,
    'timestamp': timestamp,
    'type': type,
    'uuid': uuid,
  });
  print("tokenJson: $tokenJson");
  final bytes = utf8.encode(tokenJson);
  var xToken = base64.encode(bytes);
  print(xToken);
  return xToken;
}
