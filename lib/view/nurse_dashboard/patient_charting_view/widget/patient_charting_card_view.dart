// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';

import '../hippa_form_view.dart';

class PatientChartingCard extends StatelessWidget {
  PatientChartingCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: AppColors.mainColor,
              width: 5.0,
            ),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "John Doe",
                    fontWeight: FontWeight.bold,
                    fontSize: 19.sp,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => HippaFormView());
                    },
                    child: Icon(
                      Icons.remove_red_eye_outlined,
                      color: Colors.amber,
                    ),
                  )
                ],
              ),
              SizedBox(height: 5),
              CustomText(
                text: 'Treatment Type: Hydration Therapy',
                fontSize: 17.sp,
                color: Colors.grey,
              ),
              SizedBox(height: 5),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 18.sp,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 5),
                  CustomText(
                    text: '3:40 PM',
                    fontSize: 14.sp,
                    color: Colors.black,
                  ),
                  Spacer(),
                  CustomText(
                    text: "Dhaka",
                    fontSize: 16.sp,
                    color: Colors.grey,
                  ),
                ],
              ),
              SizedBox(height: 10),
              StatusButton(status: 'Complete', color: Colors.green),
            ],
          ),
        ),
      ),
    );
  }
}

class StatusButton extends StatelessWidget {
  final String status;
  final Color color;

  StatusButton({required this.status, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
            ),
            SizedBox(width: 5),
            CustomText(
              text: status,
              color: color,
              fontSize: 16.sp,
            ),
          ],
        ));
  }
}
