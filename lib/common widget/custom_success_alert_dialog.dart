// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';

class CustomSuccessAlertDialog {
  static void showCustomDialog({
    required String title,
    required String content,
    required VoidCallback onConfirm,
    bool showButton = true,
    List<Widget> customWidgets = const [],
  }) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Icon(
                Icons.check_circle,
                color: AppColors.mainColor,
                size: 70.h,
              ),
              SizedBox(height: 5.h),
              // Title
              Text(
                title,
                style: GoogleFonts.kumbhSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.sp,
                  color: AppColors.mainColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              // Content
              Text(
                content,
                style: GoogleFonts.kumbhSans(
                  fontSize: 14.sp,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              ...customWidgets,
              SizedBox(height: 20.h),
              if (showButton)
                SizedBox(
                  height: 45,
                  width: Get.width / 2.5,
                  child: CustomButtonWidget(
                    gradient: LinearGradient(
                        colors: [Color(0xFF0071BC), Color(0xFF003456)],
                        begin: Alignment.topLeft,
                        end: Alignment.topRight),
                    btnTextColor: Colors.white,
                    btnText: "Go to Home",
                    onTap: onConfirm,
                    iconWant: false,
                  ),
                ),
              SizedBox(
                  height:
                      10.h), // Add spacing between button and custom widgets
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }
}
