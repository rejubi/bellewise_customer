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

  static const String refresh =
      "/token/refresh/";

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

  static const String cartItem =
      "/cart/item";

  // ==========================================================
  // Orders
  // ==========================================================

  static const String createOrder =
      "/orders/create/";

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

  static String orderDetail(
      int orderId,
      ) =>
      "/orders/detail/$orderId/";

  static String cancelOrder(
      int orderId,
      ) =>
      "/orders/$orderId/cancel/";
}