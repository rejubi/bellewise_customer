import 'package:flutter/foundation.dart';


class NotificationService {

  NotificationService._();


  static final NotificationService instance =
  NotificationService._();


  bool _initialized = false;


  Future<void> initialize() async {


    if(_initialized){
      return;
    }


    debugPrint(
      "Notification service initialized",
    );


    _initialized = true;

  }


}