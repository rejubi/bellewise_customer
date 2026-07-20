import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../cart/models/cart_item.dart';
import '../cart/providers/cart_provider.dart';

import 'widgets/category_chip.dart';
import 'widgets/product_card.dart';
import 'widgets/cart_summary_bar.dart';

class VendorScreen extends ConsumerStatefulWidget {
  final String storeName;
  final String image;

  const VendorScreen({
    super.key,
    required this.storeName,
    required this.image,
  });

  @override
  ConsumerState<VendorScreen> createState() =>
      _VendorScreenState();
}

class _VendorScreenState
    extends ConsumerState<VendorScreen> {
int selectedCategory = 0;

final categories = const [
"Chicken",
"Burgers",
"Fries",
"Drinks",
];

void addToCart({
required String name,
required double price,
required String image,
}) {
final notifier = ref.read(cartProvider.notifier);

if (!notifier.canAddFromVendor(widget.storeName)) {
showDialog(
context: context,
builder: (_) => AlertDialog(
title: const Text("Start New Order?"),
content: Text(
"Your cart already contains items from ${notifier.currentVendor}.\n\n"
"Clear your cart and start a new order from ${widget.storeName}?",
),
actions: [
TextButton(
onPressed: () {
Navigator.pop(context);
},
child: const Text("Cancel"),
),
ElevatedButton(
onPressed: () {
notifier.clearCart();

notifier.addItem(
CartItem(
vendor: widget.storeName,
image: image,
name: name,
price: price,
),
vendor: widget.storeName,
);

Navigator.pop(context);

setState(() {});

ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text(
"Started a new order from ${widget.storeName}",
),
),
);
},
child: const Text("Clear Cart"),
),
],
),
);

return;
}

notifier.addItem(
CartItem(
vendor: widget.storeName,
image: image,
name: name,
price: price,
),
vendor: widget.storeName,
);

setState(() {});
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.grey.shade50,

bottomNavigationBar: const CartSummaryBar(),

body: SafeArea(
child: SingleChildScrollView(
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [

Stack(
children: [

Hero(
tag: widget.storeName,
child: Image.asset(
widget.image,
width: double.infinity,
height: 260,
fit: BoxFit.cover,
),
),

Positioned(
top: 18,
left: 18,

child: Material(
elevation: 6,
color: Colors.white,
shape: const CircleBorder(),

child: CircleAvatar(
backgroundColor: Colors.white,

child: IconButton(
icon: const Icon(
Icons.arrow_back_ios_new,
),
onPressed: () {
Navigator.pop(context);
},
),
),
),
),
],
),

Padding(
padding: const EdgeInsets.all(22),

child: AnimatedSwitcher(
duration: const Duration(
milliseconds: 300,
),

child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,

children: [

Row(
children: [

Expanded(
child: Text(
widget.storeName,
style: const TextStyle(
fontSize: 30,
fontWeight:
FontWeight.w800,
letterSpacing: .3,
),
),
),

const Icon(
Icons.star_rounded,
color: Colors.amber,
size: 22,
),

const SizedBox(width: 4),

const Text(
"4.8 (523)",
style: TextStyle(
fontWeight:
FontWeight.bold,
),
),
],
),

const SizedBox(height: 8),

const Text(
"Fast Food • Restaurant",
style: TextStyle(
color: Colors.grey,
fontSize: 15,
fontWeight: FontWeight.w500,
),
),

const SizedBox(height: 20),

Card(
elevation: 2,

shape:
RoundedRectangleBorder(
borderRadius:
BorderRadius.circular(
16,
),
),

child: const Padding(
padding:
EdgeInsets.all(16),

child: Column(
children: [

Row(
children: [

Icon(
Icons.location_on,
color: Color(
0xFFF57C00,
),
),

SizedBox(width: 8),

Expanded(
child: Text(
"Gwarinpa, Abuja",
),
),
],
),

Divider(height: 24),

Row(
children: [

Icon(
Icons
.delivery_dining,
),

SizedBox(width: 8),

Text(
"₦800 Delivery"),

Spacer(),

Icon(
Icons.access_time,
),

SizedBox(width: 8),

Text(
"25–35 mins"),
],
),
],
),
),
),

const SizedBox(height: 22),

Divider(
color:
Colors.grey.shade300,
),

const SizedBox(height: 18),

const Text(
"Browse Menu",
style: TextStyle(
fontSize: 22,
fontWeight:
FontWeight.bold,
),
),

const SizedBox(height: 16),

SizedBox(
height: 45,

child: ListView.builder(
scrollDirection:
Axis.horizontal,
itemCount:
categories.length,

itemBuilder:
(context, index) {
return CategoryChip(
title:
categories[index],
selected:
selectedCategory ==
index,
onTap: () {
setState(() {
selectedCategory =
index;
});
},
);
},
),
),

const SizedBox(height: 22),

Divider(
color:
Colors.grey.shade300,
),

const SizedBox(height: 18),

const Text(
"Chef's Specials",
style: TextStyle(
fontSize: 22,
fontWeight:
FontWeight.bold,
),
),

const SizedBox(height: 20),
  ProductCard(
    image: "assets/stores/chicken_republic.jpg",
    name: "Chicken & Chips",
    description:
    "Crispy fried chicken served with golden fries.",
    price: 5500,
    onAdd: () => addToCart(
      name: "Chicken & Chips",
      price: 5500,
      image: "assets/stores/chicken_republic.jpg",
    ),
  ),

  const SizedBox(height: 18),

  ProductCard(
    image: "assets/stores/chicken_republic.jpg",
    name: "Crunchy Burger",
    description:
    "Chicken burger with cheese and fries.",
    price: 4500,
    onAdd: () => addToCart(
      name: "Crunchy Burger",
      price: 4500,
      image: "assets/stores/chicken_republic.jpg",
    ),
  ),

  const SizedBox(height: 18),

  ProductCard(
    image: "assets/stores/chicken_republic.jpg",
    name: "Spicy Wings",
    description:
    "6 pieces of spicy chicken wings.",
    price: 3500,
    onAdd: () => addToCart(
      name: "Spicy Wings",
      price: 3500,
      image: "assets/stores/chicken_republic.jpg",
    ),
  ),

  const SizedBox(height: 18),

  ProductCard(
    image: "assets/stores/chicken_republic.jpg",
    name: "Family Combo",
    description:
    "Chicken, fries and drinks for four people.",
    price: 12000,
    onAdd: () => addToCart(
      name: "Family Combo",
      price: 12000,
      image: "assets/stores/chicken_republic.jpg",
    ),
  ),

  const SizedBox(height: 30),

  Divider(
    color: Colors.grey.shade300,
  ),

  const SizedBox(height: 20),

  const Text(
    "Restaurant Information",
    style: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  ),

  const SizedBox(height: 15),

  Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    child: const Padding(
      padding: EdgeInsets.all(18),
      child: Column(
        children: [

          Row(
            children: [
              Icon(Icons.schedule),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  "Open Daily\n8:00 AM - 10:00 PM",
                ),
              ),
            ],
          ),

          Divider(height: 30),

          Row(
            children: [
              Icon(Icons.phone),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  "+234 800 123 4567",
                ),
              ),
            ],
          ),

          Divider(height: 30),

          Row(
            children: [
              Icon(Icons.star),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  "523 Reviews • 4.8 Rating",
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ),

  const SizedBox(height: 100),
],
),
),
),
],
),
),
),
);
}
}