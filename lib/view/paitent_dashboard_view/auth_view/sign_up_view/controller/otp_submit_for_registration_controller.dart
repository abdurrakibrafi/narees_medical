// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, prefer_const_constructors

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:restaurent_discount_app/view/paitent_dashboard_view/auth_view/sign_in_view/sign_in_view.dart';

import '../../../../../uitilies/api/api_url.dart';
import '../../../../../uitilies/api/local_storage.dart';
import '../../../../../uitilies/custom_toast.dart';

class OTPControllerRegistration extends GetxController {
  var isLoading = false.obs;

  final StorageService _storageService = StorageService();

  Future<void> otpSubmit({
    required dynamic otp,
  }) async {
    try {
      isLoading(true);

      final otpToken = await _storageService.read("token");

      int otpInt = int.tryParse(otp) ?? 0;

      var map = <String, dynamic>{
        "otp": otpInt,
      };

      print("Request Body: $map");
      print("otp token $otpToken");

      var response = await http.post(
        Uri.parse(ApiUrl.verifyOTP),
        headers: {"token": otpToken, "content-type": "application/json"},
        body: jsonEncode(map),
      );

      print(response.body);

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        print("==============after success==== ${responseBody}");

        if (responseBody['success'] == true) {

          CustomToast.showToast('Now please login', isError: false);


          
          Get.to(()=> SignInView());
          
          
        } else {
          String errorMessage =
              responseBody['message'] ?? 'Login failed. Please try again.';
          CustomToast.showToast(errorMessage, isError: true);
        }
      } else {
        CustomToast.showToast('OTP request failed', isError: true);
      }
    } catch (e) {
      CustomToast.showToast(e.toString(), isError: true);
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
