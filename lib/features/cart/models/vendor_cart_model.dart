class VendorCartModel {
  final int id;
  final String businessName;
  final String? logo;

  VendorCartModel({
    required this.id,
    required this.businessName,
    this.logo,
  });

  factory VendorCartModel.fromJson(Map<String, dynamic> json) {
    return VendorCartModel(
      id: json["id"],
      businessName: json["business_name"] ?? "",
      logo: json["logo"],
    );
  }
}