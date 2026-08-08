import 'order_item_model.dart';
import 'order_status.dart';

class OrderModel {
  final int id;
  final String publicId;
  final int customer;
  final String customerName;
  final String vendorName;
  final String status;

  final double subtotal;
  final double deliveryFee;
  final double serviceFee;
  final double total;

  final String deliveryAddress;
  final String customerPhone;
  final String customerNote;

  final String paymentMethod;
  final String paymentStatus;

  final DateTime createdAt;

  final List<OrderItemModel> items;

  const OrderModel({
    required this.id,
    required this.publicId,
    required this.customer,
    required this.customerName,
    required this.vendorName,
    required this.status,
    required this.subtotal,
    required this.deliveryFee,
    required this.serviceFee,
    required this.total,
    required this.deliveryAddress,
    required this.customerPhone,
    required this.customerNote,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.createdAt,
    required this.items,
  });

  factory OrderModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return OrderModel(
      id: json["id"],
      publicId: json["public_id"] ?? "",

      customer: json["customer"],

      customerName:
      json["customer_name"] ?? "",

      vendorName:
      json["vendor_name"] ?? "",

      status:
      json["status"] ?? "",

      subtotal: double.parse(
        json["subtotal"].toString(),
      ),

      deliveryFee: double.parse(
        json["delivery_fee"].toString(),
      ),

      serviceFee: double.parse(
        json["service_fee"].toString(),
      ),

      total: double.parse(
        json["total"].toString(),
      ),

      deliveryAddress:
      json["delivery_address"] ?? "",

      customerPhone:
      json["customer_phone"] ?? "",

      customerNote:
      json["customer_note"] ?? "",

      paymentMethod:
      json["payment_method"] ?? "",

      paymentStatus:
      json["payment_status"] ?? "",

      createdAt: DateTime.parse(
        json["created_at"],
      ),

      items: (json["items"] as List)
          .map(
            (e) => OrderItemModel.fromJson(e),
      )
          .toList(),
    );
  }

  OrderStatus get orderStatus =>
      OrderStatusExtension.fromString(status);

  bool get canCancel =>
      orderStatus.canCancel;

  bool get isActive =>
      orderStatus.isActive;

  int get totalItems {
    int count = 0;

    for (final item in items) {
      count += item.quantity;
    }

    return count;
  }

  // ==========================================
  // DISPLAY-FRIENDLY PAYMENT METHOD
  // ==========================================

  String get paymentMethodLabel {
    switch (paymentMethod.toUpperCase()) {
      case "CASH":
        return "Cash on Delivery";

      case "TRANSFER":
        return "Bank Transfer";

      case "BANK_TRANSFER":
        return "Bank Transfer";

      case "CARD":
        return "Card";

      case "WALLET":
        return "Wallet";

      default:
        return paymentMethod.replaceAll(
          "_",
          " ",
        );
    }
  }

  // ==========================================
  // DISPLAY-FRIENDLY PAYMENT STATUS
  // ==========================================

  String get paymentStatusLabel {
    switch (paymentStatus.toUpperCase()) {
      case "PAID":
        return "Paid";

      case "PENDING":
        return "Pending";

      case "FAILED":
        return "Failed";

      case "REFUNDED":
        return "Refunded";

      default:
        return paymentStatus;
    }
  }
}