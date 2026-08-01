import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/storage/secure_storage.dart';

class SplashController {
  final SecureStorage storage = SecureStorage();

  Future<void> initialize(BuildContext context) async {
    // Show splash screen for 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    // Check if the user has a saved access token
    final accessToken = await storage.getAccessToken();

    if (!context.mounted) return;

    if (accessToken == null || accessToken.isEmpty) {
      // First-time user or logged out
      context.go('/onboarding');
    } else {
      // User is already authenticated
      context.go('/home');
    }
  }
}