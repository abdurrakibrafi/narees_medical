import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:restaurent_discount_app/common%20widget/custom_success_alert_dialog.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/cart_view/controller/payment_controller.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/custom_toast.dart';
import '../../../../uitilies/api/local_storage.dart';

class OrderCreatePostController extends GetxController {
  var isLoading = false.obs;

  final PaymentByStripeController _paymentByStripeController =
      Get.put(PaymentByStripeController());

  Future orderCreate() async {
    try {
      isLoading(true);

      final StorageService _storageService = StorageService();
      String? token = _storageService.read<String>('accessToken');

      if (token == null || token.isEmpty) {
        CustomToast.showToast('Authorization token not found', isError: true);
        isLoading(false);
        return;
      }

      final uri = Uri.parse(ApiUrl.createCartOrder);

      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['success'] == true) {
          String orderId = responseBody['data']['id'];

          CustomToast.showToast('Order created successfully', isError: false);

          CustomSuccessAlertDialog.showCustomDialog(
            title: "Success",
            content:
                "Your Order was created successfully, please make payment.",
            btnText: 'Payment',
            onConfirm: () {
              if (!_paymentByStripeController.isLoading.value) {
                _paymentByStripeController.paymentByStripe(orderId: orderId);
              }
            },
            isLoading: _paymentByStripeController.isLoading,
          );
        } else {
          String errorMessage =
              responseBody['message'] ?? 'Order creation failed';

          if (responseBody['errorSources'] != null &&
              responseBody['errorSources'].isNotEmpty) {
            errorMessage =
                responseBody['errorSources'][0]['message'] ?? errorMessage;
          }

          CustomToast.showToast(errorMessage, isError: true);
        }
      } else {
        CustomToast.showToast('Failed with status code: ${response.statusCode}',
            isError: true);
      }
    } catch (e) {
      String errorMessage;

      if (e.toString().contains('400')) {
        errorMessage = 'Bad request';
      } else if (e.toString().contains('404')) {
        errorMessage = 'Endpoint not found.';
      } else {
        errorMessage = e.toString();
      }

      CustomToast.showToast(errorMessage, isError: true);
    } finally {
      isLoading(false);
    }
  }
}
