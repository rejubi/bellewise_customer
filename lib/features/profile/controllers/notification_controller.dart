import '../data/notification_repository.dart';
import '../models/notification_model.dart';


class NotificationController {


  final NotificationRepository repository =
  NotificationRepository();




  Future<List<NotificationModel>>
  loadNotifications(){

    return repository.loadNotifications();

  }




  Future<void> markRead(
      int id,
      ){

    return repository.markRead(id);

  }




  Future<void> markAllRead(){

    return repository.markAllRead();

  }




  Future<void> deleteNotification(
      int id,
      ){

    return repository.deleteNotification(id);

  }


}