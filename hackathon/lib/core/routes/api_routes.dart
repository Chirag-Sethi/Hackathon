// ignore_for_file: avoid_classes_with_only_static_members

class ApiRoutes {
  ApiRoutes._();
  static String? baseUrl = 'http://coderhackthon.anlgeview.com/';

  static String signIn = "${baseUrl}user/register";
  static String logIn = "${baseUrl}user/login";
  static String profileUpdate = "${baseUrl}user/update";
  static String getProfile = "${baseUrl}user/get";
  static String getOrganisation = "${baseUrl}organisation/get";
  static String createOrder = "${baseUrl}transaction/create-order";

  // static String baseUrl =
  //     'http://a69cdd17683594bf081db57d8c1b9e1b-1526721927.af-south-1.elb.amazonaws.com';
}
