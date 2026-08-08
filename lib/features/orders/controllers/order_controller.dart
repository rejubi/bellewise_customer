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

  // ==========================================================
  // LOAD ALL ORDERS
  // ==========================================================

  Future<void> loadOrders() async {
    try {
      _isLoading = true;
      _error = null;

      notifyListeners();

      _orders = await repository.loadOrders();
    } catch (e) {
      debugPrint('LOAD ORDERS ERROR: $e');

      _error = _extractErrorMessage(e);
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  // ==========================================================
  // REFRESH ALL ORDERS
  // ==========================================================

  Future<void> refreshOrders() async {
    try {
      _orders = await repository.loadOrders();

      notifyListeners();
    } catch (e) {
      debugPrint('REFRESH ORDERS ERROR: $e');
    }
  }

  // ==========================================================
  // LOAD SINGLE ORDER
  // ==========================================================

  Future<void> loadOrder(int orderId) async {
    if (_requestInProgress) {
      return;
    }

    _requestInProgress = true;

    _isLoading = true;
    _error = null;

    notifyListeners();

    try {
      debugPrint('======================================');
      debugPrint('LOADING ORDER');
      debugPrint('Order ID: $orderId');
      debugPrint('======================================');

      final order = await repository.loadOrder(orderId);

      _currentOrder = order;

      // Notify immediately after the order itself has loaded.
      notifyListeners();

      // Tracking is supplementary.
      // If tracking fails, the order details must still display.
      try {
        await getTracking(orderId);
      } catch (e) {
        debugPrint('TRACKING LOAD ERROR: $e');
      }
    } catch (e) {
      debugPrint('======================================');
      debugPrint('ORDER DETAIL ERROR');
      debugPrint('Order ID: $orderId');
      debugPrint('Error: $e');
      debugPrint('======================================');

      _error = _extractErrorMessage(e);

      // Make sure stale data is not displayed
      // when a completely new order request fails.
      _currentOrder = null;
    } finally {
      _isLoading = false;
      _requestInProgress = false;

      notifyListeners();
    }
  }

  // ==========================================================
  // LOAD TRACKING
  // ==========================================================

  Future<TrackingModel?> getTracking(int orderId) async {
    try {
      tracking = await _trackingRepository.getTracking(orderId);

      notifyListeners();

      return tracking;
    } catch (e) {
      debugPrint('TRACKING ERROR: $e');

      // Tracking failure should never prevent
      // the order details from displaying.
      return tracking;
    }
  }

  // ==========================================================
  // CANCEL ORDER
  // ==========================================================

  Future<void> cancelOrder(int orderId) async {
    try {
      await repository.cancelOrder(orderId);

      await loadOrder(orderId);

      await refreshOrders();
    } catch (e) {
      debugPrint('CANCEL ORDER ERROR: $e');

      _error = _extractErrorMessage(e);

      notifyListeners();
    }
  }

  // ==========================================================
  // START LIVE TRACKING
  // ==========================================================

  void startTracking(int orderId) {
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

  // ==========================================================
  // STOP LIVE TRACKING
  // ==========================================================

  void stopTracking() {
    _tracking = false;

    _timer?.cancel();

    _timer = null;
  }

  // ==========================================================
  // ERROR MESSAGE
  // ==========================================================

  String _extractErrorMessage(Object error) {
    final message = error.toString();

    if (message.isEmpty) {
      return 'Unable to load order. Please try again.';
    }

    return message;
  }

  // ==========================================================
  // DISPOSE
  // ==========================================================

  @override
  void dispose() {
    stopTracking();

    super.dispose();
  }
}