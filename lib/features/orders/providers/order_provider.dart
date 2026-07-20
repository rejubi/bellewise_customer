import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/order_model.dart';

final ordersProvider =
StateNotifierProvider<OrdersNotifier, List<OrderModel>>(
      (ref) => OrdersNotifier(),
);

class OrdersNotifier extends StateNotifier<List<OrderModel>> {
  OrdersNotifier() : super([]);

  void addOrder(OrderModel order) {
    state = [order, ...state];
  }

  void clearOrders() {
    state = [];
  }
}