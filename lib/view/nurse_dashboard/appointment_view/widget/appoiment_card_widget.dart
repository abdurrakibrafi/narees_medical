// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/appointment_view/appoinment_details_view.dart';
import 'package:restaurent_discount_app/view/paitent_dashboard_view/paitient_profile_view/track_medical_information_details_view.dart';

class AppointmentCard extends StatelessWidget {
  final String patientName;
  final String treatmentType;
  final String gfeStatus;
  final String time;
  final String location;
  final bool btnShow;
  final bool goToDetails;

  AppointmentCard({
    required this.patientName,
    required this.treatmentType,
    required this.gfeStatus,
    required this.time,
    required this.location,
    this.btnShow = false,
    this.goToDetails = false,
  });

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case "PENDING":
        return Colors.amber;
      case "CONFIRMED":
        return Colors.blue;
      case "REJECTED":
        return Colors.redAccent;
      case "CANCELLED":
        return Colors.red;
      case "COMPLETED":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(gfeStatus);

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
                    color: AppColors.mainColor,
                    fontSize: 19.sp,
                  ),
                  GestureDetector(
                    onTap: () {
                      goToDetails
                          ? Get.to(() => ViewAppointmentScreen())
                          : Get.to(() => TrackMedicalDetailsView());
                    },
                    child: Icon(
                      Icons.remove_red_eye_outlined,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
              SizedBox(height: 5),
              CustomText(
                text: 'Treatment Type: $treatmentType',
                fontSize: 17.sp,
                color: Colors.black,
              ),
              SizedBox(height: 5),
              CustomText(
                text: 'Status: $gfeStatus',
                fontSize: 14.sp,
                color: Colors.black,
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
                    fontSize: 14.sp,
                    color: Colors.black,
                  ),
                  Spacer(),
                  CustomText(
                    text: location,
                    fontSize: 16.sp,
                    color: Colors.grey,
                  ),
                ],
              ),
              SizedBox(height: 10),
              btnShow
                  ? Row(
                      children: [
                        StatusButton(status: 'PENDING', color: Colors.amber),
                        SizedBox(width: 10),
                        StatusButton(status: 'Canceled', color: Colors.red),
                      ],
                    )
                  : StatusButton(status: gfeStatus, color: statusColor,),
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
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: CustomText(
        text: status,
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: 16.sp,
      ),
    );
  }
}
