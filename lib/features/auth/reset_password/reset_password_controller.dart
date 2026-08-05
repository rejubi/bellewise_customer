import 'package:flutter/material.dart';

import 'reset_password_repository.dart';

class ResetPasswordController extends ChangeNotifier {
  ResetPasswordController({
    required this.uid,
    required this.token,
    ResetPasswordRepository? repository,
  }) : _repository = repository ?? ResetPasswordRepository();

  final String uid;
  final String token;

  final ResetPasswordRepository _repository;

  final TextEditingController passwordController =
  TextEditingController();

  final TextEditingController confirmPasswordController =
  TextEditingController();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<String?> resetPassword() async {
    final password = passwordController.text.trim();
    final confirmPassword =
    confirmPasswordController.text.trim();

    if (password.isEmpty) {
      return "Please enter a new password.";
    }

    if (confirmPassword.isEmpty) {
      return "Please confirm your new password.";
    }

    if (password != confirmPassword) {
      return "Passwords do not match.";
    }

    if (password.length < 8) {
      return "Password must be at least 8 characters.";
    }

    _isLoading = true;
    notifyListeners();

    try {
      final message = await _repository.resetPassword(
        uid: uid,
        token: token,
        newPassword: password,
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
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}