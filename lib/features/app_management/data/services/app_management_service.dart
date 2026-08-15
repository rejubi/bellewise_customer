import 'package:dio/dio.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/api/endpoints.dart';

class AppManagementService {
  AppManagementService._();

  static final AppManagementService instance =
  AppManagementService._();

  final Dio _dio = ApiClient.dio;

  // ==========================================================
  // CONTENT
  // ==========================================================

  Future<List<dynamic>> getContent() async {
    final response = await _dio.get(
      Endpoints.appContent,
      queryParameters: {
        "target_app": "CUSTOMER",
      },
    );

    return response.data as List<dynamic>;
  }

  Future<Map<String, dynamic>> getContentBySlug(
      String slug,
      ) async {
    final response = await _dio.get(
      Endpoints.appContentDetail(slug),
      queryParameters: {
        "target_app": "CUSTOMER",
      },
    );

    return Map<String, dynamic>.from(
      response.data,
    );
  }

  // ==========================================================
  // FAQs
  // ==========================================================

  Future<List<dynamic>> getFaqs() async {
    final response = await _dio.get(
      Endpoints.appFaqs,
      queryParameters: {
        "target_app": "CUSTOMER",
      },
    );

    return response.data as List<dynamic>;
  }

  // ==========================================================
  // ANNOUNCEMENTS
  // ==========================================================

  Future<List<dynamic>> getAnnouncements() async {
    final response = await _dio.get(
      Endpoints.appAnnouncements,
      queryParameters: {
        "target_app": "CUSTOMER",
      },
    );

    return response.data as List<dynamic>;
  }

  // ==========================================================
  // SETTINGS
  // ==========================================================

  Future<List<dynamic>> getSettings() async {
    final response = await _dio.get(
      Endpoints.appSettings,
      queryParameters: {
        "target_app": "CUSTOMER",
      },
    );

    return response.data as List<dynamic>;
  }
}