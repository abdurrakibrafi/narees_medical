import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import 'notification_controller.dart';

class DeleteNotificationController extends GetxController {
  var isLoading = false.obs;

  final GetNotificationController _getNotificationController =
      Get.put(GetNotificationController());

  @override
  void onInit() {
    super.onInit();
    deleteNotification();
  }

  deleteNotification({dynamic date}) async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.deleteRequest(api: ApiUrl.deleteNotification),
      );

      if (responseBody != null) {
        await _getNotificationController.getNotify();
      } else {
        throw 'Failed to delete notification!';
      }
    } catch (e) {
      print("Error occurred: $e");
    } finally {
      isLoading(false);
    }
  }
}
