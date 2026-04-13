import 'package:get/get.dart';
import '../../../../../uitilies/api/api_url.dart';
import '../../../../../uitilies/api/base_client.dart';
import '../model/modules_model.dart';

class AllModulesControllerGet extends GetxController {
  var isLoading = false.obs;
  var module = ModuleModelClass().obs;

  @override
  void onInit() {
    super.onInit();
    getModules();
  }

  getModules() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: ApiUrl.allModules),
      );

      if (responseBody != null) {
        module.value = ModuleModelClass.fromJson(responseBody);
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
