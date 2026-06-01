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

  final VoidCallback onTap;
  final VoidCallback messageOnTap;

  // ✅ Patient info fields
  final String patientPhone;
  final String patientEmail;
  final String patientImageUrl;

  const PatientChartingCard({
    Key? key,
    required this.city,
    required this.date,
    required this.treatmentType,
    required this.status,
    required this.patientName,
    required this.time,
    this.accepted = false,
    this.patientPhone = '',
    this.patientEmail = '',
    this.patientImageUrl = '',
    required this.onTap,
    required this.messageOnTap,
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
              // ── Patient Info Section ──
              Row(
                children: [
                  // Profile Picture
                  CircleAvatar(
                    radius: 26.r,
                    backgroundColor: AppColors.mainColor.withOpacity(0.1),
                    child: ClipOval(
                      child: patientImageUrl.isNotEmpty
                          ? Image.network(
                              patientImageUrl,
                              width: 52.r,
                              height: 52.r,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.mainColor,
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) =>
                                  _PlaceholderAvatar(),
                            )
                          : _PlaceholderAvatar(),
                    ),
                  ),
                  SizedBox(width: 12.w),

                  // Name + Email + Phone
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name + eye icon
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: patientName,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp,
                            ),
                          ],
                        ),
                        SizedBox(height: 4),

                        // Email
                        if (patientEmail.isNotEmpty)
                          Row(
                            children: [
                              Icon(Icons.email_outlined,
                                  size: 13.sp, color: Colors.grey),
                              SizedBox(width: 4),
                              Expanded(
                                child: CustomText(
                                  textAlign: TextAlign.start,
                                  text: patientEmail,
                                  fontSize: 11.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        SizedBox(height: 4),

                        // Phone
                        if (patientPhone.isNotEmpty)
                          Row(
                            children: [
                              Icon(Icons.phone_outlined,
                                  size: 13.sp, color: Colors.grey),
                              SizedBox(width: 4),
                              CustomText(
                                text: patientPhone,
                                fontSize: 11.sp,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),
              Divider(color: Colors.grey.shade200),
              SizedBox(height: 6),

              // ── Appointment Info ──
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
                  Icon(Icons.access_time, size: 18.sp, color: Colors.grey),
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

              if (status != 'rejected') ...[
                SizedBox(height: 20),
                CustomButtonWidget(
                  iconSize: 23.0,
                  btnColor: AppColors.mainColor,
                  btnTextSize: 12.h,
                  btnTextColor: Colors.white,
                  btnText: "Message",
                  onTap: messageOnTap,
                  iconWant: true,
                  suffixIconColor: Colors.white,
                  iconData: Icons.message_outlined,
                ),
              ],

              if (accepted) ...[
                SizedBox(height: 20),
                CustomButtonWidget(
                  btnColor: Color(0xFFE8F4FA),
                  btnTextSize: 12.h,
                  btnTextColor: AppColors.mainColor,
                  btnText: "Add Patient Chart",
                  onTap: onTap,
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

// ── Placeholder Avatar ──
class _PlaceholderAvatar extends StatelessWidget {
  const _PlaceholderAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.mainColor.withOpacity(0.1),
      child: Icon(
        Icons.person,
        size: 26.sp,
        color: AppColors.mainColor,
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
    return Column(
      children: [
        Container(
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
        ),

        // ✅ status note
        if (status.toLowerCase() == 'accepted') ...[
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.07),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.green.withOpacity(0.3)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, color: Colors.green, size: 16.sp),
                SizedBox(width: 6),
                Expanded(
                  child: CustomText(
                    text:
                        "Your patient has approved the appointment. Please add the patient charting now.",
                    color: Colors.green.shade700,
                    fontSize: 9.sp,
                  ),
                ),
              ],
            ),
          ),
        ] else if (status.toLowerCase() == 'pending') ...[
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.07),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.orange.withOpacity(0.3)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.hourglass_top_outlined,
                    color: Colors.orange, size: 16.sp),
                SizedBox(width: 6),
                Expanded(
                  child: CustomText(
                    text:
                        "Your appointment will be created once the patient approves your application. Please wait.",
                    color: Colors.orange.shade700,
                    fontSize: 9.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
