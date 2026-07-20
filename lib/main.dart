import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'features/splash/splash_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: BellewiseApp(),
    ),
  );
}

class BellewiseApp extends StatelessWidget {
  const BellewiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bellewise',

      theme: AppTheme.lightTheme,

      home: const SplashScreen(),
    );
  }
}