import '../../../core/api/api_client.dart';

class VendorApi {
  Future<dynamic> getVendor(int id) async {
    final url = "/vendors/$id/";

    print("REQUEST:");
    print(ApiClient.dio.options.baseUrl + url);

    final response = await ApiClient.dio.get(url);

    print(response.statusCode);
    print(response.data);

    return response;
  }
}