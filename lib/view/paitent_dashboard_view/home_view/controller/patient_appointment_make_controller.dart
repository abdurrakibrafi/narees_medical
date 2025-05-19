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

class AppointmentMakeController extends GetxController {
  var isLoading = false.obs;

  Future<void> addProductToCart({
    required String firstName,
    required String nurseId,
    required String lastName,
    required String treatmentType,
    required String phoneNumber,
    required bool reminder,
    required String reason,
    required String date,
    required String location,
    required String zipCode,
    List<File>? documents,
  }) async {
    try {
      isLoading(true);

      var uri = Uri.parse(ApiUrl.appointmentCreate);
      final StorageService _storageService = StorageService();

      String? accessToken = _storageService.read<String>('accessToken');

      var request = http.MultipartRequest('POST', uri);

      if (accessToken != null && accessToken.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $accessToken';
      }

      if (documents != null && documents.isNotEmpty) {
        for (var file in documents) {
          request.files.add(await http.MultipartFile.fromPath(
            'documents',
            file.path,
            filename: file.path.split('/').last,
          ));
        }
      }

      request.fields.addAll({
        "firstName": firstName,
        "lastName": lastName,
        "treatmentType": treatmentType,
        "phoneNumber": phoneNumber,
        "nurseId": nurseId,
        "isRemainder": reminder.toString(),
        "reason": reason,
        "date": date,
        "location": location,
        "zipCode": zipCode,
      });

      print("Request headers: ${request.headers}");
      print("Request fields: ${request.fields}");
      print("Uploading ${request.files.length} files");

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
