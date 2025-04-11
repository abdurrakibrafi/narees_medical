// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/uitilies/api/local_storage.dart';

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




    });
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
