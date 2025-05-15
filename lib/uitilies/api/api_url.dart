class ApiUrl {
  static const String baseUrl = "http://192.168.40.246:4000/api/v1";
  static const String socketGlobal = "https://renti-socket.techcrafters.tech";
  static String imageUrl({String? url}) {
    return "http://192.168.10.5:5005/$url";
  }

  /// live base url
  /// http://159.223.184.53:6006/api/v1

  static const String login = "$baseUrl/auth/sign-in";
  static const String forgetPassword = "$baseUrl/auth/forget-password";
  static const String verifyOTP = "$baseUrl/auth/verify-account";
  static const String resetPassword = "$baseUrl/auth/reset-password";
  static const String signInEndPoint = "$baseUrl/auth/sign-up";
  static const String settings = "$baseUrl/settings";
  static const String cart = "$baseUrl/cart";
  static const String profileUpdate = "$baseUrl/user/profile";
  static const String cartAdd = "$baseUrl/cart/add";
  static const String changePassword = "$baseUrl/auth/change-password";

  static String deleteCart({required String cartId}) => "$baseUrl/cart/$cartId";

  static String getChatId({required String hireId}) =>
      "$baseUrl/chat/customer/$hireId";

  static String inventoryForPatient({required String role}) =>
      "$baseUrl/product?productFor=$role&limit=9999";
}
