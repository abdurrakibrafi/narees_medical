// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/uitilies/constant.dart';
class ScrollControllerOfIndicator extends GetxController {
  RxInt currentIndex = 0.obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      currentIndex.value = (scrollController.offset / 165.w).round().clamp(0, foodItems.length - 1);
    });
  }

  void scrollToIndex(int index) {
    currentIndex.value = index;
    scrollController.animateTo(
      index * 165.w,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}