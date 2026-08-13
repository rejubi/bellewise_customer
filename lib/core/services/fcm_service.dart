import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../api/api_client.dart';
import '../api/endpoints.dart';
import '../storage/secure_storage.dart';


// ============================================================
// LOCAL NOTIFICATION INSTANCE
// ============================================================

final FlutterLocalNotificationsPlugin localNotifications =
FlutterLocalNotificationsPlugin();


// ============================================================
// BACKGROUND HANDLER
// ============================================================

Future firebaseBackgroundHandler(
    RemoteMessage message,
    ) async {

  debugPrint(
    "BACKGROUND MESSAGE RECEIVED",
  );

  debugPrint(
    "TITLE: ${message.notification?.title}",
  );

  debugPrint(
    "BODY: ${message.notification?.body}",
  );
}


// ============================================================
// FCM SERVICE
// ============================================================

class FCMService {

  FCMService._();

  static final FCMService instance =
  FCMService._();


  final FirebaseMessaging _messaging =
      FirebaseMessaging.instance;


  bool _initialized = false;



  // ==========================================================
  // INITIALIZE
  // ==========================================================

  Future initialize() async {

    if (_initialized) {
      return;
    }


    FirebaseMessaging.onBackgroundMessage(
      firebaseBackgroundHandler,
    );


    await _initializeLocalNotifications();



    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );



    final token =
    await _messaging.getToken();



    if (token != null) {

      debugPrint(
        "FCM TOKEN: $token",
      );


      await registerToken(
        token,
      );
    }



    FirebaseMessaging
        .instance
        .onTokenRefresh
        .listen(
          (newToken) async {

        debugPrint(
          "NEW TOKEN: $newToken",
        );


        await registerToken(
          newToken,
        );

      },
    );



    // ======================================================
    // FOREGROUND MESSAGE
    // ======================================================

    FirebaseMessaging.onMessage.listen(
          (RemoteMessage message) {

        debugPrint(
          "FOREGROUND MESSAGE",
        );


        showLocalNotification(
          message,
        );

      },
    );



    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {

        debugPrint(
          "NOTIFICATION OPENED",
        );

        debugPrint(
          message.data.toString(),
        );

      },
    );



    _initialized = true;


    debugPrint(
      "FCM INITIALIZED",
    );

  }




  // ==========================================================
  // LOCAL NOTIFICATION SETUP
  // ==========================================================

  Future _initializeLocalNotifications() async {


    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );


    const InitializationSettings settings =
    InitializationSettings(
      android: androidSettings,
    );


    await localNotifications.initialize(
      settings: settings,
    );



    const AndroidNotificationChannel channel =
    AndroidNotificationChannel(
      'bellewise_order',
      'BelleWise Orders',
      description: 'Order updates and delivery notifications',
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
      sound: RawResourceAndroidNotificationSound(
        'bellewise_order',
      ),
    );



    await localNotifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
      channel,
    );

  }





  // ==========================================================
  // SHOW FOREGROUND NOTIFICATION
  // ==========================================================

  Future showLocalNotification(
      RemoteMessage message,
      ) async {


    final notification =
        message.notification;


    if (notification == null) {
      return;
    }



    await localNotifications.show(
      id: notification.hashCode,

      title: notification.title,

      body: notification.body,

      notificationDetails:
      const NotificationDetails(

        android:
        AndroidNotificationDetails(
          'bellewise_orders',
          'BelleWise Orders',

          channelDescription:
          'BelleWise order and account notifications',

          importance:
          Importance.max,

          priority:
          Priority.high,

          playSound:
          true,

          enableVibration:
          true,

          sound:
          RawResourceAndroidNotificationSound(
            'bellewise_order',
          ),
        ),

      ),
    );

  }





  // ==========================================================
  // REGISTER TOKEN
  // ==========================================================

  Future registerToken(
      String token,
      ) async {


    try {


      final accessToken =
      await SecureStorage()
          .getAccessToken();



      if (accessToken == null ||
          accessToken.isEmpty) {


        debugPrint(
          "NO ACCESS TOKEN - SKIPPING FCM REGISTRATION",
        );


        return;
      }



      await ApiClient.dio.post(

        Endpoints.registerFcmDevice,


        data: {

          "token": token,

          "platform": "ANDROID",

        },

      );



      debugPrint(
        "FCM TOKEN REGISTERED",
      );


    } catch(e){


      debugPrint(
        "FCM REGISTRATION FAILED: $e",
      );

    }

  }





  // ==========================================================
  // DELETE TOKEN
  // ==========================================================

  Future deleteToken() async {


    final token =
    await _messaging.getToken();



    if(token == null){
      return;
    }



    try {


      await ApiClient.dio.post(

        Endpoints.deleteFcmDevice,


        data: {

          "token": token,

        },

      );



      await _messaging.deleteToken();



    }catch(e){


      debugPrint(
        "FCM DELETE FAILED: $e",
      );

    }

  }

}