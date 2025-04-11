import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';

class CustomSnackbar extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;

  const CustomSnackbar({
    Key? key,
    required this.message,
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6.0,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.0.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: textColor,
              ),
              SizedBox(width: 8.0.w),
            ],
            Flexible(
              child: Text(
                message,
                style: TextStyle(
                  color: textColor,
                  fontSize: 15.0.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SnackbarUtil {
  static void showSnackbar({
    required String message,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.showSnackbar(
      GetBar(
        backgroundColor: Colors.transparent,
        duration: duration,
        barBlur: 0,
        overlayBlur: 0,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.0.h),
        borderRadius: 8.0,
        padding: EdgeInsets.zero,
        messageText: CustomSnackbar(
          message: message,
          backgroundColor: backgroundColor,
          textColor: textColor,
          icon: icon,
        ),
      ),
    );
  }

  static void showSuccessSnackbar(String message) {
    showSnackbar(
      message: message,
      backgroundColor: AppColors.mainColor,
      textColor: Colors.white,
      icon: Icons.check_circle,
    );
  }

  static void showErrorSnackbar(String message) {
    showSnackbar(
      message: message,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      icon: Icons.error,
    );
  }
}
