import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/endpoints.dart';

class NotificationApi {
  Future<Response> getNotifications() {
    return ApiClient.dio.get(
      Endpoints.notifications,
    );
  }

  Future<Response> markRead(int id) {
    return ApiClient.dio.patch(
      Endpoints.markNotificationRead(id),
    );
  }

  Future<Response> markAllRead() {
    return ApiClient.dio.patch(
      Endpoints.markAllNotificationsRead,
    );
  }

  Future<Response> deleteNotification(int id) {
    return ApiClient.dio.delete(
      Endpoints.deleteNotification(id),
    );
  }
}