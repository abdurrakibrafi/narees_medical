// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/model/profile_model.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';

class ProfileGetController extends GetxController {
  var isLoading = false.obs;
  var profile = ProfileModel().obs;

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  void getProfile() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: ApiUrl.profile),
      );

      if (responseBody['success'] == true) {
        profile.value = ProfileModel.fromJson(responseBody);
        print("Profile fetched: ${profile.value}");
      } else {
        throw 'Failed to load profile data: ${responseBody['message']}';
      }
    } catch (e) {
      print("Error loading profile: $e");
    } finally {
      isLoading(false);
    }
  }
}
