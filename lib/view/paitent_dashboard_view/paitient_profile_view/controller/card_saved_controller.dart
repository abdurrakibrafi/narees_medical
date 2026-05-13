import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../card_saved_screen.dart';

class CardSavedController extends GetxController {
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCardSaved();
  }

  getCardSaved() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(api: ApiUrl.cardSaved, body: {}),
      );

      if (responseBody != null && responseBody['success'] == true) {
        final String url = responseBody['data'];
        Get.to(() => CardSavedScreen(
              url: url,
            ));
      } else {
        throw 'Failed to fetch Stripe connect URL!';
      }
    } catch (e) {
      print("Error occurred: $e");
    } finally {
      isLoading(false);
    }
  }
}
