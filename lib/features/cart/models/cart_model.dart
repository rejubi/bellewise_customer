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
}