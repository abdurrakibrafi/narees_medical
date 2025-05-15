import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/all_nurse_model_widget.dart';

class AllNurseController extends GetxController {
  var isLoading = false.obs;
  var nurseData = AllNurseModel().obs;

  @override
  void onInit() {
    super.onInit();
    getNurse();
  }

  // Fetches the cart data
  getNurse() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: ApiUrl.allNurse),
      );

      if (responseBody != null) {
        nurseData.value = AllNurseModel.fromJson(responseBody);
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
