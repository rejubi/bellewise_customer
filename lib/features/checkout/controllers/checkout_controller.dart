import '../data/checkout_repository.dart';
import '../models/checkout_request_model.dart';

class CheckoutController {
  final CheckoutRepository _repository =
  CheckoutRepository();

  Future<int> createOrder(
      CheckoutRequestModel request,
      ) async {
    final response =
    await _repository.createOrder(
      request,
    );

    return response.data["order_id"];
  }
}
