// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';

class CustomButtonWidget extends StatelessWidget {
  final String btnText;
  final dynamic btnTextSize;
  final dynamic iconSize;
  final bool iconWant;
  final Color? btnTextColor;
  final Color? borderColor;
  final IconData? iconData;
  final Color? suffixIconColor;
  final VoidCallback onTap;

  final Gradient? gradient; 

  const CustomButtonWidget({
    super.key,
    required this.btnText,
    required this.onTap,
    this.gradient,
    this.borderColor,
    this.btnTextColor,
    this.btnTextSize,
    required this.iconWant,
    this.iconData,
    this.suffixIconColor,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.h,
        width: Get.width,
        decoration: BoxDecoration(
          gradient: gradient ?? LinearGradient(
            colors: [Color(0xFF0071BC), Color(0xFF003456)],
            begin: Alignment.topLeft,
            end: Alignment.topRight
          ),
          border: Border.all(color: borderColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (iconWant)
                  FaIcon(
                    iconData,
                    size: iconSize ?? 25.h,
                    color: suffixIconColor ?? Colors.white,
                  ),
                if (iconWant) SizedBox(width: 10),
                Text(
                  btnText,
                  style: GoogleFonts.poppins(
                    fontSize: btnTextSize ?? 15.h,
                    color: btnTextColor ?? Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

