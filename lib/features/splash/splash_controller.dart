import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/storage/secure_storage.dart';

class SplashController {
  final SecureStorage storage = SecureStorage();

  Future<void> initialize(BuildContext context) async {
    // Keep the splash visible briefly.
    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (!context.mounted) return;

    // ----------------------------------------------------------
    // CHECK WHETHER ONBOARDING HAS BEEN COMPLETED
    // ----------------------------------------------------------

    final onboardingCompleted =
    await storage.isOnboardingCompleted();

    if (!context.mounted) return;

    // ----------------------------------------------------------
    // FIRST-TIME USER
    // ----------------------------------------------------------

    if (!onboardingCompleted) {
      context.go('/onboarding');
      return;
    }

    // ----------------------------------------------------------
    // RETURNING USER
    // ----------------------------------------------------------

    final accessToken =
    await storage.getAccessToken();

    if (!context.mounted) return;

    // ----------------------------------------------------------
    // LOGGED IN
    // ----------------------------------------------------------

    if (accessToken != null &&
        accessToken.isNotEmpty) {
      context.go('/home');
      return;
    }

    // ----------------------------------------------------------
    // LOGGED OUT BUT ALREADY ONBOARDED
    // ----------------------------------------------------------

    context.go('/login');
  }
}