import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/state_city_model.dart';

class GetCityAndStateController extends GetxController {
  var isLoading = false.obs;
  var cartData = StateAndCityModel().obs;

  @override
  void onInit() {
    super.onInit();
    getStateCity();
  }

  getStateCity() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: ApiUrl.stateCity),
      );

      if (responseBody != null) {
        cartData.value = StateAndCityModel.fromJson(responseBody);
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
