// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:restaurent_discount_app/uitilies/api/api_url.dart';
import 'package:restaurent_discount_app/uitilies/api/local_storage.dart';
import 'package:restaurent_discount_app/uitilies/custom_toast.dart';
import '../../../../bottom_navigation_view/bottom_navigation_bar_for_paitient.dart';
import '../../../../tranning_module/tranning_module_view.dart';

class SignInController extends GetxController {
  var isLoading = false.obs;
  final StorageService _storageService = StorageService();

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading(true);

      var map = <String, dynamic>{
        "email": email,
        "password": password,
      };

      print("Request Body: $map");

      var response = await http.post(
        Uri.parse(ApiUrl.login),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(map),
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        if (responseBody['success'] == true) {
          String accessToken = responseBody['data']['accessToken'];
          String role = responseBody['data']['role'];
          String id = responseBody['data']['id'];

          await _storageService.write('accessToken', accessToken);
          await _storageService.write('role', role);
          await _storageService.write('id', id);

          // Conditional navigation based on role
          if (role == "NURSE") {
            Get.offAll(
                () => TrainingPortalScreen());
          } else if (role == "PATIENT") {
            Get.offAll(() =>
                BottomNavigationBarForPaitient());
          } else {
            CustomToast.showToast("Invalid role detected", isError: true);
          }

          CustomToast.showToast("Login Successfully Done!");
        } else {
          String errorMessage =
              responseBody['message'] ?? 'Login failed. Please try again.';

          if (responseBody['errorSources'] != null &&
              responseBody['errorSources'] is List) {
            List errorSources = responseBody['errorSources'];
            for (var error in errorSources) {
              if (error['message'] != null) {
                errorMessage = error['message'];
                break;
              }
            }
          }

          CustomToast.showToast(errorMessage, isError: true);
        }
      } else {
        String serverError = 'Invalid Credentials';
        CustomToast.showToast(serverError, isError: true);
      }
    } catch (e) {
      CustomToast.showToast(e.toString(), isError: true);
    } finally {
      isLoading(false);
    }
  }
}
