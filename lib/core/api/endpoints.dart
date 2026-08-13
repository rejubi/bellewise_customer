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

  static const String changePassword =
      "/customers/profile/change-password/";

  static const String forgotPassword =
      "/customers/forgot-password/";

  static const String resetPassword =
      "/customers/reset-password/";

  static const String refresh =
      "/token/refresh/";

  // ==========================================================
  // FCM / Notifications
  // ==========================================================

  static const String registerFcmDevice =
      "/fcm/register/";

  static const String deleteFcmDevice =
      "/fcm/delete/";


  // ==========================================================
// Notifications
// ==========================================================

  static const String notifications =
      "/notifications/";

  static String markNotificationRead(int id) =>
      "/notifications/$id/read/";

  static const String markAllNotificationsRead =
      "/notifications/read-all/";

  static String deleteNotification(int id) =>
      "/notifications/$id/delete/";

  static const String notificationUnreadCount =
      "/notifications/unread-count/";

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
      "/orders/$orderId/tracking/";

  static String cancelOrder(
      int orderId,
      ) =>
      "/orders/$orderId/cancel/";
}