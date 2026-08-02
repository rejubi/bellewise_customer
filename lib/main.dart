import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'core/api/api_client.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Dio once for the entire app.
  ApiClient.initialize();

  runApp(
    const ProviderScope(
      child: BelleWiseApp(),
    ),
  );
}