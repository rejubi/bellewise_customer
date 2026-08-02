class ProductDetailModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final double? discountPrice;
  final String image;
  final int preparationTime;
  final bool available;
  final String category;

  // Vendor
  final int vendorId;
  final String vendorName;
  final String vendorLogo;
  final String vendorBanner;
  final double vendorRating;
  final int totalReviews;
  final double deliveryFee;
  final int deliveryTime;
  final String badge;
  final String address;
  final bool isOpen;

  ProductDetailModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.discountPrice,
    required this.image,
    required this.preparationTime,
    required this.available,
    required this.category,
    required this.vendorId,
    required this.vendorName,
    required this.vendorLogo,
    required this.vendorBanner,
    required this.vendorRating,
    required this.totalReviews,
    required this.deliveryFee,
    required this.deliveryTime,
    required this.badge,
    required this.address,
    required this.isOpen,
  });

  factory ProductDetailModel.fromJson(
      Map<String, dynamic> json,
      ) {
    final vendor = json["vendor"] ?? {};

    return ProductDetailModel(
      id: json["id"],

      name: json["name"] ?? "",

      description: json["description"] ?? "",

      price: double.parse(
        json["price"].toString(),
      ),

      discountPrice: json["discount_price"] == null
          ? null
          : double.parse(
        json["discount_price"].toString(),
      ),

      image: json["image"] ?? "",

      preparationTime:
      json["preparation_time"] ?? 15,

      available:
      json["is_available"] ?? true,

      category: json["category"].toString(),

      vendorId: json["vendor_id"] ?? 0,

      vendorName:
      vendor["business_name"] ?? "",

      vendorLogo:
      vendor["logo"] ?? "",

      vendorBanner:
      vendor["banner"] ?? "",

      vendorRating: double.parse(
        (vendor["rating"] ?? 0).toString(),
      ),

      totalReviews:
      vendor["total_reviews"] ?? 0,

      deliveryFee: double.parse(
        (vendor["delivery_fee"] ?? 0).toString(),
      ),

      deliveryTime:
      vendor["delivery_time"] ?? 0,

      badge:
      vendor["badge"] ?? "",

      address:
      vendor["address"] ?? "",

      isOpen:
      vendor["is_open"] ?? false,
    );
  }
}