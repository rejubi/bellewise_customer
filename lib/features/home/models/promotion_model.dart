class PromotionModel {
  final int id;
  final String title;
  final String subtitle;
  final String image;
  final String promotionType;
  final String vendorName;

  PromotionModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.promotionType,
    required this.vendorName,
  });

  factory PromotionModel.fromJson(Map<String, dynamic> json) {
    return PromotionModel(
      id: json["id"],
      title: json["title"] ?? "",
      subtitle: json["subtitle"] ?? "",
      image: json["image"] ?? "",
      promotionType: json["promotion_type"] ?? "",
      vendorName: json["vendor_name"] ?? "",
    );
  }
}