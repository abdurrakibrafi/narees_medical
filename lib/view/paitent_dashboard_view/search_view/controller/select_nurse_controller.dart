// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:restaurent_discount_app/common%20widget/success_full_page_view.dart';
import 'package:restaurent_discount_app/uitilies/api/api_url.dart';
import 'package:restaurent_discount_app/uitilies/custom_toast.dart';
import 'package:restaurent_discount_app/view/bottom_navigation_view/bottom_navigation_bar_for_paitient.dart';

import '../../../../../uitilies/api/local_storage.dart';

class SelectNurseController extends GetxController {
  var isLoading = false.obs;

  Future<void> selectNurse({
    required String nurseId,
  }) async {
    try {
      isLoading(true);

      var uri = Uri.parse(ApiUrl.appointmentCreate);
      final StorageService _storageService = StorageService();

      String? accessToken = _storageService.read<String>('accessToken');

      var request = http.MultipartRequest('PATCH', uri);

      if (accessToken != null && accessToken.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $accessToken';
      }

      request.fields.addAll({
        "nurseId": nurseId,
      });

      print("Request headers: ${request.headers}");

      var response = await request.send();

      String responseBody = await response.stream.bytesToString();

      print('Response status: ${response.statusCode}');
      print('Response body: $responseBody');

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(responseBody);

        if (responseJson['success'] == true) {
          CustomToast.showToast("Appointment create successful!");

          Get.offAll(() => SuccesfullyPageForAll(
              title: "Successful",
              subTitle: "Your appointment create successful,stay with us!",
              onTap: () {
                Get.offAll(() => BottomNavigationBarForPaitient());
              }));
        } else {
          String errorMessage =
              responseJson['message'] ?? 'Update failed. Please try again.';
          CustomToast.showToast(errorMessage, isError: true);
        }
      } else {
        throw 'Failed to update profile. Server error: ${response.statusCode}';
      }
    } catch (e) {
      print('Error during update: $e');
      CustomToast.showToast(e.toString(), isError: true);
    } finally {
      isLoading(false);
    }
  }
}
