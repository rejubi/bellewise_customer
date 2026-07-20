import 'package:flutter/material.dart';

import '../register/register_screen.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_logo.dart';
import '../widgets/auth_textfield.dart';
import '../../permissions/location_screen.dart';

import '../../../core/utils/phone_number_formatter.dart';
import '../forgot_password/forgot_password_screen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

final _formKey = GlobalKey<FormState>();

final phoneController = TextEditingController();
final passwordController = TextEditingController();

bool loading = false;

@override
void dispose() {
phoneController.dispose();
passwordController.dispose();
super.dispose();
}

String? validatePhone(String? value) {

if (value == null || value.isEmpty) {
return "Please enter your phone number.";
}

final phone = value.replaceAll(' ', '');

final regex = RegExp(r'^(070|071|080|081|090|091)\d{8}$');

if (!regex.hasMatch(phone)) {
return "Enter a valid phone number.";
}

return null;
}

String? validatePassword(String? value) {

if (value == null || value.isEmpty) {
return "Please enter your password.";
}

if (value.length < 8) {
return "Password must be at least 8 characters.";
}

return null;
}

Future<void> signIn() async {

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
  builder: (_) => const LocationScreen(),
),
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
width: 180,
),

const SizedBox(height: 20),

const Text(
"Welcome Back",
style: TextStyle(
fontSize: 28,
fontWeight: FontWeight.bold,
color: Color(0xFF212121),
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

const SizedBox(height: 18),

AuthTextField(
controller: passwordController,
hint: "Password",
icon: Icons.lock_outline,
obscure: true,
validator: validatePassword,
),

  const SizedBox(height: 8),

  Align(
    alignment: Alignment.centerRight,
    child: TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ForgotPasswordScreen(),
          ),
        );
      },
      child: const Text(
        "Forgot Password?",
        style: TextStyle(
          color: Color(0xFFF57C00),
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  ),

  const SizedBox(height: 10),

  loading
      ? const SizedBox(
    width: double.infinity,
    height: 58,
    child: Center(
      child: CircularProgressIndicator(
        color: Color(0xFFF57C00),
      ),
    ),
  )
      : AuthButton(
    text: "SIGN IN",
    onPressed: signIn,
  ),

  const SizedBox(height: 35),

  const Text(
    "Don't have an account?",
    style: TextStyle(
      color: Colors.grey,
      fontSize: 15,
    ),
  ),

  TextButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        ),
      );
    },
    child: const Text(
      "Create Account",
      style: TextStyle(
        color: Color(0xFFF57C00),
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),

  const SizedBox(height: 25),
],
),
),
),
),
);
}
}