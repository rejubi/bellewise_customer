import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../app/theme.dart';
import '../models/restaurant_model.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantModel restaurant;

  const RestaurantCard({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(16)),
              child: restaurant.logo == null
                  ? const SizedBox(
                height: 170,
                child: Center(
                  child: Icon(Icons.store, size: 60),
                ),
              )
                  : CachedNetworkImage(
                imageUrl: restaurant.logo!,
                height: 170,
                width: double.infinity,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) =>
                const Icon(Icons.store, size: 60),
              ),
            ),

            ListTile(
              title: Text(
                restaurant.businessName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "${restaurant.rating} ⭐ • ${restaurant.estimatedDeliveryTime} mins",
              ),
              trailing: Text(
                "₦${restaurant.deliveryFee}",
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}