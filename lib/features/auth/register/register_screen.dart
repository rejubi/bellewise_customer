import 'package:flutter/material.dart';

import '../login/login_screen.dart';
import '../otp/otp_screen.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_logo.dart';
import '../widgets/auth_textfield.dart';
import '../../../core/utils/phone_number_formatter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool agree = false;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  String? validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter your first name.";
    }

    if (value.trim().length < 2) {
      return "First name is too short.";
    }

    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter your last name.";
    }

    if (value.trim().length < 2) {
      return "Last name is too short.";
    }

    return null;
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

                const SizedBox(height: 50),

                const AuthLogo(
                  image: "assets/branding/logo_main.png",
                  width: 190,
                ),

                const SizedBox(height: 40),

                AuthTextField(
                  controller: firstNameController,
                  hint: "First Name",
                  icon: Icons.person_outline,
                  validator: validateFirstName,
                ),

                const SizedBox(height: 18),

                AuthTextField(
                  controller: lastNameController,
                  hint: "Last Name",
                  icon: Icons.person_outline,
                  validator: validateLastName,
                ),

                const SizedBox(height: 18),

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

                const SizedBox(height: 18),

                AuthTextField(
                  controller: passwordController,
                  hint: "Password",
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

                const SizedBox(height: 12),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Checkbox(
                      activeColor: const Color(0xFFF57C00),
                      value: agree,
                      onChanged: (value) {
                        setState(() {
                          agree = value ?? false;
                        });
                      },
                    ),

                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: Text(
                          "I agree to the Terms & Conditions",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                AuthButton(
                  text: "CREATE ACCOUNT",
                  onPressed: agree
                      ? () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const OtpScreen(),
                        ),
                      );
                    }
                  }
                      : null,
                ),

                const SizedBox(height: 35),

                const Text(
                  "Already have an account?",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      color: Color(0xFFF57C00),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}