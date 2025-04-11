// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';

class CustomShadowTextFiledVendor extends StatelessWidget {
  final String title;
  final String hintText;
  final bool readOnly;
  final IconData? prefixIcon;

  CustomShadowTextFiledVendor({
    required this.title,
    required this.hintText,
    this.readOnly = false,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40.h,
          decoration: BoxDecoration(
            color: AppColors.bgColor,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade100,
                offset: Offset(1, 1),
                blurRadius: 1,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Colors.grey.shade400,
                offset: Offset(1, 1),
                blurRadius: 1,
                spreadRadius: 1,
              ),
            ],
          ),
          child: TextField(
            readOnly: readOnly,
            decoration: InputDecoration(
              suffixIcon: Icon(prefixIcon),
              hintText: hintText,
              filled: true,
              fillColor: AppColors.bgColor,
              hintStyle: GoogleFonts.kumbhSans(fontSize: 14.h),
              contentPadding: const EdgeInsets.all(16.0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
