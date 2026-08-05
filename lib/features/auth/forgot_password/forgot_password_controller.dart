import 'package:flutter/material.dart';

import 'forgot_password_repository.dart';

class ForgotPasswordController extends ChangeNotifier {
  ForgotPasswordController({
    ForgotPasswordRepository? repository,
  }) : _repository = repository ?? ForgotPasswordRepository();

  final ForgotPasswordRepository _repository;

  final TextEditingController emailController = TextEditingController();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<String?> sendResetLink() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      return "Email is required.";
    }

    final emailRegex = RegExp(
      r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (!emailRegex.hasMatch(email)) {
      return "Enter a valid email address.";
    }

    _isLoading = true;
    notifyListeners();

    try {
      final message = await _repository.sendResetLink(
        email: email,
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
    emailController.dispose();
    super.dispose();
  }
}