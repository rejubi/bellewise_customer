class OrderModel {
  final String vendor;
  final String image;
  final double total;
  final String status;
  final DateTime date;

  OrderModel({
    required this.vendor,
    required this.image,
    required this.total,
    required this.status,
    required this.date,
  });
}