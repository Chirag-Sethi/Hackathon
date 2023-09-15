import 'package:flutter/material.dart';

mixin AnywhereDoor {
  static void pushReplacementNamed(BuildContext context,
          {required String routeName, dynamic arguments}) =>
      Future<void>.microtask(() {
        Navigator.pushReplacementNamed(context, routeName,
            arguments: arguments);
      });
  static void pushNamed(BuildContext context,
          {required String routeName, dynamic arguments}) =>
      Future<void>.microtask(() {
        Navigator.pushNamed(context, routeName, arguments: arguments);
      });
  static void pop(BuildContext context, {dynamic result}) =>
      Future<void>.microtask(() {
        Navigator.pop(context, result);
      });
  static void popUntil(BuildContext context, {required String routeName}) =>
      Future<void>.microtask(() {
        Navigator.popUntil(context, ModalRoute.withName(routeName));
      });
  static void pushNamedAndRemoveUntil(BuildContext context,
          {required String routeName,
          required bool Function(Route<dynamic>) predicate,
          dynamic arguments}) =>
      Future<void>.microtask(() {
        Navigator.pushNamedAndRemoveUntil(
            context, routeName, (Route<dynamic> val) => false,
            arguments: arguments);
      });
}