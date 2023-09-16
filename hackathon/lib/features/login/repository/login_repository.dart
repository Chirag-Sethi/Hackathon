import 'package:hackathon/core/api_client/api_client.dart';
import 'package:hackathon/core/routes/api_routes.dart';

class LoginRepository {
  Future<Map<String, dynamic>> signUp(
      {required String email,
      required String password,
      required String name,
      required String mobile}) async {
    Map<String, dynamic> body = {
      "email": email,
      "password": password,
      "name": name,
      "mobile": mobile
    };
    Map<String, dynamic> response =
        await ApiClient().post(ApiRoutes.signIn, body: body);
    return response;
  }

  Future<Map<String, dynamic>> login(
      {required String email, required String password}) async {
    Map<String, dynamic> body = {
      "email": email,
      "password": password,
    };
    Map<String, dynamic> response =
      await ApiClient().post(ApiRoutes.logIn, body: body);
    return response;
  }
}