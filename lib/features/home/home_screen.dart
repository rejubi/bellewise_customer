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
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with WidgetsBindingObserver {
  final HomeController homeController =
  HomeController();

  final CartState cartState =
      CartState.instance;

  late Future<HomeModel> _homeFuture;

  String? _locationAddress;

  bool _loadingLocation = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _homeFuture =
        homeController.loadHome();

    if (!cartState.isLoaded) {
      cartState.load();
    }

    _loadLocationInBackground();
  }

  // ==========================================================
  // LOAD LOCATION
  // ==========================================================

  Future<void> _loadLocationInBackground() async {
    if (_loadingLocation) {
      return;
    }

    _loadingLocation = true;

    if (mounted) {
      setState(() {});
    }

    try {
      // --------------------------------------------------------
      // FIRST: Check cached address.
      // --------------------------------------------------------

      final cached =
          LocationService.currentAddress
              ?.trim() ??
              "";

      if (cached.isNotEmpty) {
        if (mounted) {
          setState(() {
            _locationAddress = cached;
          });
        }

        debugPrint(
          "HOME LOCATION: $_locationAddress",
        );

        return;
      }

      // --------------------------------------------------------
      // Get location.
      // --------------------------------------------------------

      final address =
      await LocationService.getCurrentAddress();

      if (!mounted) {
        return;
      }

      final cleanedAddress =
          address?.trim() ?? "";

      // --------------------------------------------------------
      // If reverse geocoding succeeded.
      // --------------------------------------------------------

      if (cleanedAddress.isNotEmpty) {
        setState(() {
          _locationAddress =
              cleanedAddress;
        });

        debugPrint(
          "HOME LOCATION: $_locationAddress",
        );

        return;
      }

      // --------------------------------------------------------
      // Reverse geocoding may fail even though GPS works.
      //
      // Check the actual GPS position.
      // --------------------------------------------------------

      final position =
          LocationService.currentPosition;

      if (position != null) {
        debugPrint(
          "HOME GPS LOCATION: "
              "${position.latitude}, "
              "${position.longitude}",
        );

        setState(() {
          _locationAddress =
          "Location detected";
        });

        debugPrint(
          "HOME LOCATION: Location detected",
        );
      } else {
        setState(() {
          _locationAddress = null;
        });

        debugPrint(
          "HOME LOCATION: null",
        );
      }
    } catch (e) {
      debugPrint(
        "HOME LOCATION ERROR: $e",
      );

      // --------------------------------------------------------
      // Even if something fails, check whether GPS exists.
      // --------------------------------------------------------

      final position =
          LocationService.currentPosition;

      if (mounted && position != null) {
        setState(() {
          _locationAddress =
          "Location detected";
        });

        debugPrint(
          "HOME LOCATION: Location detected",
        );
      }
    } finally {
      _loadingLocation = false;

      if (mounted) {
        setState(() {});
      }
    }
  }

  // ==========================================================
  // APP LIFECYCLE
  // ==========================================================

  @override
  void didChangeAppLifecycleState(
      AppLifecycleState state,
      ) {
    if (state ==
        AppLifecycleState.resumed) {
      _loadLocationInBackground();
    }
  }

  // ==========================================================
  // DISPOSE
  // ==========================================================

  @override
  void dispose() {
    WidgetsBinding.instance
        .removeObserver(this);

    super.dispose();
  }

  // ==========================================================
  // PULL TO REFRESH
  // ==========================================================

  Future<void> _refresh() async {
    await Future.wait([
      _loadLocationInBackground(),
      _refreshHome(),
      cartState.refresh(),
    ]);
  }

  Future<void> _refreshHome() async {
    if (!mounted) {
      return;
    }

    setState(() {
      _homeFuture =
          homeController.loadHome();
    });

    await _homeFuture;
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: cartState,
      builder: (context, _) {
        return Scaffold(
          backgroundColor:
          AppColors.background,

          // ==================================================
          // BOTTOM NAVIGATION
          // ==================================================

          bottomNavigationBar:
          HomeBottomNavigation(
            currentIndex: 0,
            onTap: (index) async {
              switch (index) {
                case 0:
                  break;

                case 1:
                  await context.push(
                    "/orders",
                  );
                  break;

                case 2:
                  await context.push(
                    "/cart",
                  );

                  if (mounted) {
                    await cartState.refresh();
                  }

                  break;

                case 3:
                  await context.push(
                    "/favorites",
                  );
                  break;

                case 4:
                  await context.push(
                    "/profile",
                  );
                  break;
              }
            },
          ),

          // ==================================================
          // HOME BODY
          // ==================================================

          body: SafeArea(
            child: FutureBuilder<HomeModel>(
              future: _homeFuture,
              builder:
                  (context, snapshot) {
                // ------------------------------------------------
                // LOADING HOME
                // ------------------------------------------------

                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child:
                    CircularProgressIndicator(),
                  );
                }

                // ------------------------------------------------
                // ERROR
                // ------------------------------------------------

                if (snapshot.hasError) {
                  return ErrorView(
                    message:
                    ErrorHandler.getMessage(
                      snapshot.error,
                    ),
                    onRetry: _refresh,
                  );
                }

                // ------------------------------------------------
                // NO DATA
                // ------------------------------------------------

                if (!snapshot.hasData) {
                  return const Center(
                    child: Text(
                      "No data available",
                    ),
                  );
                }

                final home =
                snapshot.data!;

                // ------------------------------------------------
                // HOME CONTENT
                // ------------------------------------------------

                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView(
                    physics:
                    const AlwaysScrollableScrollPhysics(),
                    children: [
                      // ==========================================
                      // HOME APP BAR
                      // ==========================================

                      HomeAppBar(
                        customer:
                        home.customer,
                        notifications:
                        home.notifications,
                        locationAddress:
                        _locationAddress,
                        loadingLocation:
                        _loadingLocation,
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // ==========================================
                      // SEARCH
                      // ==========================================

                      const SearchField(),

                      const SizedBox(
                        height: 20,
                      ),

                      // ==========================================
                      // PROMOTIONS
                      // ==========================================

                      if (home.promotions
                          .isNotEmpty)
                        PromotionSlider(
                          promotions:
                          home.promotions,
                        ),

                      const SizedBox(
                        height: 20,
                      ),

                      // ==========================================
                      // CATEGORIES
                      // ==========================================

                      CategorySection(
                        categories:
                        home.categories,
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      // ==========================================
                      // RESTAURANTS
                      // ==========================================

                      RestaurantSection(
                        restaurants:
                        home.restaurants,
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      // ==========================================
                      // MEALS
                      // ==========================================

                      ProductSection(
                        products:
                        home.meals,
                      ),

                      const SizedBox(
                        height: 30,
                      ),
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