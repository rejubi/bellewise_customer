class CartItem {
  final String vendor;
  final String image;
  final String name;
  final double price;
  int quantity;

  CartItem({
    required this.vendor,
    required this.image,
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  double get total => price * quantity;
}