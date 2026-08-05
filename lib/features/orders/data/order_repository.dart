import '../models/order_model.dart';
import 'order_api.dart';

class OrderRepository {
  final OrderApi api = OrderApi();

  Future<List<OrderModel>> loadOrders() async {
    final response = await api.getOrders();

    return (response.data as List)
        .map(
          (e) => OrderModel.fromJson(e),
    )
        .toList();
  }

  Future<OrderModel> loadOrder(
      int orderId,
      ) async {
    final response =
    await api.getOrder(orderId);

    return OrderModel.fromJson(
      response.data,
    );
  }

  Future<void> cancelOrder(
      int orderId,
      ) async {
    await api.cancelOrder(orderId);
  }
}