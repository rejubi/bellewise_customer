class VendorModel {
  final int id;
  final String businessName;
  final String description;
  final String logo;
  final String banner;
  final String address;
  final double rating;
  final int totalReviews;
  final double deliveryFee;
  final int deliveryTime;
  final String badge;

  VendorModel({
    required this.id,
    required this.businessName,
    required this.description,
    required this.logo,
    required this.banner,
    required this.address,
    required this.rating,
    required this.totalReviews,
    required this.deliveryFee,
    required this.deliveryTime,
    required this.badge,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      id: json["id"],
      businessName: json["business_name"] ?? "",
      description: json["description"] ?? "",
      logo: json["logo"] ?? "",
      banner: json["banner"] ?? "",
      address: json["address"] ?? "",
      rating: double.tryParse(json["rating"].toString()) ?? 0,
      totalReviews: json["total_reviews"] ?? 0,
      deliveryFee:
      double.tryParse(json["delivery_fee"].toString()) ?? 0,
      deliveryTime:
      json["estimated_delivery_time"] ?? 0,
      badge: json["badge"] ?? "",
    );
  }
}