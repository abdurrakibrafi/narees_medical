import 'dart:convert';
import 'package:restaurent_discount_app/uitilies/api/base_client.dart'; // Import BaseClient
import 'package:get/get.dart';
import 'package:restaurent_discount_app/uitilies/api/api_url.dart';

import '../../../../../uitilies/custom_toast.dart';
import 'all_modules_controller_get.dart';

class MarkAsAController extends GetxController {
  var isLoading = false.obs;

  final AllModulesControllerGet _controller =
      Get.put(AllModulesControllerGet());

  Future<void> addToMarkAsAComplete({required String moduleId}) async {
    isLoading(true);

    try {
      var response = await BaseClient.postRequest(
        api: ApiUrl.markAsAComplete(moduleId: moduleId),
        body: {},
      );

      if (response.statusCode == 200) {
        CustomToast.showToast("Lesson marked as complete", isError: false);

        _controller.getModules();
      } else {
        throw 'Failed to add product to cart: ${response.body}';
      }
    } catch (e) {
      print("Error occurred while adding product to cart: $e");
    } finally {
      isLoading(false);
    }
  }
}
