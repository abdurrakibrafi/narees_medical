import 'dart:io'; // For File
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:restaurent_discount_app/uitilies/api/api_url.dart';
import 'package:restaurent_discount_app/uitilies/custom_toast.dart';
import 'package:restaurent_discount_app/view/paitent_dashboard_view/auth_view/sign_up_view/otp_submit_for_registration_view.dart';

import '../../../../../uitilies/api/local_storage.dart';
import '../../../../common controller/custom alert dialog/custom_alert_dialog.dart';
import '../../../bottom_navigation_view/bottom_navigation_view.dart';
import '../../../tranning_module/tranning_module_view.dart';

class ProfileCompleteController extends GetxController {
  var isLoading = false.obs;

  /// Add parameters for file uploads
  Future<void> register({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String location,
    required String zipCode,
    required String specialty,
    File? profilePicture,
    File? signature,
    List<File>? nurseDocuments,
  }) async {
    try {
      isLoading(true);

      var uri = Uri.parse(ApiUrl.profileUpdate);
      final StorageService _storageService = StorageService();

      var data = jsonEncode({
        'phoneNumber': phoneNumber,
        'firstName': firstName,
        'lastName': lastName,
        "location": location,
        "zipCode": zipCode,
        "specialty": specialty
      });

      var request = http.MultipartRequest('PATCH', uri)..fields['data'] = data;

      if (profilePicture != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'profilePicture',
          profilePicture.path,
          filename: profilePicture.path.split('/').last,
        ));
      }

      if (signature != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'signature',
          signature.path,
          filename: signature.path.split('/').last,
        ));
      }

      if (nurseDocuments != null && nurseDocuments.isNotEmpty) {
        for (var doc in nurseDocuments) {
          request.files.add(await http.MultipartFile.fromPath(
            'nurseDocuments',
            doc.path,
            filename: doc.path.split('/').last,
          ));
        }
      }
      String? accessToken = _storageService.read<String>('accessToken');

      if (accessToken != null) {
        request.headers['Authorization'] = 'Bearer $accessToken';
      }

      print("Request Fields: ${request.fields}");
      print("Number of Files: ${request.files.length}");

      var response = await request.send();

      String responseBody = await response.stream.bytesToString();

      print('Response status: ${response.statusCode}');
      print('Response body: $responseBody');

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(responseBody);

        if (responseJson['success'] == true) {
          CustomToast.showToast("Profile Update Successfully done");
          CustomAlertDialog.showCustomDialog(
              title: "Congrats",
              content:
                  "Your profile is complete! Now, complete your training to unlock full access.",
              cancelName: "No",
              actionName: "Ok",
              confirmText: "Ok",
              onConfirm: () {
                Get.to(() => DashboardForNurse());

                //Get.to(() => TrainingPortalScreen());
              });
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
