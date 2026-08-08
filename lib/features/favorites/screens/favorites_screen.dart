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

class _FavoritesScreenState extends State<FavoritesScreen> {
  final FavoritesStore favorites = FavoritesStore.instance;

  @override
  void initState() {
    super.initState();

    favorites.addListener(_refresh);

    favorites.initialize();
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

      // ==========================================================
      // HEADER
      // ==========================================================

      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 28,
          ),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
        ),

        title: const Text(
          "My Favourites",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // ==========================================================
      // BODY
      // ==========================================================

      body: meals.isEmpty
          ? _buildEmptyState()
          : _buildFavorites(meals),
    );
  }

  // ==============================================================
  // EMPTY STATE
  // ==============================================================

  Widget _buildEmptyState() {
    return Column(
      children: [
        // Saved meal count
        Padding(
          padding: const EdgeInsets.only(
            top: 26,
            bottom: 10,
          ),
          child: Text(
            "0 saved meals",
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
            ),
          ),
        ),

        Expanded(
          child: Center(
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
                    child: const Icon(
                      Icons.favorite_border,
                      size: 60,
                      color: AppColors.primary,
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    "No favourites yet",
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
                      backgroundColor:
                      AppColors.primary,
                      foregroundColor: Colors.white,
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 14,
                      ),
                      shape:
                      RoundedRectangleBorder(
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
          ),
        ),
      ],
    );
  }

  // ==============================================================
  // FAVORITES LIST
  // ==============================================================

  Widget _buildFavorites(List<MealModel> meals) {
    final count = meals.length;

    return Column(
      children: [
        // ----------------------------------------------------------
        // SAVED MEAL COUNT
        // ----------------------------------------------------------

        Padding(
          padding: const EdgeInsets.only(
            top: 26,
            bottom: 10,
          ),
          child: Text(
            count == 1
                ? "1 saved meal"
                : "$count saved meals",
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
            ),
          ),
        ),

        // ----------------------------------------------------------
        // FAVORITES
        // ----------------------------------------------------------

        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(
              20,
              12,
              20,
              30,
            ),
            physics:
            const AlwaysScrollableScrollPhysics(),
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
          ),
        ),
      ],
    );
  }
}

// ==================================================================
// FAVORITE MEAL CARD
// ==================================================================

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
      borderRadius: BorderRadius.circular(20),

      child: InkWell(
        borderRadius: BorderRadius.circular(20),

        onTap: () {
          context.push(
            "/product/${meal.id}",
          );
        },

        child: Padding(
          padding: const EdgeInsets.all(12),

          child: Row(
            children: [
              // ==================================================
              // IMAGE
              // ==================================================

              ClipRRect(
                borderRadius:
                BorderRadius.circular(16),

                child: SizedBox(
                  width: 92,
                  height: 92,

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

                    placeholder:
                        (context, url) {
                      return Container(
                        color:
                        Colors.grey.shade200,
                        child:
                        const Center(
                          child:
                          CircularProgressIndicator(
                            strokeWidth: 2,
                            color:
                            AppColors.primary,
                          ),
                        ),
                      );
                    },

                    errorWidget:
                        (context, url, error) {
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

              // ==================================================
              // MEAL INFORMATION
              // ==================================================

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
                        fontSize: 17,
                        fontWeight:
                        FontWeight.bold,
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
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "₦${price.toStringAsFixed(0)}",
                      style: const TextStyle(
                        color:
                        AppColors.primary,
                        fontSize: 17,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // ==================================================
              // FAVORITE BUTTON
              // ==================================================

              IconButton(
                onPressed: onRemove,
                tooltip:
                "Remove from favourites",
                icon: const Icon(
                  Icons.favorite,
                  color: AppColors.primary,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}