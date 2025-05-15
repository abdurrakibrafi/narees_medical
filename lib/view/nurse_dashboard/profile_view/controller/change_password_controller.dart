import 'package:restaurent_discount_app/uitilies/api/base_client.dart'; // Import BaseClient
import 'package:get/get.dart';
import 'package:restaurent_discount_app/view/paitent_dashboard_view/auth_view/sign_in_view/sign_in_view.dart';
import '../../../../uitilies/custom_toast.dart';
import 'package:restaurent_discount_app/uitilies/api/api_url.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/cart_view/controller/cart_get_controller.dart';

class ChangePasswordController extends GetxController {
  var isLoading = false.obs;

  final CartGetController _controller = Get.put(CartGetController());

  Future<void> changePassword(
      {required String oldPass, required dynamic newPass}) async {
    isLoading(true);

    Map<String, dynamic> body = {
      "oldPassword": oldPass,
      "newPassword": newPass
    };

    try {
      var response = await BaseClient.patchRequest(
        api: ApiUrl.changePassword,
        body: body,
      );

      if (response.statusCode == 200) {
        CustomToast.showToast("Password Change Successfully", isError: false);

        Get.offAll(() => SignInView());
        _controller.getCart();
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
