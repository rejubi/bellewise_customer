import 'package:go_router/go_router.dart';

import '../features/auth/login/login_screen.dart';
import '../features/auth/register/register_screen.dart';
import '../features/cart/models/cart_model.dart';
import '../features/cart/screens/cart_screen.dart';
import '../features/category/screens/category_products_screen.dart';
import '../features/checkout/screens/checkout_screen.dart';
import '../features/orders/screens/order_success_screen.dart';
import '../features/checkout/screens/payment_screen.dart';
import '../features/home/home_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/orders/screens/order_details_screen.dart';
import '../features/orders/screens/orders_screen.dart';
import '../features/orders/screens/tracking_screen.dart';
import '../features/product/screens/product_detail_screen.dart';
import '../features/search/screens/search_screen.dart';
import '../features/splash/splash_screen.dart';
import '../features/vendor/screens/vendor_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/profile/screens/edit_profile_screen.dart';
import '../features/profile/screens/addresses_screen.dart';
import '../features/profile/screens/notifications_screen.dart';
import '../features/profile/screens/change_password_screen.dart';
import '../features/profile/screens/help_support_screen.dart';
import '../features/profile/screens/about_screen.dart';
import '../features/profile/screens/add_address_screen.dart';
import '../features/auth/forgot_password/forgot_password_screen.dart';
import '../features/auth/reset_password/reset_password_screen.dart';

final router = GoRouter(
  initialLocation: '/',

  routes: [
    // ==========================================
    // SPLASH
    // ==========================================

    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),

    // ==========================================
    // ONBOARDING
    // ==========================================

    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),

    // ==========================================
    // AUTH
    // ==========================================

    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),

    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),

    GoRoute(
      path: '/forgot-password',
      builder: (context, state) =>
      const ForgotPasswordScreen(),
    ),

    GoRoute(
      path: '/reset-password',
      builder: (context, state) {
        final token = state.uri.queryParameters["token"] ?? "";
        final uid = state.uri.queryParameters["uid"] ?? "";

        return ResetPasswordScreen(
          uid: uid,
          token: token,
        );
      },
    ),

    // ==========================================
    // HOME
    // ==========================================

    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),

    // ==========================================
    // SEARCH
    // ==========================================

    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchScreen(),
    ),

    // ==========================================
    // CART
    // ==========================================

    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartScreen(),
    ),

    // ==========================================
    // CHECKOUT
    // ==========================================

    GoRoute(
      path: '/checkout',
      builder: (context, state) {
        final cart = state.extra as CartModel;

        return CheckoutScreen(
          cart: cart,
        );
      },
    ),

    // ==========================================
    // PAYMENT
    // ==========================================

    GoRoute(
      path: '/payment',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;

        return PaymentScreen(
          cart: data["cart"] as CartModel,
          address: data["address"] as String,
          phone: data["phone"] as String,
          note: data["note"] as String,
        );
      },
    ),

    // ==========================================
    // ORDER SUCCESS
    // ==========================================

    GoRoute(
      path: '/order-success/:id',
      builder: (context, state) {
        final orderId = int.parse(
          state.pathParameters["id"]!,
        );

        return OrderSuccessScreen(
          orderId: orderId,
        );
      },
    ),

    // ==========================================
    // ORDERS
    // ==========================================

    GoRoute(
      path: '/orders',
      builder: (context, state) => const OrdersScreen(),
    ),

    GoRoute(
      path: '/orders/:id',
      builder: (context, state) {
        final orderId = int.parse(
          state.pathParameters["id"]!,
        );

        return OrderDetailsScreen(
          orderId: orderId,
        );
      },
    ),

    // ==========================================
    // TRACK ORDER
    // ==========================================

    GoRoute(
      path: '/tracking/:id',
      builder: (context, state) {
        final orderId = int.parse(
          state.pathParameters["id"]!,
        );

        return TrackingScreen(
          orderId: orderId,
        );
      },
    ),

    // ==========================================
    // VENDOR
    // ==========================================

    GoRoute(
      path: '/vendor/:id',
      builder: (context, state) {
        final vendorId = int.parse(
          state.pathParameters["id"]!,
        );

        return VendorScreen(
          vendorId: vendorId,
        );
      },
    ),

    // ==========================================
    // CATEGORY PRODUCTS
    // ==========================================

    GoRoute(
      path: '/category/:id',
      builder: (context, state) {
        final categoryId = int.parse(
          state.pathParameters["id"]!,
        );

        return CategoryProductsScreen(
          categoryId: categoryId,
        );
      },
    ),
    // ==========================================
    // PROFILE
    // ==========================================

    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),

    // ==========================================
    // EDIT PROFILE
    // ==========================================

    GoRoute(
      path: '/profile/edit',
      builder: (context, state) =>
      const EditProfileScreen(),
    ),

    // ==========================================
    // ADDRESSES
    // ==========================================

    GoRoute(
      path: '/profile/addresses',
      builder: (context, state) =>
      const AddressesScreen(),
    ),

    GoRoute(
      path: '/profile/addresses/add',
      builder: (context,state)=>
      const AddAddressScreen(),
    ),

    // ==========================================
    // NOTIFICATIONS
    // ==========================================

    GoRoute(
      path: '/profile/notifications',
      builder: (context, state) =>
      const NotificationsScreen(),
    ),

    // ==========================================
    // CHANGE PASSWORD
    // ==========================================

    GoRoute(
      path: '/profile/change-password',
      builder: (context, state) =>
      const ChangePasswordScreen(),
    ),

    // ==========================================
    // HELP & SUPPORT
    // ==========================================

    GoRoute(
      path: '/profile/help',
      builder: (context, state) =>
      const HelpSupportScreen(),
    ),

    // ==========================================
    // ABOUT
    // ==========================================

    GoRoute(
      path: '/profile/about',
      builder: (context, state) =>
      const AboutScreen(),
    ),

    // ==========================================
    // PRODUCT DETAILS
    // ==========================================

    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final productId = int.parse(
          state.pathParameters["id"]!,
        );

        return ProductDetailScreen(
          productId: productId,
        );
      },
    ),
  ],

);