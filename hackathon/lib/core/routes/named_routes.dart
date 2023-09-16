import 'package:flutter/material.dart';
import 'package:hackathon/features/Login/screens/Login_screen.dart';
import 'package:hackathon/features/home/screens/home_screen.dart';
import 'package:hackathon/features/login/screens/signup_screen.dart';
import 'package:hackathon/features/login/screens/splash_screen.dart';
import 'package:hackathon/features/profile/screens/profile_screen.dart';

abstract class RouteName {
  RouteName._();
  static const String splashScreen = '/splashScreen';
  static const String loginScreen = '/loginScreen';
  static const String signupScreen = '/signupScreen';
  static const String homeScreen = '/homeScreen';
  static const String profileScreen = '/profileScreen';
}

mixin GenerateRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final String? route = settings.name;
    final arguments = settings.arguments;
    switch (route) {
      case '/':
        return MaterialPageRoute(
            builder: (context) => const SplashScreen(), settings: settings);
      case RouteName.loginScreen:
        return MaterialPageRoute(
            builder: (context) => const LoginScreen(), settings: settings);

      case RouteName.signupScreen:
        return MaterialPageRoute(
            builder: (context) => const SignupScreen(), settings: settings);

      case RouteName.homeScreen:
        return MaterialPageRoute(
            builder: (context) => const HomeScreen(), settings: settings);

      case RouteName.profileScreen:
        return MaterialPageRoute(
            builder: (context) => const ProfileScreen(), settings: settings);

      default:
        return MaterialPageRoute(
            builder: (context) => const LoginScreen(), settings: settings);
    }
  }
}
