import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import 'fcm_repository.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance =
  NotificationService._();

  final FirebaseMessaging _messaging =
      FirebaseMessaging.instance;

  final FcmRepository _repository =
  const FcmRepository();

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;

    print("========== FCM INITIALIZATION ==========");

    try {
      final settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      print(
        "Permission Status: ${settings.authorizationStatus}",
      );

      await _registerCurrentToken();

      _messaging.onTokenRefresh.listen((token) async {
        print("TOKEN REFRESHED:");
        print(token);

        await _registerToken(token);
      });

      FirebaseMessaging.onMessage.listen((message) {
        print("========== FOREGROUND MESSAGE ==========");
        print("Title: ${message.notification?.title}");
        print("Body : ${message.notification?.body}");
        print("Data : ${message.data}");
      });

      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        print("========== NOTIFICATION OPENED ==========");
        print(message.data);
      });

      final initialMessage =
      await _messaging.getInitialMessage();

      if (initialMessage != null) {
        print("========== APP OPENED FROM TERMINATED ==========");
        print(initialMessage.data);
      }

      print("========== FCM READY ==========");
    } catch (e) {
      print("========== FCM INITIALIZATION FAILED ==========");
      print(e);
    }
  }

  Future<void> _registerCurrentToken() async {
    try {
      print("Requesting FCM token...");

      final token = await _messaging
          .getToken()
          .timeout(const Duration(seconds: 10));

      if (token == null) {
        print("No FCM token received.");
        return;
      }

      print("FCM TOKEN:");
      print(token);

      await _registerToken(token);
    } on TimeoutException {
      print("Timed out waiting for FCM token.");
    } catch (e) {
      print("Unable to obtain FCM token:");
      print(e);
    }
  }

  Future<void> _registerToken(String token) async {
    try {
      print("Sending token to backend...");

      await _repository.registerToken(token);

      print("Backend registration successful.");
    } catch (e) {
      print("Backend registration failed:");
      print(e);
    }
  }

  Future<String?> getToken() {
    return _messaging.getToken();
  }

  Future<void> subscribe(String topic) {
    return _messaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribe(String topic) {
    return _messaging.unsubscribeFromTopic(topic);
  }

  Future<void> deleteToken() {
    return _messaging.deleteToken();
  }
}