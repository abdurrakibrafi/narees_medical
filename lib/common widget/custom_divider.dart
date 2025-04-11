import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';
class CustomDivider extends StatelessWidget {
  final Color? color;
  const CustomDivider({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.only(top: 5.0.h),
      child: Container(
        color: color ?? AppColors.mainColor,
        height: 0.5.h,
        width: Get.width,
      ),
    );
  }
}
