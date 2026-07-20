import 'package:flutter/material.dart';

import '../widgets/auth_button.dart';
import '../widgets/auth_logo.dart';
import '../widgets/auth_textfield.dart';
import '../../../core/utils/phone_number_formatter.dart';
import 'reset_otp_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen> {

  final _formKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();

  bool loading = false;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  String? validatePhone(String? value) {

    if (value == null || value.isEmpty) {
      return "Please enter your phone number.";
    }

    final phone = value.replaceAll(' ', '');

    final regex = RegExp(r'^(070|071|080|081|090|091)\d{8}$');

    if (!regex.hasMatch(phone)) {
      return "Enter a valid Nigerian phone number.";
    }

    return null;
  }

  Future<void> sendOtp() async {

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

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ResetOtpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
          const EdgeInsets.symmetric(horizontal: 30),

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
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Enter your phone number to receive a verification code.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 45),

                AuthTextField(
                  controller: phoneController,
                  hint: "Phone Number",
                  icon: Icons.phone_android,
                  keyboardType: TextInputType.phone,
                  validator: validatePhone,
                  inputFormatters: [
                    PhoneNumberFormatter(),
                  ],
                ),

                const SizedBox(height: 35),

                loading
                    ? const CircularProgressIndicator(
                  color: Color(0xFFF57C00),
                )
                    : AuthButton(
                  text: "SEND OTP",
                  onPressed: sendOtp,
                ),

                const SizedBox(height: 30),

                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "← Back to Login",
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