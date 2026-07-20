import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../profile/models/favorite_model.dart';
import '../../profile/providers/favorite_provider.dart';

class StoreCard extends ConsumerWidget {
  final String image;
  final String name;
  final String category;
  final double rating;
  final String deliveryTime;
  final String deliveryFee;
  final bool isOpen;
  final String? badge;
  final VoidCallback? onTap;

  const StoreCard({
    super.key,
    required this.image,
    required this.name,
    required this.category,
    required this.rating,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.isOpen,
    this.badge,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(favoriteProvider.notifier);

    final isFavorite = ref.watch(
      favoriteProvider.select(
            (favorites) => favorites.any((e) => e.name == name),
      ),
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 260,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Stack(
              children: [

                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18),
                  ),
                  child: Image.asset(
                    image,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                if (badge != null)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF57C00),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        badge!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                Positioned(
                  top: 10,
                  right: 10,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 20,
                      onPressed: () {
                        notifier.toggleFavorite(
                          FavoriteModel(
                            name: name,
                            image: image,
                            category: category,
                            rating: rating,
                            deliveryTime: deliveryTime,
                            deliveryFee: deliveryFee,
                          ),
                        );
                      },
                      icon: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color:
                        isFavorite ? Colors.red : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [

                      Expanded(
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Row(
                        children: [

                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18,
                          ),

                          const SizedBox(width: 3),

                          Text(
                            rating.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Text(
                    category,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [

                      const Icon(
                        Icons.access_time,
                        size: 17,
                        color: Colors.grey,
                      ),

                      const SizedBox(width: 4),

                      Text(deliveryTime),

                      const Spacer(),

                      const Icon(
                        Icons.delivery_dining,
                        size: 18,
                        color: Colors.grey,
                      ),

                      const SizedBox(width: 4),

                      Text(deliveryFee),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [

                      Icon(
                        Icons.circle,
                        color: isOpen
                            ? Colors.green
                            : Colors.red,
                        size: 11,
                      ),

                      const SizedBox(width: 6),

                      Text(
                        isOpen ? "Open Now" : "Closed",
                        style: TextStyle(
                          color: isOpen
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}