// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, prefer_const_constructors

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:restaurent_discount_app/view/paitent_dashboard_view/auth_view/forget_password_view/otp_verify_view.dart';
import '../../../../../uitilies/api/api_url.dart';
import '../../../../../uitilies/api/local_storage.dart';
import '../../../../../uitilies/custom_toast.dart';

class ForgetPasswordController extends GetxController {
  var isLoading = false.obs;

  final StorageService _storageService = Get.put(StorageService());

  Future<void> forgetPass({
    required String email,
  }) async {
    try {
      isLoading(true);

      // Trim the email to avoid issues with spaces
      email = email.trim();

      // Validate email format
      RegExp emailRegExp = RegExp(
          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      if (!emailRegExp.hasMatch(email)) {
        CustomToast.showToast('Please enter a valid email.', isError: true);
        return;
      }

      var map = <String, dynamic>{
        "email": email,
      };

      print("Request Body: $map");

      var response = await http.post(
        Uri.parse(ApiUrl.forgetPassword),
        headers: {"content-type": "application/json"},
        body: jsonEncode(map),
      );

      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        print("==============after success==== ${responseBody}");

        if (responseBody['success'] == true) {
          String otpToken = responseBody['data']['token'];
          await _storageService.write('token', otpToken);

          Get.to(() => OTPFormView());
        } else {
          String errorMessage = responseBody['message'] ??
              'Login failed. Please try again.';
          CustomToast.showToast(errorMessage, isError: true);
        }
      } else {
        // Handle other status codes
        String errorMessage = 'Failed to send OTP request';
        if (response.statusCode == 404) {
          errorMessage =
          'Email not found, please check the email and try again.';
        }
        CustomToast.showToast(errorMessage, isError: true);
      }
    } catch (e) {
      CustomToast.showToast(e.toString(), isError: true);
      print(e);
    } finally {
      isLoading(false);
    }
  }
}