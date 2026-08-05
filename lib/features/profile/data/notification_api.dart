import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';


class NotificationApi {


  Future<Response> getNotifications() {

    return ApiClient.dio.get(
      "/notifications/customer/",
    );

  }



  Future<Response> markRead(
      int id,
      ) {

    return ApiClient.dio.patch(
      "/notifications/customer/$id/read/",
    );

  }




  Future<Response> markAllRead() {

    return ApiClient.dio.patch(
      "/notifications/customer/read-all/",
    );

  }




  Future<Response> deleteNotification(
      int id,
      ) {

    return ApiClient.dio.delete(
      "/notifications/customer/$id/delete/",
    );

  }

}