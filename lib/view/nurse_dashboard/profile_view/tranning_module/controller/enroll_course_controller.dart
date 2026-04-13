import 'package:restaurent_discount_app/uitilies/api/base_client.dart'; // Import BaseClient
import 'package:get/get.dart';
import 'package:restaurent_discount_app/uitilies/api/api_url.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/tranning_module/controller/all_modules_controller_get.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/tranning_module/module_wise_video.dart';

import '../../../../../uitilies/custom_toast.dart';

class EnrollCourseController extends GetxController {
  var isLoading = false.obs;
  final AllModulesControllerGet _allModulesControllerGet =
      Get.put(AllModulesControllerGet());

  Future<void> addCourseEnroll({required String courseId}) async {
    isLoading(true);

    try {
      var response = await BaseClient.postRequest(
        api: ApiUrl.addEnrollCourse(courseId: courseId),
        body: {},
      );

      if (response.statusCode == 200) {
        CustomToast.showToast("Course enrolled successfully", isError: false);

        Get.to(() => const ModuleWiseVideo());

        _allModulesControllerGet.getModules();
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
