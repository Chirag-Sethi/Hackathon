import 'package:hackathon/core/api_client/api_client.dart';
import 'package:hackathon/core/routes/api_routes.dart';

class HomeRepository {
  Future<Map<String, dynamic>> organizationList() async {
   
    Map<String, dynamic> response =
        await ApiClient().get(ApiRoutes.getOrganisation,);
    return response;
  }

   Future<Map<String, dynamic>> createOrder(
      {required String id, required int amount}) async {
    Map<String, dynamic> body = {
      "id": id,
      "amount": amount,
    };
    Map<String, dynamic> response =
      await ApiClient().post(ApiRoutes.createOrder, body: body);
    return response;
  }
}
