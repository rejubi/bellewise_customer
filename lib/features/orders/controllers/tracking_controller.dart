import 'dart:async';

import 'package:flutter/material.dart';

import '../models/tracking_model.dart';
import '../repositories/tracking_repository.dart';

class TrackingController extends ChangeNotifier {
  final TrackingRepository _repository = TrackingRepository();

  TrackingModel? tracking;

  bool isLoading = false;

  String? error;

  Timer? _timer;

  Future<void> loadTracking(int orderId) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      tracking = await _repository.getTracking(orderId);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void startTracking(int orderId) {
    loadTracking(orderId);

    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(seconds: 5),
          (_) => loadTracking(orderId),
    );
  }

  void stopTracking() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    stopTracking();
    super.dispose();
  }
}