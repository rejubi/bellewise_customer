class MealModel {
  final int id;
  final String vendor;
  final String category;
  final int categoryId;
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

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      id: json["id"],
      vendor: json["vendor"] ?? "",
      category: json["category"] ?? "",
      categoryId: json["category_id"] ?? 0,
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      price: double.tryParse(json["price"].toString()) ?? 0,
      discountPrice: json["discount_price"] == null
          ? null
          : double.tryParse(
        json["discount_price"].toString(),
      ),
      image: json["image"],
      preparationTime: json["preparation_time"] ?? 0,
      available: json["is_available"] ?? false,
      featured: json["is_featured"] ?? false,
    );
  }
}