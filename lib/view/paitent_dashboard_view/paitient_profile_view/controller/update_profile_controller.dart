import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:restaurent_discount_app/uitilies/api/api_url.dart';
import 'package:restaurent_discount_app/uitilies/custom_toast.dart';
import 'package:restaurent_discount_app/view/bottom_navigation_view/bottom_navigation_bar_for_paitient.dart';

import '../../../../../uitilies/api/local_storage.dart';

import 'dart:io';

class UpdateProfileController extends GetxController {
  var isLoading = false.obs;

  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    required String location,
    required String zipCode,
    required String email,
    required String role,
    required String phoneNumber,
    File? profilePicture,
  }) async {
    try {
      isLoading(true);

      var uri = Uri.parse(ApiUrl.profileUpdate);
      final StorageService _storageService = StorageService();

      String? accessToken = _storageService.read<String>('accessToken');

      var request = http.MultipartRequest('PATCH', uri);

      // Add authorization header
      if (accessToken != null && accessToken.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $accessToken';
      }
      if (profilePicture != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'profilePicture',
          profilePicture.path,
          filename: profilePicture.path.split('/').last,
        ));
      }

      // Add fields
      request.fields.addAll({
        'email': email,
        'phoneNumber': phoneNumber,
        'firstName': firstName,
        'lastName': lastName,
        'location': location,
        'zipCode': zipCode,
        'role': role,
      });

      print("Request headers: ${request.headers}");
      print("Request fields: ${request.fields}");

      var response = await request.send();

      String responseBody = await response.stream.bytesToString();

      print('Response status: ${response.statusCode}');
      print('Response body: $responseBody');

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(responseBody);

        if (responseJson['success'] == true) {
          CustomToast.showToast("Profile update successful!");
          Get.to(() => BottomNavigationBarForPaitient());
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
