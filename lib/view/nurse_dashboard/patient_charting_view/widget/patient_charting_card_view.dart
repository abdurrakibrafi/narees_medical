// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';

import '../../../../common widget/custom_button_widget.dart';
import '../hippa_form_view.dart';

class PatientChartingCard extends StatelessWidget {
  final String city;
  final String date;
  final String treatmentType;
  final String status;
  final String patientName;
  final String time;
  final bool accepted;

  const PatientChartingCard({
    Key? key,
    required this.city,
    required this.date,
    required this.treatmentType,
    required this.status,
    required this.patientName,
    required this.time,
    this.accepted = false,
  }) : super(key: key);

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
                    text: patientName,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
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
                text: 'Treatment Type: $treatmentType',
                fontSize: 12.sp,
                color: Colors.grey,
              ),
              SizedBox(height: 5),
              CustomText(
                text: 'Date: $date',
                fontSize: 12.sp,
                color: Colors.grey,
              ),
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
                    text: time,
                    fontSize: 12.sp,
                    color: Colors.black,
                  ),
                  Spacer(),
                  CustomText(
                    text: "City: $city",
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ],
              ),
              SizedBox(height: 10),
              StatusButton(status: status, color: _statusColor(status)),

              // accepted হলেই শুধু দেখাবে
              if (accepted) ...[
                SizedBox(height: 20),
                CustomButtonWidget(
                  btnColor: Color(0xFFE8F4FA),
                  btnTextSize: 12.h,
                  btnTextColor: AppColors.mainColor,
                  btnText: "Add Patient Chart",
                  onTap: () {},
                  iconWant: true,
                  suffixIconColor: AppColors.mainColor.withOpacity(0.4),
                  iconData: Icons.add,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'complete':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
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
          Icon(Icons.check_circle_outline, color: color),
          SizedBox(width: 5),
          CustomText(
            text: status,
            color: color,
            fontSize: 12.sp,
          ),
        ],
      ),
    );
  }
}