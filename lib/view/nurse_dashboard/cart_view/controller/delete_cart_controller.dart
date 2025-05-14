import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../../../../uitilies/custom_toast.dart';

class DeleteCartController extends GetxController {
  var isLoading = false.obs;

  Future deleteCart({required dynamic cartId}) async {
    try {
      isLoading(true);

      dynamic response = await BaseClient.deleteRequest(
        api: ApiUrl.deleteCart(cartId: cartId),
      );

      dynamic responseBody = await BaseClient.handleResponse(response);

      if (responseBody != null) {
        if (responseBody['success'] == true) {
          CustomToast.showToast('Cart Delete successfully', isError: false);
        } else {
          String errorMessage = responseBody['message'] ?? 'Login failed';

          if (responseBody['errorSources'] != null &&
              responseBody['errorSources'].isNotEmpty) {
            errorMessage =
                responseBody['errorSources'][0]['message'] ?? errorMessage;
          }

          debugPrint('Login error: $errorMessage');

          CustomToast.showToast(errorMessage, isError: true);
        }
      } else {
        throw 'Login Failed!';
      }
    } catch (e) {
      String errorMessage;

      if (e.toString().contains('400')) {
        errorMessage = 'Password does not match';
      } else if (e.toString().contains('404')) {
        errorMessage = 'User Not Found. Please check your credentials.';
      } else {
        errorMessage = e.toString();
      }

      CustomToast.showToast(errorMessage, isError: true);

      debugPrint('Exception caught: $e');
    } finally {
      isLoading(false);
    }
  }
}
