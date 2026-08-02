import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../../cart/controllers/cart_state.dart';
import '../models/meal_model.dart';

class MealCard extends StatefulWidget {
  final MealModel meal;

  const MealCard({
    super.key,
    required this.meal,
  });

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
final CartState cart = CartState.instance;

@override
void initState() {
super.initState();

cart.addListener(_refresh);

if (!cart.isLoaded) {
cart.load();
}
}

@override
void dispose() {
cart.removeListener(_refresh);
super.dispose();
}

void _refresh() {
if (mounted) {
setState(() {});
}
}

Future<void> _add() async {
await cart.addProduct(
productId: widget.meal.id,
);

if (!mounted) return;

ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text(
"${widget.meal.name} added to cart",
),
backgroundColor: Colors.green,
),
);
}

Future<void> _increase() async {
await cart.increaseProduct(
widget.meal.id,
);
}

Future<void> _decrease() async {
await cart.decreaseProduct(
widget.meal.id,
);
}

@override
Widget build(BuildContext context) {
final meal = widget.meal;

final quantity = cart.quantityForProduct(meal.id);

return SizedBox(
width: 185,
child: Card(
elevation: 2,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(16),
),
child: InkWell(
borderRadius: BorderRadius.circular(16),
onTap: () {},
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Expanded(
flex: 7,
child: ClipRRect(
borderRadius: const BorderRadius.vertical(
top: Radius.circular(16),
),
child: meal.image == null
? const Center(
child: Icon(
Icons.fastfood,
size: 50,
),
)
: CachedNetworkImage(
imageUrl: meal.image!,
width: double.infinity,
fit: BoxFit.cover,
errorWidget: (context, url, error) =>
const Center(
child: Icon(
Icons.fastfood,
size: 50,
),
),
),
),
),

Padding(
padding: const EdgeInsets.fromLTRB(
10,
10,
10,
4,
),
child: Text(
meal.name,
maxLines: 1,
overflow: TextOverflow.ellipsis,
style: const TextStyle(
fontWeight: FontWeight.bold,
fontSize: 15,
),
),
),

Padding(
padding: const EdgeInsets.symmetric(
horizontal: 10,
),
child: Row(
children: [
Expanded(
child: Text(
"₦${meal.price.toStringAsFixed(0)}",
style: const TextStyle(
color: AppColors.primary,
fontWeight: FontWeight.bold,
fontSize: 16,
),
),
),
  if (quantity == 0)
    SizedBox(
      height: 34,
      child: ElevatedButton(
        onPressed: _add,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
          ),
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(20),
          ),
        ),
        child: const Text("Add"),
      ),
    )
  else
    Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius:
        BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: _decrease,
            icon: const Icon(
              Icons.remove,
              color: Colors.white,
              size: 18,
            ),
          ),
          Text(
            "$quantity",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: _increase,
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              size: 18,
            ),
          ),
        ],
      ),
    ),
],
),
),

  const SizedBox(height: 12),
],
),
),
),
);
}
}