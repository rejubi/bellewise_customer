class VendorProductModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final double? discountPrice;
  final String image;
  final bool isAvailable;
  final int preparationTime;

  final bool isPurchaseable;
  final String? unavailableReason;

  VendorProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discountPrice,
    required this.image,
    required this.isAvailable,
    required this.preparationTime,
    required this.isPurchaseable,
    required this.unavailableReason,
  });

  factory VendorProductModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return VendorProductModel(
      id: json["id"],

      name: json["name"] ?? "",

      description: json["description"] ?? "",

      price: double.parse(
        json["price"].toString(),
      ),

      discountPrice:
      json["discount_price"] == null
          ? null
          : double.parse(
        json["discount_price"].toString(),
      ),

      image: json["image"] ?? "",

      isAvailable:
      json["is_available"] ?? true,

      preparationTime:
      json["preparation_time"] ?? 15,

      isPurchaseable:
      json["is_purchaseable"] ?? false,

      unavailableReason:
      json["unavailable_reason"],
    );
  }
}