import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme.dart';
import '../../core/errors/error_handler.dart';
import '../../core/services/location_service.dart';
import '../../core/widgets/error_view.dart';
import '../cart/controllers/cart_state.dart';
import 'controllers/home_controller.dart';
import 'models/home_model.dart';
import 'widgets/bottom_navigation.dart';
import 'widgets/category_section.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/product_section.dart';
import 'widgets/promotion_slider.dart';
import 'widgets/restaurant_section.dart';
import 'widgets/search_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with WidgetsBindingObserver {
  final HomeController homeController = HomeController();
  final CartState cartState = CartState.instance;

  late Future<HomeModel> _homeFuture;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _homeFuture = homeController.loadHome();

    if (!cartState.isLoaded) {
      cartState.load();
    }

    _refreshLocation();
  }

  Future<void> _refreshLocation() async {
    await LocationService.refresh();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didChangeAppLifecycleState(
      AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshLocation();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _refresh() async {
    await LocationService.refresh();

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
        return Scaffold(
          backgroundColor: AppColors.background,

          bottomNavigationBar: HomeBottomNavigation(
            currentIndex: 0,
            onTap: (index) async {
              switch (index) {
                case 0:
                  break;

                case 1:
                  await context.push("/orders");
                  break;

                case 2:
                  await context.push("/cart");

                  if (mounted) {
                    await cartState.refresh();
                  }
                  break;

                case 3:
                  await context.push("/favorites");
                  break;

                case 4:
                  await context.push("/profile");
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
                    child:
                    CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return ErrorView(
                    message: ErrorHandler.getMessage(
                      snapshot.error,
                    ),
                    onRetry: _refresh,
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(
                    child:
                    Text("No data available"),
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
        );
      },
    );
  }
}