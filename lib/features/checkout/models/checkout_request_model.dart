class CheckoutRequestModel {
  final String deliveryAddress;
  final String customerPhone;
  final String customerNote;
  final String paymentMethod;

  final double? deliveryLatitude;
  final double? deliveryLongitude;

  const CheckoutRequestModel({
    required this.deliveryAddress,
    required this.customerPhone,
    required this.customerNote,
    required this.paymentMethod,
    this.deliveryLatitude,
    this.deliveryLongitude,
  });

  Map<String, dynamic> toJson() {
    return {
      "delivery_address": deliveryAddress,
      "customer_phone": customerPhone,
      "customer_note": customerNote,
      "payment_method": paymentMethod,
      "delivery_latitude": deliveryLatitude,
      "delivery_longitude": deliveryLongitude,
    };
  }
}