class Endpoints {
  static const String baseUrl =
      "https://bellewise.onrender.com/api";

  // Customer
  static const String login = "/customers/login/";
  static const String register = "/customers/register/";
  static const String profile = "/customers/profile/";

  // Home
  static const String home = "/home/";

  // Cart
  static const String cart = "/cart/";
  static const String addToCart = "/cart/add/";
  static const String cartItem = "/cart/item";

  // Catalog
  static const String categories = "/catalog/categories/";
  static const String products = "/catalog/products/";

  // Search
  static const String search = "/search/";

  // JWT
  static const String refresh = "/token/refresh/";
}