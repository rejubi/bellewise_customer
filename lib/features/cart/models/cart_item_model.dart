class CartItemModel {
  final int id;

  final int productId;
  final String name;
  final String description;
  final String? image;

  /// Original product price.
  final double price;

  /// Discounted/current product price.
  final double? discountPrice;

  final int preparationTime;
  final bool available;

  final int quantity;

  /// Backend-calculated subtotal.
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

  /// The price the customer should currently pay for one item.
  ///
  /// If a valid discount price exists, use it.
  /// Otherwise use the normal product price.
  double get currentPrice {
    if (discountPrice != null &&
        discountPrice! < price) {
      return discountPrice!;
    }

    return price;
  }

  /// Whether this product currently has a valid discount.
  bool get hasDiscount {
    return discountPrice != null &&
        discountPrice! < price;
  }

  factory CartItemModel.fromJson(
      Map<String, dynamic> json,
      ) {
    final product =
    json["product"] as Map<String, dynamic>;

    final rawPrice = product["price"];
    final rawDiscountPrice =
    product["discount_price"];

    final parsedPrice =
        double.tryParse(
          rawPrice?.toString() ?? "",
        ) ??
            0;

    final parsedDiscountPrice =
    rawDiscountPrice == null
        ? null
        : double.tryParse(
      rawDiscountPrice.toString(),
    );

    return CartItemModel(
      id: json["id"] is int
          ? json["id"]
          : int.parse(
        json["id"].toString(),
      ),

      productId: product["id"] is int
          ? product["id"]
          : int.parse(
        product["id"].toString(),
      ),

      name:
      product["name"]?.toString() ?? "",

      description:
      product["description"]?.toString() ??
          "",

      image: product["image"]?.toString(),

      price: parsedPrice,

      discountPrice:
      parsedDiscountPrice,

      preparationTime:
      product["preparation_time"] is int
          ? product["preparation_time"]
          : int.tryParse(
        product["preparation_time"]
            ?.toString() ??
            "",
      ) ??
          0,

      available:
      product["is_available"] ?? true,

      quantity: json["quantity"] is int
          ? json["quantity"]
          : int.tryParse(
        json["quantity"]?.toString() ??
            "",
      ) ??
          0,

      subtotal:
      double.tryParse(
        json["subtotal"]
            ?.toString() ??
            "",
      ) ??
          0,
    );
  }
}