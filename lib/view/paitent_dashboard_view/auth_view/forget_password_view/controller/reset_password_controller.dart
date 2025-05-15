// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, prefer_const_constructors

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:restaurent_discount_app/view/paitent_dashboard_view/auth_view/sign_in_view/sign_in_view.dart';

import '../../../../../uitilies/api/api_url.dart';
import '../../../../../uitilies/api/local_storage.dart';
import '../../../../../uitilies/custom_toast.dart';

class CreateNewPasswordController extends GetxController {
  var isLoading = false.obs;

  final StorageService _storageService = Get.put(StorageService());

  Future<void> resetPassword({
    required String newPass,
  }) async {
    try {
      isLoading(true);
      final otpToken = await _storageService.read("token");

      var map = <String, dynamic>{
        "password": newPass,
      };

      print("Request Body: $map");

      var response = await http.patch(
        Uri.parse(ApiUrl.resetPassword),
        headers: {"token": otpToken, "content-type": "application/json"},
        body: jsonEncode(map),
      );

      print(response.body);

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        print("==============after success==== ${responseBody}");

        if (responseBody['success'] == true) {
          Get.to(() => SignInView());
        } else {
          String errorMessage =
              responseBody['message'] ?? 'Login failed. Please try again.';
          CustomToast.showToast(errorMessage, isError: true);
        }
      } else {
        CustomToast.showToast('Failed to send OTP request', isError: true);
      }
    } catch (e) {
      CustomToast.showToast(e.toString(), isError: true);
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
