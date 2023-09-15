import 'package:flutter/material.dart';
import 'package:hackathon/features/auth/screens/login_screen.dart';


abstract class RouteName {
  RouteName._();
}

mixin GenerateRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final String? route = settings.name;
    final arguments = settings.arguments;
    switch (route) {
      case '/':
        return MaterialPageRoute(
            builder: (context) => const LoginScreen(), settings: settings);

      // case RouteName.loginScreen:
      //   return MaterialPageRoute(
      //       builder: (context) => const LoginScreen(), settings: settings);

      default:
        return MaterialPageRoute(
            builder: (context) => const LoginScreen(), settings: settings);
    }
  }
}
