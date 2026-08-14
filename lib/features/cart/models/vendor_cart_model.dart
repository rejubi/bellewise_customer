class VendorCartModel {
  final int id;
  final String businessName;
  final String? logo;

  final bool isOpen;
  final String businessStatus;

  VendorCartModel({
    required this.id,
    required this.businessName,
    this.logo,
    required this.isOpen,
    required this.businessStatus,
  });

  factory VendorCartModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return VendorCartModel(
      id: json["id"] ?? 0,

      businessName:
      json["business_name"]?.toString() ?? "",

      logo:
      json["logo"]?.toString(),

      isOpen:
      json["is_open"] == true,

      businessStatus:
      json["business_status"]?.toString() ?? "CLOSED",
    );
  }

  bool get isClosed => !isOpen;
}