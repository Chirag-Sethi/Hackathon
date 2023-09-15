import 'package:dio/dio.dart';
import 'package:hackathon/core/routes/api_routes.dart';

class AuthRepositary {
  final dio = Dio();

  Future<Map<String, dynamic>> login(
      {required String email, required String password}) async {
    String endpoints = ApiRoutes.signIn;

    Map<String, dynamic> body = {"email": email, "password": password};

    final apiUrl = endpoints;
    final response = await dio.post(apiUrl, data: body);
    return response.data as Map<String, dynamic>;
  }

  // Future<void> logout() async {
  //   final String url = ApiRoutes.logout;
  //   await dio?.post(url);
  // }
}
