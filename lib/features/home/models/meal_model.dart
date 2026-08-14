class MealModel {
  final int id;

  // Vendor
  final String vendor;
  final int vendorId;

  // Category
  final String category;
  final int categoryId;

  // Product
  final String name;
  final String description;
  final double price;
  final double? discountPrice;
  final String? image;
  final int preparationTime;
  final bool available;
  final bool featured;

  MealModel({
    required this.id,
    required this.vendor,
    required this.vendorId,
    required this.category,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.price,
    this.discountPrice,
    this.image,
    required this.preparationTime,
    required this.available,
    required this.featured,
  });

  factory MealModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return MealModel(
      id: json["id"] ?? 0,

      // ======================================================
      // VENDOR
      // ======================================================

      vendor: json["vendor"]?.toString() ?? "",

      vendorId: json["vendor_id"] ?? 0,

      // ======================================================
      // CATEGORY
      // ======================================================

      category: json["category"]?.toString() ?? "",

      categoryId: json["category_id"] ?? 0,

      // ======================================================
      // PRODUCT
      // ======================================================

      name: json["name"]?.toString() ?? "",

      description:
      json["description"]?.toString() ?? "",

      price: double.tryParse(
        json["price"]?.toString() ?? "",
      ) ??
          0,

      discountPrice:
      json["discount_price"] == null
          ? null
          : double.tryParse(
        json["discount_price"].toString(),
      ),

      image: json["image"]?.toString(),

      preparationTime:
      json["preparation_time"] ?? 0,

      available:
      json["is_available"] ?? false,

      featured:
      json["is_featured"] ?? false,
    );
  }
}