class ApiUrl {
  static const String baseUrl = "http://159.223.184.53:6006/api/v1";
  static const String socketGlobal = "https://renti-socket.techcrafters.tech";
  static String imageUrl({String? url}) {
    return "http://192.168.10.5:5005/$url";
  }

  /// live base url
  /// http://159.223.184.53:6006/api/v1


  static String socketURL = "http://115.127.156.14:5006";
  static const String signInEndPoint = "$baseUrl/users/create-customers";
  static const String login = "$baseUrl/auth/login";
  static const String signInWithGoogleLogin =
      "$baseUrl/users/google/create-customers";
  static const String submitReview = "$baseUrl/reviews";
  static const String messageList = "$baseUrl/chat/my-chat-list";
  static const String sendQuote = "$baseUrl/quotes";
  static const String addEmployee = "$baseUrl/users/create-employee";
  static const String profile = "$baseUrl/users/profile";
  static const String popup = "$baseUrl/quotes/amount-popup";
  static const String paymentByCash = "$baseUrl/payments/pay-by-cash";
  static const String paymentByStripe = "$baseUrl/payments/checkout";
  static const String getCoin = "$baseUrl/coins";
  static const String walletGet = "$baseUrl/payments/history?limit=2000000";
  static const String myShop = "$baseUrl/shop/my-shop";
  static const String updateProfile = "$baseUrl/users";
  static const String phoneNumber = "$baseUrl/users/phone/update";
  static const String addService = "$baseUrl/services";
  static const String scanApi = "$baseUrl/quotes/accept/";
  static const String changePassword = "$baseUrl/auth/change-password";
  static const String category = "$baseUrl/categories";
  static const String myService = "$baseUrl/services/my-services";
  static const String myEmployee = "$baseUrl/employees";
  static const String notification = "$baseUrl/notifications/";
  static String quationApprovalApi(
          {required String quateId, required String status}) =>
      "$baseUrl/quotes/$status/$quateId";
  static const String dashboardCount = "$baseUrl/quotes/summery/count";
  static String service({required String page}) =>
      "$baseUrl/services?page=$page";

  static String hireRequestRejection({required String hireId}) =>
      "$baseUrl/hireRequests/$hireId";

  static String getChatId({required String hireId}) =>
      "$baseUrl/chat/customer/$hireId";

  static String cancelOfUser({required String cancelId}) =>
      "$baseUrl/quotes/cancelled/$cancelId";

  static String rejectByUser({required String id}) =>
      "$baseUrl/quotes/reject/$id";

  static String searchService({
    required String page,
    required String searchTerm,
  }) =>
      "$baseUrl/services?page=$page&searchTerm=$searchTerm";

  static String filter({
    required String catId,
    required String page,
    required String priceType,
  }) =>
      "$baseUrl/services?page=$page&category=$catId&serviceType=$priceType";

  static String serviceDetails({required String serviceId}) =>
      "$baseUrl/services/$serviceId";
  static String getContent({required String content}) =>
      "$baseUrl/content?select=$content";
  static const String accountDelete = "$baseUrl/users";
  static String hireRequest({required String page, required String status}) =>
      "$baseUrl/hireRequests/provider?page=$page&status=$status";

  static String hireRequestOfUser({required String page}) =>
      "$baseUrl/hireRequests/?page=$page";

  static String reviewStatistics({required String serviceId}) =>
      "$baseUrl/reviews/stats/$serviceId";

  static String hireRequestDetails({required String id}) =>
      "$baseUrl/hireRequests/$id";

  static String getReview({required String id}) => "$baseUrl/reviews/$id";

  static String historyDetails({required String id}) => "$baseUrl/quotes/$id";

  static String historyData({required String status, required dynamic page}) =>
      "$baseUrl/quotes/provider?status=$status&page=$page";

  static String userQuate({required String status, required dynamic page}) =>
      "$baseUrl/quotes?status=$status&page=$page";

  static String getNearbyLocation(
          {required dynamic lat, required dynamic long}) =>
      "$baseUrl/shop/nearby-shop?longitude=$long&latitude=$lat";

  static String categoryWiseService(
          {required String page, required String catId}) =>
      "$baseUrl/services?page=$page&category=$catId";

  static String hireNow = "$baseUrl/hireRequests";
  static String uploadImage = "$baseUrl/message/upload/images";

  static String shopWiseService(
          {required String shopId, required dynamic page}) =>
      "$baseUrl/services?page=$page&shop=$shopId";
}
