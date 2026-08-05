import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import 'forgot_password_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen> {
  late final ForgotPasswordController controller;

  @override
  void initState() {
    super.initState();
    controller = ForgotPasswordController();
    controller.addListener(_refresh);
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    controller.removeListener(_refresh);
    controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();

    final message = await controller.sendResetLink();

    if (!mounted || message == null) return;

    final isSuccess =
    message.toLowerCase().contains("sent");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
        isSuccess ? Colors.green : Colors.red,
      ),
    );

    if (isSuccess) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),

              const Text(
                "Forgot your password?",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "Enter the email address associated with your BelleWise account. We'll send you a password reset link.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 32),

              TextField(
                controller: controller.emailController,
                keyboardType:
                TextInputType.emailAddress,
                textInputAction:
                TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: "Email Address",
                  hintText: "example@email.com",
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                onSubmitted: (_) => _submit(),
              ),

              const SizedBox(height: 32),

              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: controller.isLoading
                      ? null
                      : _submit,
                  child: controller.isLoading
                      ? const SizedBox(
                    height: 22,
                    width: 22,
                    child:
                    CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                    ),
                  )
                      : const Text(
                    "Send Reset Link",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}