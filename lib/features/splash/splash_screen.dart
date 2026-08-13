import 'package:flutter/material.dart';

import '../../app/theme.dart';
import 'splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen> {
  final SplashController controller =
  SplashController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
          (_) {
        controller.initialize(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.primary,
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(),

              Hero(
                tag: 'logo',
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 180,
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                'YOUR FOOD PLUG',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const Spacer(),

              const CircularProgressIndicator(
                color: Colors.white,
              ),

              const SizedBox(height: 20),

              const Text(
                'Powered by Bellewise',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}