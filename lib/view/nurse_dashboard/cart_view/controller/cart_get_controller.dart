import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/cart_model.dart';

class CartGetController extends GetxController {
  var isLoading = false.obs;
  var cartData = CartGetModel().obs;

  @override
  void onInit() {
    super.onInit();
    getCart();
  }

  getCart() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: ApiUrl.cart),
      );

      if (responseBody != null) {
        cartData.value = CartGetModel.fromJson(responseBody);
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
