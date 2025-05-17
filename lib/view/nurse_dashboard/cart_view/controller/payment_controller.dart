import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:restaurent_discount_app/view/paitent_dashboard_view/home_view/paitent_home_view.dart';

import '../../../../common widget/success_full_page_view.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/local_storage.dart';
import '../../../../uitilies/custom_toast.dart';
import '../payment_web_view.dart';

class PaymentByStripeController extends GetxController {
  var isLoading = false.obs;
  final StorageService _storageService = Get.put(StorageService());

  Future<void> paymentByStripe({
    required String orderId,
  }) async {
    try {
      isLoading(true);
      String? accessToken = _storageService.read<String>('accessToken');

      var requestBody = jsonEncode({"orderId": orderId});

      if (kDebugMode) {
        print("Sending Request to Stripe API:");
        print("API URL: ${ApiUrl.payment}");
        print("Request Body: $requestBody");
      }

      var response = await http.post(
        Uri.parse(ApiUrl.payment),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: requestBody,
      );

      if (kDebugMode) {
        print("Response Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");
      }

      var responseBody = jsonDecode(response.body);

      if (responseBody['success'] == true) {
        CustomToast.showToast("Redirecting to payment", isError: false);

        String redirectUrl = responseBody['data'];

        if (kDebugMode) {
          print("Stripe Redirect URL: $redirectUrl");
        }

        Get.to(() => PaymentWebView(paymentUrl: redirectUrl));
      } else {
        String errorMessage =
            responseBody['message'] ?? "Payment creation failed.";
        CustomToast.showToast(errorMessage, isError: true);

        if (kDebugMode) {
          print("Error Message: $errorMessage");
        }
      }
    } catch (e) {
      CustomToast.showToast(e.toString(), isError: true);

      if (kDebugMode) {
        print("Error: $e");
      }
    } finally {
      isLoading(false);
    }
  }

  paymentResults({required String finishUrl}) async {
    try {
      isLoading(true);
      String? accessToken = _storageService.read<String>('accessToken');

      log("🔵 Finalizing Payment with URL: $finishUrl");

      var headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      };

      final response = await http.get(Uri.parse(finishUrl), headers: headers);
      log("🟢 Payment Confirmation Response: ${response.body}");

      dynamic responseBody = jsonDecode(response.body);
      log("🔵 Decoded Response: $responseBody");

      if (responseBody["success"] == true) {
        log("✅ Payment Successful. Redirecting...");
        Get.offAll(() => SuccesfullyPageForAll(
            title: "Payment Success",
            subTitle: "Thanks for your online payment",
            onTap: () {
              Get.to(() => HomeViewForPaitinet());
            }));
      } else if (response.statusCode == 302 &&
          responseBody["message"] == 'Cancelled') {
        log("❌ Payment Cancelled. Redirecting...");
        Get.offAll(() => SuccesfullyPageForAll(
            iconData: Icons.highlight_remove_sharp,
            iconColor: Colors.redAccent,
            title: "Payment Cancelled",
            subTitle: "Sorry, please try again.",
            onTap: () {
              Get.to(() => HomeViewForPaitinet());
            }));
      } else {
        log("⚠️ Payment Failed. Redirecting...");
        Get.offAll(() => SuccesfullyPageForAll(
            iconData: Icons.cancel,
            iconColor: Colors.orangeAccent,
            title: "Payment Failed",
            subTitle: "Sorry, your payment has failed.",
            onTap: () {
              Get.to(() => HomeViewForPaitinet());
            }));
      }
    } catch (e) {
      log("⚠️ Error in paymentResults: $e");
    } finally {
      isLoading(false);
    }
  }
}
