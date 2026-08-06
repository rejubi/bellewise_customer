class Endpoints {
  static const String baseUrl =
      "https://bellewise.onrender.com/api";

  // ==========================================================
  // Authentication
  // ==========================================================

  static const String login =
      "/customers/login/";

  static const String register =
      "/customers/register/";

  static const String profile =
      "/customers/profile/";

  static const String forgotPassword =
      "/customers/forgot-password/";

  static const String resetPassword =
      "/customers/reset-password/";

  static const String refresh =
      "/token/refresh/";

  // ==========================================================
  // Notifications
  // ==========================================================

  static const String registerFcmToken =
      "/notifications/fcm-token/";

  // ==========================================================
  // Home
  // ==========================================================

  static const String home =
      "/home/";

  // ==========================================================
  // Cart
  // ==========================================================

  static const String cart =
      "/cart/";

  static const String addToCart =
      "/cart/add/";

  static const String cartPricing =
      "/cart/pricing/";

  static const String clearCart =
      "/cart/clear/";

  static const String cartItem =
      "/cart/item";

  // ==========================================================
  // Catalog
  // ==========================================================

  static const String categories =
      "/catalog/categories/";

  static const String products =
      "/catalog/products/";

  // ==========================================================
  // Search
  // ==========================================================

  static const String search =
      "/search/";

  // ==========================================================
  // Orders
  // ==========================================================

  static const String orders =
      "/orders/";

  static const String createOrder =
      "/orders/create/";

  static String orderDetail(
      int orderId,
      ) =>
      "/orders/detail/$orderId/";

  static String orderTracking(
      int orderId,
      ) =>
      "/orders/tracking/$orderId/";

  static String cancelOrder(
      int orderId,
      ) =>
      "/orders/$orderId/cancel/";
}