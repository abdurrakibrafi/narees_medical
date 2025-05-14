import 'package:get/get.dart';
import 'package:restaurent_discount_app/uitilies/api/api_url.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/cart_view/cart_view.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/cart_view/controller/cart_get_controller.dart';

import '../../../../uitilies/api/base_client.dart';
import '../../../../uitilies/custom_toast.dart';

class AddToCartController extends GetxController {
  var isLoading = false.obs;

  final CartGetController _controller = Get.put(CartGetController());

  Future<void> addProductToCart(
      {required String productId, required int quantity}) async {
    isLoading(true);

    Map<String, dynamic> body = {"productId": productId, "quantity": quantity};

    try {
      var response = await BaseClient.postRequest(
        api: ApiUrl.cartAdd,
        body: body,
      );

      if (response.statusCode == 200) {
        CustomToast.showToast("Add to Cart Successfully added", isError: false);

        Get.to(() => CartPage());
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
