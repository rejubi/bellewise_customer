import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'reset_password_screen.dart';

class ResetOtpScreen extends StatefulWidget {
  const ResetOtpScreen({super.key});

  @override
  State<ResetOtpScreen> createState() => _ResetOtpScreenState();
}

class _ResetOtpScreenState extends State<ResetOtpScreen> {
  final List<TextEditingController> controllers =
  List.generate(6, (_) => TextEditingController());

  final List<FocusNode> focusNodes =
  List.generate(6, (_) => FocusNode());

  bool canVerify = false;

  @override
  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }

    for (final node in focusNodes) {
      node.dispose();
    }

    super.dispose();
  }

  void checkOtp() {
    final otp = controllers.map((e) => e.text).join();

    setState(() {
      canVerify = otp.length == 6;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),

          child: Column(
            children: [

              const SizedBox(height: 50),

              Image.asset(
                "assets/branding/logo_main.png",
                width: 170,
              ),

              const SizedBox(height: 35),

              const Text(
                "Verify OTP",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Enter the 6-digit code sent to your phone number.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 45),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: List.generate(
                  6,
                      (index) {
                    return SizedBox(
                      width: 48,
                      height: 58,

                      child: TextField(
                        controller: controllers[index],
                        focusNode: focusNodes[index],

                        keyboardType: TextInputType.number,

                        textAlign: TextAlign.center,

                        maxLength: 1,

                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],

                        decoration: InputDecoration(
                          counterText: "",

                          filled: true,
                          fillColor: const Color(0xFFF8F8F8),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                              color: Color(0xFFE5E5E5),
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                              color: Color(0xFFF57C00),
                              width: 2,
                            ),
                          ),
                        ),

                        onChanged: (value) {

                          if (value.length == 1) {

                            if (index < 5) {
                              FocusScope.of(context).requestFocus(
                                focusNodes[index + 1],
                              );
                            } else {
                              FocusScope.of(context).unfocus();
                            }

                          } else if (value.isEmpty) {

                            if (index > 0) {
                              FocusScope.of(context).requestFocus(
                                focusNodes[index - 1],
                              );
                            }

                          }

                          checkOtp();
                        },
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 35),

              const Text(
                "Didn't receive the code?",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              TextButton(
                onPressed: () {},
                child: const Text(
                  "Resend Code (00:59)",
                  style: TextStyle(
                    color: Color(0xFFF57C00),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 58,

                child: ElevatedButton(
                  onPressed: canVerify
                      ? () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const ResetPasswordScreen(),
                      ),
                    );
                  }
                      : null,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF57C00),
                    disabledBackgroundColor: Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),

                  child: const Text(
                    "VERIFY",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const Spacer(),

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

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}