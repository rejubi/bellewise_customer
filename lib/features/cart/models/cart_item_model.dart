class CartItemModel {
  final int id;

  final int productId;
  final String name;
  final String description;
  final String? image;

  final double price;
  final double? discountPrice;

  final int preparationTime;
  final bool available;

  final int quantity;

  final double subtotal;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.name,
    required this.description,
    this.image,
    required this.price,
    this.discountPrice,
    required this.preparationTime,
    required this.available,
    required this.quantity,
    required this.subtotal,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    final product = json["product"];

    return CartItemModel(
      id: json["id"],

      productId: product["id"],

      name: product["name"] ?? "",

      description: product["description"] ?? "",

      image: product["image"],

      price: double.parse(product["price"]),

      discountPrice: product["discount_price"] == null
          ? null
          : double.parse(product["discount_price"]),

      preparationTime: product["preparation_time"] ?? 0,

      available: product["is_available"] ?? true,

      quantity: json["quantity"],

      subtotal: double.parse(
        json["subtotal"].toString(),
      ),
    );
  }
}