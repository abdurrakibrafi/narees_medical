import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/payment_recept_model.dart';

class ReceiptController extends GetxController {
  var isLoading = false.obs;
  var cartData = PaymentReciptModel().obs;

  @override
  void onInit() {
    super.onInit();
    getReceipt();
  }

  getReceipt() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: ApiUrl.orderMy),
      );

      if (responseBody != null) {
        cartData.value = PaymentReciptModel.fromJson(responseBody);
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
