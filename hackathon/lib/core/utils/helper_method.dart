import 'package:flutter/material.dart';
import 'package:hackathon/core/auth/auth_repository.dart';
import 'package:hackathon/core/routes/named_routes.dart';
import 'package:hackathon/core/routes/navigator.dart';
import 'package:intl/intl.dart';

abstract class HelperFunctions {
  static bool emailValidator(String email) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@(('
            r'\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+'
            r'\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

extension NameValidator on String {
  bool isValidName() {
    return RegExp(r'/^[A-Za-z\\s]+$/').hasMatch(this);
  }
}

extension PhoneValidator on String {
  bool isValidPhoneNum() {
    return RegExp(r'^[6-9]\d{9}$').hasMatch(this);
  }

  String toMonth() {
    switch (this) {
      case "1":
        return "Jan";
      case "2":
        return "Feb";
      case "3":
        return "Mar";
      case "4":
        return "Apr";
      case "5":
        return "May";
      case "6":
        return "Jun";
      case "7":
        return "Jul";
      case "8":
        return "Aug";
      case "9":
        return "Sept";
      case "10":
        return "Oct";
      case "11":
        return "Nov";
      case "12":
        return "Dec";
      default:
        return this;
    }
  }
}

extension NumberFormat on num? {
  String toOrdinal() {
    switch ((this ?? 0) % 10) {
      case 1:
        return '${this}st';
      case 2:
        return '${this}nd';
      case 3:
        return '${this}rd';
      default:
        return '${this}th';
    }
  }
}

formatDateTime(DateTime dateTime, {String? format}) {
  return DateFormat(format ?? 'yyyy-MM-dd').format(dateTime).toString();
}

// showLoaderDialog(BuildContext context) {
//   showDialog(
//       context: context,
//       barrierDismissible: false,
//       barrierColor: Colors.black.withOpacity(0.3),
//       builder: (cxt) => const Center(child: CustomLoader()));
// }

DateTime joinDateAndTime({required DateTime date, required TimeOfDay time}) {
  return DateTime(date.year, date.month, date.day, time.hour, time.minute);
}

formatedTime({required int time}) {
  int sec = time % 60;
  int min = (time / 60).floor();
  String minute = min.toString().length <= 1 ? "0$min" : "$min";
  String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
  return "$minute : $second";
}



