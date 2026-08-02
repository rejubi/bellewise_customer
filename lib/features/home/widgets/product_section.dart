import 'package:flutter/material.dart';

import '../models/meal_model.dart';
import 'meal_card.dart';

class ProductSection extends StatelessWidget {
  final List<MealModel> products;

  const ProductSection({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Popular Meals",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 15),

        SizedBox(
          height: 250,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            separatorBuilder: (_, __) =>
            const SizedBox(width: 15),
            itemBuilder: (context, index) {
              return MealCard(
                meal: products[index],
              );
            },
          ),
        ),
      ],
    );
  }
}