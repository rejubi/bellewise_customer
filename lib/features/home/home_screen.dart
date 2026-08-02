import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme.dart';
import '../cart/controllers/cart_state.dart';
import '../cart/widgets/floating_cart_button.dart';
import 'controllers/home_controller.dart';
import 'models/home_model.dart';
import 'widgets/bottom_navigation.dart';
import 'widgets/category_section.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/product_section.dart';
import 'widgets/promotion_slider.dart';
import 'widgets/restaurant_section.dart';
import 'widgets/search_field.dart';
import '../../core/errors/error_handler.dart';
import '../../core/widgets/error_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = HomeController();
  final CartState cartState = CartState.instance;

  late Future<HomeModel> _homeFuture;

  @override
  void initState() {
    super.initState();

    _homeFuture = homeController.loadHome();

    if (!cartState.isLoaded) {
      cartState.load();
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _homeFuture = homeController.loadHome();
    });

    await Future.wait([
      _homeFuture,
      cartState.refresh(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: cartState,
      builder: (context, _) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: AppColors.background,

              bottomNavigationBar: HomeBottomNavigation(
                currentIndex: 0,
                onTap: (index) async {
                  switch (index) {
                    case 0:
                      break;

                    case 1:
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Orders coming soon",
                          ),
                        ),
                      );
                      break;

                    case 2:
                      await context.push("/cart");

                      if (mounted) {
                        await cartState.refresh();
                      }
                      break;

                    case 3:
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Favorites coming soon",
                          ),
                        ),
                      );
                      break;

                    case 4:
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Profile coming soon",
                          ),
                        ),
                      );
                      break;
                  }
                },
              ),

              body: SafeArea(
                child: FutureBuilder<HomeModel>(
                  future: _homeFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.hasError) {
                      return ErrorView(
                        message: ErrorHandler.getMessage(snapshot.error),
                        onRetry: _refresh,
                      );
                    }

                    if (!snapshot.hasData) {
                      return const Center(
                        child: Text(
                          "No data available",
                        ),
                      );
                    }

                    final home = snapshot.data!;

                    return RefreshIndicator(
                      onRefresh: _refresh,
                      child: ListView(
                        physics:
                        const AlwaysScrollableScrollPhysics(),
                        children: [
                          HomeAppBar(
                            customer: home.customer,
                            notifications:
                            home.notifications,
                          ),

                          const SizedBox(height: 20),

                          const SearchField(),

                          const SizedBox(height: 20),

                          if (home.promotions.isNotEmpty)
                            PromotionSlider(
                              promotions:
                              home.promotions,
                            ),

                          const SizedBox(height: 20),

                          CategorySection(
                            categories:
                            home.categories,
                          ),

                          const SizedBox(height: 25),

                          RestaurantSection(
                            restaurants:
                            home.restaurants,
                          ),

                          const SizedBox(height: 25),

                          ProductSection(
                            products: home.meals,
                          ),

                          const SizedBox(height: 30),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            /// Floating Cart
            const FloatingCartButton(),
          ],
        );
      },
    );
  }
}