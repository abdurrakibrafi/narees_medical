import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/supply_order_model_history.dart';

class GetSupplyOrderController extends GetxController {
  var isLoading = false.obs;
  var cartData = SupplyOrderModel().obs;

  @override
  void onInit() {
    super.onInit();
    getMyOrders();
  }

  getMyOrders() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: ApiUrl.orderMy),
      );

      if (responseBody != null) {
        cartData.value = SupplyOrderModel.fromJson(responseBody);
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
