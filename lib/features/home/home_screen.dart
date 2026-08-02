import 'package:flutter/material.dart';

import '../../app/theme.dart';
import 'controllers/home_controller.dart';
import 'models/home_model.dart';
import 'widgets/banner_slider.dart';
import 'widgets/bottom_navigation.dart';
import 'widgets/category_section.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/location_card.dart';
import 'widgets/product_section.dart';
import 'widgets/restaurant_section.dart';
import 'widgets/search_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = HomeController();

  late Future<HomeModel> _homeFuture;

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _homeFuture = controller.loadHome();
  }

  Future<void> _refresh() async {
    setState(() {
      _homeFuture = controller.loadHome();
    });

    await _homeFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: HomeBottomNavigation(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });

          // TODO:
          // 0 Home
          // 1 Orders
          // 2 Cart
          // 3 Favorites
          // 4 Profile
        },
      ),
      body: SafeArea(
        child: FutureBuilder<HomeModel>(
          future: _homeFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    snapshot.error.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            if (!snapshot.hasData) {
              return const Center(
                child: Text("No data available"),
              );
            }

            final home = snapshot.data!;

            return RefreshIndicator(
              onRefresh: _refresh,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  HomeAppBar(
                    customer: home.customer,
                    notifications: home.notifications,
                  ),

                  const SizedBox(height: 20),

                  LocationCard(
                    location: home.customer["address"]?.toString().isNotEmpty == true
                        ? home.customer["address"]
                        : "Choose delivery location",
                  ),

                  const SizedBox(height: 20),

                  const SearchField(),

                  const SizedBox(height: 20),

                  BannerSlider(
                    banners: home.banners,
                  ),

                  const SizedBox(height: 25),

                  CategorySection(
                    categories: home.categories,
                  ),

                  const SizedBox(height: 25),

                  RestaurantSection(
                    restaurants: home.restaurants,
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
  }
}