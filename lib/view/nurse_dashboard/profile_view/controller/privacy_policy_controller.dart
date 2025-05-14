// ignore_for_file: avoid_print

import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/privacy_policy_model.dart';

class SettingController extends GetxController {
  var isLoading = false.obs;
  var profile = SettingsModel().obs;

  @override
  void onInit() {
    getSettings();
    super.onInit();
  }

  void getSettings() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: ApiUrl.settings),
      );

      if (responseBody['success'] == true) {
        profile.value = SettingsModel.fromJson(responseBody);
        print("fetched: ${profile.value}");
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
