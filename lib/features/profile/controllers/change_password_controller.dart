import 'package:flutter/material.dart';

import '../data/change_password_repository.dart';

class ChangePasswordController extends ChangeNotifier {
  ChangePasswordController({
    ChangePasswordRepository? repository,
  }) : _repository =
      repository ?? ChangePasswordRepository();

  final ChangePasswordRepository _repository;

  final TextEditingController currentPasswordController =
  TextEditingController();

  final TextEditingController newPasswordController =
  TextEditingController();

  final TextEditingController confirmPasswordController =
  TextEditingController();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<String?> changePassword() async {
    final currentPassword =
    currentPasswordController.text.trim();

    final newPassword =
    newPasswordController.text.trim();

    final confirmPassword =
    confirmPasswordController.text.trim();

    // ==========================================
    // VALIDATION
    // ==========================================

    if (currentPassword.isEmpty) {
      return "Please enter your current password.";
    }

    if (newPassword.isEmpty) {
      return "Please enter your new password.";
    }

    if (confirmPassword.isEmpty) {
      return "Please confirm your new password.";
    }

    if (newPassword.length < 8) {
      return "New password must be at least 8 characters.";
    }

    if (newPassword != confirmPassword) {
      return "Passwords do not match.";
    }

    if (currentPassword == newPassword) {
      return "New password must be different from your current password.";
    }

    // ==========================================
    // LOADING
    // ==========================================

    _isLoading = true;
    notifyListeners();

    try {
      final message =
      await _repository.changePassword(
        oldPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      return message;
    } catch (e) {
      return e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }
}