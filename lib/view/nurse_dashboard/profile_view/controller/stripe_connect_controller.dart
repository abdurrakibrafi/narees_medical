import 'package:get/get.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/cart_view/payment_web_view.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../connect_with_stripe_web_view.dart';

class StripeConnectController extends GetxController {
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getStripeConnect();
  }

  getStripeConnect() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.patchRequest(api: ApiUrl.stripeConnect, body: {}),
      );

      if (responseBody != null && responseBody['success'] == true) {
        final String url = responseBody['data'];
        // ✅ WebView screen এ navigate করবে
        Get.to(() => StripeWebViewScreen(
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
