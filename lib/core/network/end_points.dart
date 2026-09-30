class EndPoints {
  static const String baseUrl = "https://api.yumquick.com/v1/";

  // Auth Endpoints
  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String profile = "auth/profile";
  static const String updateProfile = "auth/update-profile";

  // Food & Categories
  static const String categories = "categories";
  static const String bestSellers = "foods/best-seller";
  static const String recommended = "foods/recommended";
  static const String foodDetails = "foods/";

  // Orders & Cart
  static const String cart = "cart";
  static const String createOrder = "orders/create";
  static const String myOrders = "orders/my-orders";
}