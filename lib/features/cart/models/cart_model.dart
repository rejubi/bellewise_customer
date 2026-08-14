import 'cart_item_model.dart';
import 'vendor_cart_model.dart';

class CartModel {
  final int id;

  final VendorCartModel? vendor;

  final List<CartItemModel> items;

  /// Backend calculated values
  final double subtotal;
  final double deliveryFee;
  final double serviceFee;
  final double total;

  CartModel({
    required this.id,
    required this.vendor,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.serviceFee,
    required this.total,
  });

  factory CartModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return CartModel(
      id: json["id"] ?? 0,

      vendor: json["vendor"] == null
          ? null
          : VendorCartModel.fromJson(
        json["vendor"],
      ),

      items: (json["items"] as List? ?? [])
          .map(
            (e) => CartItemModel.fromJson(e),
      )
          .toList(),

      subtotal: double.tryParse(
        json["subtotal"]?.toString() ?? "0",
      ) ??
          0,

      deliveryFee: double.tryParse(
        json["delivery_fee"]?.toString() ?? "0",
      ) ??
          0,

      serviceFee: double.tryParse(
        json["service_fee"]?.toString() ?? "0",
      ) ??
          0,

      total: double.tryParse(
        json["total"]?.toString() ?? "0",
      ) ??
          0,
    );
  }

  // ==========================================================
  // CART STATUS
  // ==========================================================

  bool get isEmpty => items.isEmpty;

  bool get isNotEmpty => items.isNotEmpty;

  // ==========================================================
  // VENDOR
  // ==========================================================

  /// Vendor currently owning this cart.
  int? get vendorId => vendor?.id;

  String get vendorName =>
      vendor?.businessName ?? "";

  bool get hasVendor =>
      vendor != null;

  /// True when the vendor is currently open
  /// and able to receive orders.
  bool get vendorIsOpen {
    return vendor?.isOpen ?? false;
  }

  /// True when the vendor is currently closed
  /// or there is no vendor attached to the cart.
  bool get vendorIsClosed {
    return !vendorIsOpen;
  }

  // ==========================================================
  // CART ITEMS
  // ==========================================================

  CartItemModel? itemForProduct(
      int productId,
      ) {
    try {
      return items.firstWhere(
            (item) =>
        item.productId == productId,
      );
    } catch (_) {
      return null;
    }
  }

  bool containsProduct(
      int productId,
      ) {
    return itemForProduct(productId) != null;
  }

  int quantityForProduct(
      int productId,
      ) {
    final item =
    itemForProduct(productId);

    return item?.quantity ?? 0;
  }

  int get totalItems {
    int count = 0;

    for (final item in items) {
      count += item.quantity;
    }

    return count;
  }

  // ==========================================================
  // VENDOR CHECK
  // ==========================================================

  /// Returns true if this cart belongs to another vendor.
  bool belongsToAnotherVendor(
      int vendorId,
      ) {
    if (vendor == null) {
      return false;
    }

    return vendor!.id != vendorId;
  }
}