import 'package:app_360/core/utils/sizer.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const ResponsiveApp());
}

class ResponsiveApp extends StatelessWidget {
  const ResponsiveApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) => const BitCoinApp());
  }
}
