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
    required String? btnText,
    required VoidCallback onConfirm,
    bool showButton = true,
    List<Widget> customWidgets = const [],
    RxBool? isLoading, // new param
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
              Icon(
                Icons.check_circle,
                color: AppColors.mainColor,
                size: 70.h,
              ),
              SizedBox(height: 5.h),
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
                  child: isLoading != null
                      ? Obx(() {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.zero,
                        backgroundColor: Color(0xFF0071BC),
                      ),
                      onPressed: isLoading.value ? null : onConfirm,
                      child: isLoading.value
                          ? SizedBox(
                        width: 24.w,
                        height: 24.h,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : Text(
                        btnText ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    );
                  })
                      : CustomButtonWidget(
                    gradient: LinearGradient(
                        colors: [Color(0xFF0071BC), Color(0xFF003456)],
                        begin: Alignment.topLeft,
                        end: Alignment.topRight),
                    btnTextColor: Colors.white,
                    btnText: btnText ?? "",
                    onTap: onConfirm,
                    iconWant: false,
                  ),
                ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

}
