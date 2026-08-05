import 'dart:async';

import 'package:flutter/foundation.dart';

import '../data/order_repository.dart';
import '../models/order_model.dart';
import '../models/tracking_model.dart';
import '../repositories/tracking_repository.dart';

class OrderController extends ChangeNotifier {
  final OrderRepository repository = OrderRepository();

  final TrackingRepository _trackingRepository =
  TrackingRepository();

  List<OrderModel> _orders = [];

  OrderModel? _currentOrder;

  TrackingModel? tracking;

  bool _isLoading = false;

  bool _tracking = false;

  bool _requestInProgress = false;

  String? _error;

  Timer? _timer;

  List<OrderModel> get orders => _orders;

  OrderModel? get currentOrder => _currentOrder;

  bool get isLoading => _isLoading;

  String? get error => _error;

  Future<void> loadOrders() async {
    try {
      _isLoading = true;
      _error = null;

      notifyListeners();

      _orders = await repository.loadOrders();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshOrders() async {
    try {
      _orders = await repository.loadOrders();
      notifyListeners();
    } catch (_) {}
  }

  Future<void> loadOrder(
      int orderId,
      ) async {
    if (_requestInProgress) {
      return;
    }

    _requestInProgress = true;

    try {
      _currentOrder =
      await repository.loadOrder(orderId);

      await getTracking(orderId);

      notifyListeners();
    } finally {
      _requestInProgress = false;
    }
  }

  Future<TrackingModel?> getTracking(
      int orderId,
      ) async {
    try {
      tracking = await _trackingRepository.getTracking(
        orderId,
      );

      notifyListeners();

      return tracking;
    } catch (_) {
      return tracking;
    }
  }

  Future<void> cancelOrder(
      int orderId,
      ) async {
    await repository.cancelOrder(orderId);

    await loadOrder(orderId);

    await refreshOrders();
  }

  void startTracking(
      int orderId,
      ) {
    if (_tracking) {
      return;
    }

    _tracking = true;

    loadOrder(orderId);

    _timer = Timer.periodic(
      const Duration(seconds: 5),
          (_) async {
        await loadOrder(orderId);

        if (_currentOrder == null) {
          return;
        }

        if (!_currentOrder!.isActive) {
          stopTracking();
        }
      },
    );
  }

  void stopTracking() {
    _tracking = false;

    _timer?.cancel();

    _timer = null;
  }

  @override
  void dispose() {
    stopTracking();
    super.dispose();
  }
}