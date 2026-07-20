import 'package:flutter/material.dart';

import '../login/login_screen.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_logo.dart';
import '../widgets/auth_textfield.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState
    extends State<ResetPasswordScreen> {

  final _formKey = GlobalKey<FormState>();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool loading = false;

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a password.";
    }

    if (value.length < 8) {
      return "Password must be at least 8 characters.";
    }

    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please confirm your password.";
    }

    if (value != passwordController.text) {
      return "Passwords do not match.";
    }

    return null;
  }

  Future<void> updatePassword() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      loading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      loading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Password updated successfully."),
      ),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),

          child: Form(
            key: _formKey,

            child: Column(
              children: [

                const SizedBox(height: 70),

                const AuthLogo(
                  image: "assets/branding/logo_login.png",
                  width: 170,
                ),

                const SizedBox(height: 25),

                const Text(
                  "Create New Password",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Choose a strong password for your account.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 45),

                AuthTextField(
                  controller: passwordController,
                  hint: "New Password",
                  icon: Icons.lock_outline,
                  obscure: true,
                  validator: validatePassword,
                ),

                const SizedBox(height: 18),

                AuthTextField(
                  controller: confirmPasswordController,
                  hint: "Confirm Password",
                  icon: Icons.lock_outline,
                  obscure: true,
                  validator: validateConfirmPassword,
                ),

                const SizedBox(height: 35),

                loading
                    ? const CircularProgressIndicator(
                  color: Color(0xFFF57C00),
                )
                    : AuthButton(
                  text: "UPDATE PASSWORD",
                  onPressed: updatePassword,
                ),

                const SizedBox(height: 30),

                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "← Back",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}