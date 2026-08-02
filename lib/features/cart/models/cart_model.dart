import 'cart_item_model.dart';
import 'vendor_cart_model.dart';

class CartModel {
  final int id;

  final VendorCartModel? vendor;

  final List<CartItemModel> items;

  final double total;

  CartModel({
    required this.id,
    required this.vendor,
    required this.items,
    required this.total,
  });

  factory CartModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return CartModel(
      id: json["id"],

      vendor: json["vendor"] == null
          ? null
          : VendorCartModel.fromJson(
        json["vendor"],
      ),

      items: (json["items"] as List)
          .map(
            (e) => CartItemModel.fromJson(e),
      )
          .toList(),

      total: double.parse(
        json["total"].toString(),
      ),
    );
  }

  bool get isEmpty => items.isEmpty;

  bool get isNotEmpty => items.isNotEmpty;

  /// Vendor currently owning this cart
  int? get vendorId => vendor?.id;

  String get vendorName =>
      vendor?.businessName ?? "";

  bool get hasVendor => vendor != null;

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
    return itemForProduct(productId) !=
        null;
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