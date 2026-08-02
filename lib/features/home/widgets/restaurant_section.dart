import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/restaurant_model.dart';
import 'restaurant_card.dart';

class RestaurantSection extends StatelessWidget {
  final List<RestaurantModel> restaurants;

  const RestaurantSection({
    super.key,
    required this.restaurants,
  });

  @override
  Widget build(BuildContext context) {
    if (restaurants.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Featured Restaurants",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 15),

        SizedBox(
          height: 255,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: restaurants.length,
            separatorBuilder: (_, _) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final restaurant = restaurants[index];

              return SizedBox(
                width: 280,
                child: GestureDetector(
                  onTap: () {
                    context.push(
                      "/restaurant/${restaurant.id}",
                    );
                  },
                  child: RestaurantCard(
                    restaurant: restaurant,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}