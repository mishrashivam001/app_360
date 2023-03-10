import 'package:app_360/controller/view_models/chart_screen_viewmodel.dart';
import 'package:app_360/controller/view_models/portfolio_view_model.dart';
import 'package:app_360/controller/view_models/rate_view_model.dart';
import 'package:app_360/controller/view_models/user_register_view_model.dart';
// import 'package:app_360/ui/screen/auth/user_register_screen.dart';
import 'package:get_it/get_it.dart';
import 'controller/view_models/login_view_model.dart';
import 'data/network/api_service.dart';

GetIt locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => ApiServices.instance);
  locator.registerFactory(() => LoginViewModel());
  locator.registerFactory(() => ChartsScreenViewModel());
  locator.registerFactory(() => UserRegisterViewModel());
  locator.registerFactory(() => RatesViewModel());
  locator.registerFactory(() => PortfolioViewModel());
}
