import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/marketing_material_model.dart';

class MarketingMaterialController extends GetxController {
  var isLoading = false.obs;
  var cartData = MarketingMaterialModel().obs;

  @override
  void onInit() {
    super.onInit();
    getMaterial();
  }

  // Fetches the cart data
  getMaterial() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: ApiUrl.marketingMaterial),
      );

      if (responseBody != null) {
        cartData.value = MarketingMaterialModel.fromJson(responseBody);
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
