class OrderItemModel {
  final int id;
  final String product;
  final double price;
  final int quantity;

  const OrderItemModel({
    required this.id,
    required this.product,
    required this.price,
    required this.quantity,
  });

  factory OrderItemModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return OrderItemModel(
      id: json["id"],

      product: json["product"] ?? "",

      price: double.parse(
        json["price"].toString(),
      ),

      quantity: json["quantity"] ?? 0,
    );
  }

  double get total => price * quantity;
}