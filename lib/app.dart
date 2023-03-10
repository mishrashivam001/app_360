import 'package:app_360/ui/screen/auth/splash_screen.dart';
// import 'package:app_360/ui/screen/auth/user_register_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'core/constants/app_theme.dart';
import 'core/router/router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class BitCoinApp extends StatefulWidget {
  const BitCoinApp({Key? key}) : super(key: key);

  @override
  State<BitCoinApp> createState() => _BitCoinAppState();
}

class _BitCoinAppState extends State<BitCoinApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      debugPrint('Hello I m here foreground');
    } else if (state == AppLifecycleState.paused) {
      debugPrint('Hello I m here background');
    }
    if (state == AppLifecycleState.detached) {
      debugPrint('Hello I m here in termination');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      onGenerateRoute: Routes.generateRoute,
      home: const SplashScreen(),
      navigatorKey: navigatorKey,
      builder: EasyLoading.init(),
    );
  }
}
