import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme.dart';
import '../../home/models/meal_model.dart';
import '../controllers/favorites_store.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({
    super.key,
  });

  @override
  State<FavoritesScreen> createState() =>
      _FavoritesScreenState();
}

class _FavoritesScreenState
    extends State<FavoritesScreen> {
  final FavoritesStore favorites =
      FavoritesStore.instance;

  @override
  void initState() {
    super.initState();

    favorites.addListener(_refresh);
  }

  @override
  void dispose() {
    favorites.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = favorites.favorites;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Favorites",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: meals.isEmpty
          ? _buildEmptyState()
          : _buildFavorites(meals),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color:
                AppColors.primary.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.favorite_border,
                size: 60,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "No favorites yet",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "Save meals you love and "
                  "find them here anytime.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 15,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 28),

            ElevatedButton(
              onPressed: () {
                context.go("/home");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Explore Meals",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavorites(
      List<MealModel> meals,
      ) {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: meals.length,
      separatorBuilder: (_, __) =>
      const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final meal = meals[index];

        return _FavoriteMealCard(
          meal: meal,
          onRemove: () {
            favorites.remove(meal.id);
          },
        );
      },
    );
  }
}

class _FavoriteMealCard extends StatelessWidget {
  final MealModel meal;
  final VoidCallback onRemove;

  const _FavoriteMealCard({
    required this.meal,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final price =
        meal.discountPrice ?? meal.price;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          context.push(
            "/product/${meal.id}",
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius:
                BorderRadius.circular(14),
                child: SizedBox(
                  width: 90,
                  height: 90,
                  child: meal.image == null ||
                      meal.image!.isEmpty
                      ? Container(
                    color:
                    Colors.grey.shade200,
                    child: const Icon(
                      Icons.fastfood,
                      size: 36,
                    ),
                  )
                      : CachedNetworkImage(
                    imageUrl: meal.image!,
                    fit: BoxFit.cover,
                    errorWidget:
                        (_, __, ___) {
                      return Container(
                        color:
                        Colors.grey.shade200,
                        child: const Icon(
                          Icons.fastfood,
                          size: 36,
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      meal.name,
                      maxLines: 2,
                      overflow:
                      TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      meal.category,
                      maxLines: 1,
                      overflow:
                      TextOverflow.ellipsis,
                      style: TextStyle(
                        color:
                        Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "₦${price.toStringAsFixed(0)}",
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              IconButton(
                onPressed: onRemove,
                icon: const Icon(
                  Icons.favorite,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}