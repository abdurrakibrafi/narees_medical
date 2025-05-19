// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/nurse_home_view/model/notification_model.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';

class GetNotificationController extends GetxController {
  var isLoading = false.obs;
  var nurseData = NotificationModel().obs;

  @override
  void onInit() {
    super.onInit();
    getNotify();
  }

  getNotify({dynamic date}) async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: ApiUrl.notification),
      );

      if (responseBody != null) {
        nurseData.value = NotificationModel.fromJson(responseBody);
      } else {
        throw 'Failed to fetch cart data!';
      }
    } catch (e) {
      print("Error occurred: $e");
    } finally {
      isLoading(false);
    }
  }
}
