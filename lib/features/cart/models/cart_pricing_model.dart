class CartPricingModel {
  final double subtotal;
  final double deliveryFee;
  final double serviceFee;
  final double vat;
  final double total;

  const CartPricingModel({
    required this.subtotal,
    required this.deliveryFee,
    required this.serviceFee,
    required this.vat,
    required this.total,
  });

  factory CartPricingModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return CartPricingModel(
      subtotal: double.parse(
        json["subtotal"].toString(),
      ),
      deliveryFee: double.parse(
        json["delivery_fee"].toString(),
      ),
      serviceFee: double.parse(
        json["service_fee"].toString(),
      ),
      vat: double.parse(
        json["vat"].toString(),
      ),
      total: double.parse(
        json["total"].toString(),
      ),
    );
  }
}