class CartVendorModel {
  final int id;
  final String businessName;
  final String? logo;

  CartVendorModel({
    required this.id,
    required this.businessName,
    this.logo,
  });

  factory CartVendorModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return CartVendorModel(
      id: json["id"],
      businessName: json["business_name"],
      logo: json["logo"],
    );
  }
}