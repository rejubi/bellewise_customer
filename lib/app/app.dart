import 'package:flutter/material.dart';

import 'router.dart';
import 'theme.dart';

class BelleWiseApp extends StatelessWidget {
  const BelleWiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'BelleWise',
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}