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

  static String getChatId({required String hireId}) =>
      "$baseUrl/chat/customer/$hireId";
}
