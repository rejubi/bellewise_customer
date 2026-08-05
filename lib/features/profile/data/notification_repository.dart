import '../models/notification_model.dart';
import 'notification_api.dart';


class NotificationRepository {


  final NotificationApi api =
  NotificationApi();



  Future<List<NotificationModel>>
  loadNotifications() async {


    final response =
    await api.getNotifications();


    final List data =
        response.data;


    return data
        .map(
          (item) =>
          NotificationModel.fromJson(
            item,
          ),
    )
        .toList();

  }





  Future<void> markRead(
      int id,
      ) async {

    await api.markRead(id);

  }




  Future<void> markAllRead() async {

    await api.markAllRead();

  }





  Future<void> deleteNotification(
      int id,
      ) async {

    await api.deleteNotification(id);

  }


}