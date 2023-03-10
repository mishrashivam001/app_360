import 'package:app_360/data/models/login_model.dart';
import 'package:app_360/ui/screen/auth/forgot_pass_screen.dart';
import 'package:app_360/ui/screen/auth/user_register_screen.dart';
import 'package:app_360/ui/screen/home/charts_screen.dart';
import 'package:app_360/ui/screen/home/dashboard_screen.dart';
import 'package:app_360/ui/screen/home/portfolio_screen.dart';
import 'package:app_360/ui/screen/home/rates_screen.dart';
import 'package:flutter/material.dart';
import '../../data/models/user_register_model.dart';
import '../../ui/screen/auth/user_login_screen.dart';
import 'screen_routes.dart';

class Routes {
  static Route generateRoute(RouteSettings settings) {
    final Widget screen;
    switch (settings.name) {
      case ScreenRoutes.userRegistration:
        screen = UserRegisterScreen();
        break;

      case ScreenRoutes.userLogin:
        screen = UserLoginScreen();
        break;

      case ScreenRoutes.ratesScreen:
        screen = RatesScreen();
        break;
      case ScreenRoutes.portfolioScreen:
        screen = PortFolioScreen();
        break;
      case ScreenRoutes.chatsScreen:
        screen = const ChartsScreen();
        break;
      case ScreenRoutes.dashboardScreen:
        if (settings.arguments is LoginData) {
          final LoginData data = settings.arguments as LoginData;
          screen = MyDashboard(
            data: data,
          );
        } else {
          screen = _parameterMissing();
        }
        break;
      case ScreenRoutes.forgotPassScreen:
        screen = ForgetPassScreen();
        break;
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('No routes defined for ${settings.name} yet.'),
            ),
          ),
        );
    }
    return MaterialPageRoute(builder: (context) => screen);
  }

  static Widget _parameterMissing() {
    return const Scaffold(
      body: Center(
        child: Text('Not a valid parameter passed'),
      ),
    );
  }
}
