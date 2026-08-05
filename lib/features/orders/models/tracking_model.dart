class TrackingModel {
  final int orderId;
  final String status;
  final bool hasRider;

  final String? riderName;
  final String? riderPhone;
  final String? vehicle;

  final double? latitude;
  final double? longitude;

  const TrackingModel({
    required this.orderId,
    required this.status,
    required this.hasRider,
    this.riderName,
    this.riderPhone,
    this.vehicle,
    this.latitude,
    this.longitude,
  });

  factory TrackingModel.fromJson(
      Map<String, dynamic> json,
      ) {
    final rider = json["rider"];

    return TrackingModel(
      orderId: json["order_id"],
      status: json["status"],
      hasRider: json["has_rider"],

      riderName: rider?["name"],
      riderPhone: rider?["phone"],
      vehicle: rider?["vehicle"],

      latitude: rider?["latitude"] == null
          ? null
          : double.parse(
        rider["latitude"].toString(),
      ),

      longitude: rider?["longitude"] == null
          ? null
          : double.parse(
        rider["longitude"].toString(),
      ),
    );
  }
}