import 'package:hackathon/core/api_client/api_client.dart';
import 'package:hackathon/core/routes/api_routes.dart';

class ProfileRepository {
  Future<Map<String, dynamic>> profileUpdate(
      {required String email,
      required String address,
      required String name,
      required String mobile,
      required String city,
      required String pincode,
      required String state}) async {
    Map<String, dynamic> body = {
      "email": email,
      "name": name,
      "mobile": mobile,
      "state": state,
      "city": city,
      "pincode": pincode,
      "address": address
    };
    Map<String, dynamic> response =
        await ApiClient().patch(ApiRoutes.profileUpdate, body: body);
    return response;
  }

  Future<Map<String, dynamic>> getProfile() async {
    Map<String, dynamic> response = await ApiClient().post(
      ApiRoutes.getProfile,
    );
    return response;
  }
}
