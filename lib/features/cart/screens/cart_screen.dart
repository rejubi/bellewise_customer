import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/cart_provider.dart';
import '../../checkout/checkout_screen.dart';

class CartScreen extends ConsumerWidget {
const CartScreen({super.key});

@override
Widget build(BuildContext context, WidgetRef ref) {
final cart = ref.watch(cartProvider);
final notifier = ref.read(cartProvider.notifier);

return Scaffold(
backgroundColor: const Color(0xFFF8F8F8),

appBar: AppBar(
elevation: 0,
backgroundColor: Colors.white,
foregroundColor: Colors.black,
centerTitle: true,
title: const Text(
"My Cart",
style: TextStyle(
fontWeight: FontWeight.bold,
),
),
),

body: cart.isEmpty
? Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [

const Icon(
Icons.shopping_cart_outlined,
size: 90,
color: Colors.grey,
),

const SizedBox(height: 20),

const Text(
"Your cart is empty",
style: TextStyle(
fontSize: 22,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 10),

const Text(
"Looks like you haven't added anything yet.",
textAlign: TextAlign.center,
style: TextStyle(
color: Colors.grey,
fontSize: 16,
),
),

const SizedBox(height: 35),

ElevatedButton(
onPressed: () {
Navigator.pop(context);
},
style: ElevatedButton.styleFrom(
backgroundColor: const Color(0xFFF57C00),
foregroundColor: Colors.white,
padding: const EdgeInsets.symmetric(
horizontal: 40,
vertical: 15,
),
),
child: const Text("Browse Restaurants"),
),
],
),
)
: Column(
children: [

Expanded(
child: ListView.builder(
padding: const EdgeInsets.symmetric(vertical: 10),
itemCount: cart.length,
itemBuilder: (context, index) {

final item = cart[index];

return Dismissible(
key: ValueKey(item.name),

direction: DismissDirection.endToStart,

background: Container(
margin: const EdgeInsets.symmetric(
horizontal: 16,
vertical: 8,
),
decoration: BoxDecoration(
color: Colors.red,
borderRadius: BorderRadius.circular(18),
),
alignment: Alignment.centerRight,
padding: const EdgeInsets.only(right: 24),
child: const Icon(
Icons.delete,
color: Colors.white,
size: 30,
),
),

onDismissed: (_) {
notifier.removeItem(index);
},

child: Card(
elevation: 5,
shadowColor: Colors.black12,
margin: const EdgeInsets.symmetric(
horizontal: 16,
vertical: 8,
),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(18),
),
child: Padding(
padding: const EdgeInsets.all(14),
child: Row(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [

ClipRRect(
borderRadius:
BorderRadius.circular(14),
child: Image.asset(
item.image,
width: 90,
height: 90,
fit: BoxFit.cover,
),
),

const SizedBox(width: 15),

Expanded(
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [

Text(
item.name,
style: const TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 6),

const Text(
"Freshly prepared and delicious.",
style: TextStyle(
color: Colors.grey,
fontSize: 13,
),
),

const SizedBox(height: 10),

Text(
"₦${item.price.toStringAsFixed(0)}",
style: const TextStyle(
color: Color(0xFFF57C00),
fontSize: 19,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 12),

Container(
decoration: BoxDecoration(
color: const Color(0xFFF57C00),
borderRadius:
BorderRadius.circular(30),
),
child: Row(
mainAxisSize:
MainAxisSize.min,
children: [

IconButton(
icon: const Icon(
Icons.remove,
color: Colors.white,
),
onPressed: () {
notifier.decreaseQuantity(index);
},
),

Text(
"${item.quantity}",
style: const TextStyle(
color: Colors.white,
fontWeight:
FontWeight.bold,
fontSize: 18,
),
),

IconButton(
icon: const Icon(
Icons.add,
color: Colors.white,
),
onPressed: () {
notifier.increaseQuantity(index);
},
),
],
),
),
],
),
),
],
),
),
),
);
},
),
),                Container(
    padding: const EdgeInsets.all(20),
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(28),
        topRight: Radius.circular(28),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 12,
        ),
      ],
    ),

    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Subtotal",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "₦${notifier.subtotal.toStringAsFixed(0)}",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF57C00),
              ),
            ),
          ],
        ),

        const SizedBox(height: 22),

        SizedBox(
          width: double.infinity,
          height: 58,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                  const CheckoutScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
              const Color(0xFFF57C00),
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              "Proceed to Checkout",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  ),
],
),
);
}
}