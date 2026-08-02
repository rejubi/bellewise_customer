import 'package:go_router/go_router.dart';

import '../features/auth/login/login_screen.dart';
import '../features/auth/register/register_screen.dart';
import '../features/cart/screens/cart_screen.dart';
import '../features/home/home_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/search/screens/search_screen.dart';
import '../features/splash/splash_screen.dart';
import '../features/vendor/screens/vendor_screen.dart';
import '../features/product/screens/product_detail_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),

    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),

    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),

    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),

    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),

    // Vendor Details
    GoRoute(
      path: '/vendor/:id',
      builder: (context, state) {
        final vendorId = int.parse(
          state.pathParameters['id']!,
        );

        return VendorScreen(
          vendorId: vendorId,
        );
      },
    ),

    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchScreen(),
    ),

    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final productId = int.parse(
          state.pathParameters['id']!,
        );

        return ProductDetailScreen(
          productId: productId,
        );
      },
    ),
  ],
);