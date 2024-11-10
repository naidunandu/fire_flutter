import 'package:fire_flutter/routes/route_names.dart';
import 'package:fire_flutter/screens/add_employee.dart';
import 'package:fire_flutter/screens/home.dart';
import 'package:fire_flutter/screens/login.dart';
import 'package:fire_flutter/screens/splash.dart';
import 'package:get/get.dart';

class AppRouteMethods {
  static GetPage<dynamic> getPage({
    required String name,
    required GetPageBuilder page,
    List<GetMiddleware>? middlewares,
  }) {
    return GetPage(
      name: name,
      page: page,
      transition: Transition.topLevel,
      showCupertinoParallax: true,
      middlewares: middlewares ?? [],
      transitionDuration: 350.milliseconds,
    );
  }

  static List<GetPage> pages = [
    getPage(name: AppRouteNames.splash, page: () => const SplashScreen()),
    getPage(name: AppRouteNames.login, page: () => const LoginScreen()),
    getPage(name: AppRouteNames.home, page: () => const HomeScreen()),
    getPage(name: AppRouteNames.addEmployee, page: () => const AddEmployee()),
  ];
}
