import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/api/api_client.dart';
import '../../core/api/endpoints.dart';
import '../../core/storage/secure_storage.dart';

class SplashController {
  final SecureStorage storage =
  SecureStorage();

  // ==========================================================
  // STARTUP
  // ==========================================================

  Future<void> initialize(
      BuildContext context,
      ) async {
    // --------------------------------------------------------
    // Keep splash visible briefly.
    // --------------------------------------------------------

    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (!context.mounted) {
      return;
    }

    // ========================================================
    // CHECK ONBOARDING
    // ========================================================

    final onboardingCompleted =
    await storage.isOnboardingCompleted();

    if (!context.mounted) {
      return;
    }

    // --------------------------------------------------------
    // FIRST-TIME USER
    // --------------------------------------------------------

    if (!onboardingCompleted) {
      context.go('/onboarding');
      return;
    }

    // ========================================================
    // CHECK REFRESH TOKEN
    // ========================================================
    //
    // IMPORTANT:
    //
    // We do NOT use the access token to decide whether
    // the customer has a persistent login session.
    //
    // Access token:
    // - short-lived
    //
    // Refresh token:
    // - persistent session credential
    //

    final refreshToken =
    await storage.getRefreshToken();

    if (!context.mounted) {
      return;
    }

    // --------------------------------------------------------
    // NO REFRESH TOKEN
    // --------------------------------------------------------
    //
    // There is no saved authenticated session.
    //

    if (refreshToken == null ||
        refreshToken.isEmpty) {
      context.go('/login');
      return;
    }

    // ========================================================
    // RESTORE CUSTOMER SESSION
    // ========================================================
    //
    // We call /customers/profile/.
    //
    // If the access token is:
    //
    // 1. Valid:
    //    Request succeeds.
    //
    // 2. Expired:
    //    AuthInterceptor receives 401.
    //    It uses the refresh token.
    //    It saves the new access token.
    //    It saves the rotated refresh token if returned.
    //    It retries /customers/profile/.
    //
    // 3. Refresh token invalid/expired:
    //    Refresh fails.
    //    AuthInterceptor clears authentication.
    //    Request remains failed.
    //

    try {
      final response =
      await ApiClient.dio.get(
        Endpoints.profile,
      );

      if (!context.mounted) {
        return;
      }

      // ------------------------------------------------------
      // PROFILE SUCCESS
      // ------------------------------------------------------
      //
      // The customer session is valid.
      //

      if (response.statusCode == 200) {
        context.go('/home');
        return;
      }

      // ------------------------------------------------------
      // Unexpected response.
      // ------------------------------------------------------

      await storage.clear();

      if (!context.mounted) {
        return;
      }

      context.go('/login');
    } catch (_) {
      // ------------------------------------------------------
      // Session could not be restored.
      //
      // This can happen if:
      //
      // - refresh token is expired
      // - refresh token is blacklisted
      // - backend rejects authentication
      // - profile request fails
      //
      // Clear the saved authentication session.
      // ------------------------------------------------------

      await storage.clear();

      if (!context.mounted) {
        return;
      }

      context.go('/login');
    }
  }
}