class PromotionModel {
  final int id;
  final String title;
  final String subtitle;
  final String image;
  final String promotionType;
  final String vendorName;

  final int? vendorId;
  final int? categoryId;
  final int? productId;

  PromotionModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.promotionType,
    required this.vendorName,
    this.vendorId,
    this.categoryId,
    this.productId,
  });

  factory PromotionModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return PromotionModel(
      id: json["id"],

      title: json["title"] ?? "",

      subtitle: json["subtitle"] ?? "",

      image: json["image"] ?? "",

      promotionType:
      json["promotion_type"] ?? "",

      vendorName:
      json["vendor_name"] ?? "",

      vendorId: json["vendor_id"],

      categoryId: json["category_id"],

      productId: json["product_id"],
    );
  }
}