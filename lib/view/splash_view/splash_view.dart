// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';
import 'package:restaurent_discount_app/uitilies/app_images.dart';
import 'controller/splash_controller.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SplashController controller = Get.put(SplashController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 230.h),
            Image.asset(
              AppImages.logo,
              width: 225.w,
            ),
            Spacer(),
            LoadingAnimationWidget.beat(
              color: AppColors.mainColor,
              size: 38.h,
            ),
            SizedBox(height: 70.h),
          ],
        ),
      ),
    );
  }
}
