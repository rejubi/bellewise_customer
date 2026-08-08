import '../data/checkout_repository.dart';
import '../models/checkout_request_model.dart';

class CheckoutController {
  final CheckoutRepository _repository =
  CheckoutRepository();

  Future<String> createOrder(
      CheckoutRequestModel request,
      ) async {
    final response =
    await _repository.createOrder(request);

    final data = response.data;

    if (data == null ||
        data["public_id"] == null) {
      throw Exception(
        "Order created, but no public ID returned.",
      );
    }

    return data["public_id"].toString();
  }
}