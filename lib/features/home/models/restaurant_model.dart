class RestaurantModel {
  final int id;
  final String businessName;
  final String businessEmail;
  final String businessPhone;
  final String address;
  final String? logo;
  final double rating;
  final int totalReviews;
  final double deliveryFee;
  final int estimatedDeliveryTime;
  final String badge;
  final bool isOpen;

  RestaurantModel({
    required this.id,
    required this.businessName,
    required this.businessEmail,
    required this.businessPhone,
    required this.address,
    this.logo,
    required this.rating,
    required this.totalReviews,
    required this.deliveryFee,
    required this.estimatedDeliveryTime,
    required this.badge,
    required this.isOpen,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json["id"],
      businessName: json["business_name"] ?? "",
      businessEmail: json["business_email"] ?? "",
      businessPhone: json["business_phone"] ?? "",
      address: json["address"] ?? "",
      logo: json["logo"],
      rating: double.tryParse(json["rating"].toString()) ?? 0,
      totalReviews: json["total_reviews"] ?? 0,
      deliveryFee:
      double.tryParse(json["delivery_fee"].toString()) ?? 0,
      estimatedDeliveryTime:
      json["estimated_delivery_time"] ?? 0,
      badge: json["badge"] ?? "",
      isOpen: json["business_status"] == "OPEN",
    );
  }
}