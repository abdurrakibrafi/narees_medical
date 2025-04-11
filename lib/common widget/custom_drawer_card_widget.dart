// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawerCardWidget extends StatelessWidget {
  final String cardName;
  final  IconData cardIcon;
  final VoidCallback onTap;
  const CustomDrawerCardWidget({super.key, required this.cardName, required this.cardIcon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.h, 0, 12.h, 0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: Get.width,
          height: 30.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.h),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade100,
                  offset: Offset(1, 1),
                  blurRadius: 0.4,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Colors.grey.shade400,
                  offset: Offset(-1, 1),
                  blurRadius: 0.4,
                  spreadRadius: 0,
                ),
              ],
              color: Color(0xFFF6F5F2)),
          child: Row(
            children: [
              SizedBox(width: 15.h),
              FaIcon(
                cardIcon,
                size: 25,
              ),
              SizedBox(width: 8.h),
              Text(
                cardName,
                style: GoogleFonts.kumbhSans(
                  letterSpacing: 0.7.h,
                    fontWeight: FontWeight.w400, fontSize: 13.h),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
