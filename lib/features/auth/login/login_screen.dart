import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../../core/services/location_service.dart';
import '../../../core/widgets/app_logo.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import 'login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {
  final emailController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  final LoginController controller =
  LoginController();

  bool obscurePassword = true;
  bool loading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // ============================================================
  // LOGIN
  // ============================================================

  Future<void> login() async {
    FocusScope.of(context).unfocus();

    // ----------------------------------------------------------
    // VALIDATION
    // ----------------------------------------------------------

    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please enter your email and password.",
          ),
        ),
      );

      return;
    }

    // ----------------------------------------------------------
    // SHOW LOADING
    // ----------------------------------------------------------

    setState(() {
      loading = true;
    });

    // ----------------------------------------------------------
    // LOGIN
    // ----------------------------------------------------------

    final success = await controller.login(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (!mounted) return;

    // ----------------------------------------------------------
    // STOP LOGIN LOADING
    // ----------------------------------------------------------

    setState(() {
      loading = false;
    });

    // ----------------------------------------------------------
    // LOGIN FAILED
    // ----------------------------------------------------------

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Invalid email or password.",
          ),
        ),
      );

      return;
    }

    // ==========================================================
    // LOGIN SUCCESSFUL
    // ==========================================================
    //
    // IMPORTANT:
    //
    // Do NOT wait for location permission here.
    //
    // The customer must enter Home immediately after
    // authentication.
    //

    context.go('/home');

    // ==========================================================
    // LOCATION IN BACKGROUND
    // ==========================================================
    //
    // This runs after navigation.
    //
    // It will:
    // 1. Check/request location permission.
    // 2. Get the customer's GPS position.
    // 3. Convert it to an address.
    //
    // None of this blocks login/navigation.
    //

    Future.microtask(() async {
      try {
        await LocationService.initialize();

        debugPrint(
          "LOGIN LOCATION: "
              "${LocationService.currentAddress}",
        );
      } catch (e) {
        debugPrint(
          "BACKGROUND LOCATION ERROR: $e",
        );
      }
    });
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      AppColors.background,

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
          const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 30,
          ),

          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.stretch,

            children: [
              const SizedBox(height: 20),

              // ==================================================
              // LOGO
              // ==================================================

              const Center(
                child: AppLogo(
                  width: 140,
                ),
              ),

              const SizedBox(height: 30),

              // ==================================================
              // TITLE
              // ==================================================

              const Text(
                "Welcome Back",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Login to order your favorite meals.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 40),

              // ==================================================
              // EMAIL
              // ==================================================

              AppTextField(
                controller:
                emailController,
                hint: "Email Address",
                icon:
                Icons.email_outlined,
                keyboardType:
                TextInputType.emailAddress,
              ),

              const SizedBox(height: 20),

              // ==================================================
              // PASSWORD
              // ==================================================

              AppTextField(
                controller:
                passwordController,
                hint: "Password",
                icon:
                Icons.lock_outline,
                obscureText:
                obscurePassword,

                suffixIcon:
                IconButton(
                  icon: Icon(
                    obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),

                  onPressed: () {
                    setState(() {
                      obscurePassword =
                      !obscurePassword;
                    });
                  },
                ),
              ),

              const SizedBox(height: 12),

              // ==================================================
              // FORGOT PASSWORD
              // ==================================================

              Align(
                alignment:
                Alignment.centerRight,

                child: TextButton(
                  onPressed: () {
                    context.push(
                      '/forgot-password',
                    );
                  },

                  child: const Text(
                    "Forgot Password?",
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ==================================================
              // LOGIN BUTTON
              // ==================================================

              PrimaryButton(
                text: "Login",
                loading: loading,
                onPressed:
                loading ? null : login,
              ),

              const SizedBox(height: 30),

              // ==================================================
              // REGISTER
              // ==================================================

              Row(
                mainAxisAlignment:
                MainAxisAlignment.center,

                children: [
                  const Text(
                    "Don't have an account?",
                  ),

                  TextButton(
                    onPressed: () {
                      context.go(
                        '/register',
                      );
                    },

                    child: const Text(
                      "Create Account",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}