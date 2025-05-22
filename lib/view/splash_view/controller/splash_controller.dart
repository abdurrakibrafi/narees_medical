// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/uitilies/api/local_storage.dart';
import 'package:restaurent_discount_app/view/bottom_navigation_view/bottom_navigation_bar_for_paitient.dart';
import 'package:restaurent_discount_app/view/bottom_navigation_view/bottom_navigation_view.dart';

import '../../paitent_dashboard_view/auth_view/sign_in_view/get_started_view.dart';

class SplashController extends GetxController {
  Timer? timer;
  var opacity = 0.0.obs;
  final StorageService _storageService = Get.put(StorageService());

  @override
  void onInit() {
    super.onInit();

    timer = Timer.periodic(Duration(seconds: 3), (Timer t) {
      if (opacity.value != 1.0) {
        opacity.value += 0.5;
      }
    });

    Future.delayed(const Duration(seconds: 3), () async {
      String? accessToken = await _storageService.read('accessToken');
      String? role = await _storageService.read('role');

      if (accessToken != null && accessToken.isNotEmpty) {
        if (role == "NURSE") {
          Get.off(() => DashboardForNurse());
        } else if (role == "PATIENT") {
          Get.off(() => BottomNavigationBarForPaitient());
        } else {
          Get.off(() => GetStartedView());
        }
      } else {
        Get.off(() => GetStartedView());
      }
    });
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
