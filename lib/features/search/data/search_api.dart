import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/endpoints.dart';

class SearchApi {
  Future<Response> search(
      String query,
      ) {
    return ApiClient.dio.get(
      Endpoints.search,
      queryParameters: {
        "q": query,
      },
    );
  }
}