class CheckoutRequestModel {
  final String deliveryAddress;
  final String customerPhone;
  final String customerNote;
  final String paymentMethod;

  const CheckoutRequestModel({
    required this.deliveryAddress,
    required this.customerPhone,
    required this.customerNote,
    required this.paymentMethod,
  });

  Map<String, dynamic> toJson() {
    return {
      "delivery_address": deliveryAddress,
      "customer_phone": customerPhone,
      "customer_note": customerNote,
      "payment_method": paymentMethod,
    };
  }
}