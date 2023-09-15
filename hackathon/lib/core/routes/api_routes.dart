// ignore_for_file: avoid_classes_with_only_static_members

class ApiRoutes {
  ApiRoutes._();
  static String? baseUrl = 'https://api.iprep.in/cc/';

  static String signIn = "${baseUrl}auth/login";
  // static String baseUrl =
  //     'http://a69cdd17683594bf081db57d8c1b9e1b-1526721927.af-south-1.elb.amazonaws.com';

  // static String mainUrl = '$baseUrl/api/v1/';
  // static String login = '${mainUrl}operator/login';
}
