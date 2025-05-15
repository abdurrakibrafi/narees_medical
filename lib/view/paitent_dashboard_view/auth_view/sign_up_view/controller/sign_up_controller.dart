import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:restaurent_discount_app/uitilies/api/api_url.dart';
import 'package:restaurent_discount_app/uitilies/custom_toast.dart';
import 'package:restaurent_discount_app/view/paitent_dashboard_view/auth_view/sign_up_view/otp_submit_for_registration_view.dart';

import '../../../../../uitilies/api/local_storage.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String role,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      isLoading(true);

      var uri = Uri.parse(ApiUrl.signInEndPoint);
      final StorageService _storageService = StorageService();

      var data = jsonEncode({
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
        'firstName': firstName,
        'lastName': lastName,
        'role': role,
      });

      var request = http.MultipartRequest('POST', uri)..fields['data'] = data;

      print("Request Body: ${request.fields}");

      // Send the multipart request
      var response = await request.send();

      String responseBody = await response.stream.bytesToString();

      print('Response status: ${response.statusCode}');
      print('Response body: $responseBody');

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(responseBody);

        if (responseJson['success'] == true) {
          String token = responseJson['data']['token'];
          await _storageService.write('token', token);

          CustomToast.showToast("Registration successful! Please enter OTP");
          Get.to(() => OTPFormViewRegistrationView());
        } else {
          String errorMessage = responseJson['message'] ??
              'Registration failed. Please try again.';
          CustomToast.showToast(errorMessage, isError: true);
        }
      } else {
        throw 'Failed to register. Server error: ${response.statusCode}';
      }
    } catch (e) {
      print('Error during registration: $e');
      CustomToast.showToast(e.toString(), isError: true);
    } finally {
      isLoading(false);
    }
  }
}
