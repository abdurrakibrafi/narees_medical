// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';
import 'package:restaurent_discount_app/view/chat_with_nurse_patient.dart';
import 'package:url_launcher/url_launcher.dart';

class NurseRequestCard extends StatelessWidget {
  final String patientName;
  final String treatmentType;
  final String city;
  final String date;
  final String time;
  final String status;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final String nurseName;
  final String receiverId;
  final String nurseEmail;
  final String nurseSpecialist;
  final bool isLoading;

  final String nurseImageUrl;
  final String? chartPdfUrl;

  const NurseRequestCard({
    Key? key,
    required this.patientName,
    required this.treatmentType,
    required this.city,
    required this.date,
    required this.time,
    required this.status,
    required this.onAccept,
    required this.onReject,
    required this.nurseName,
    required this.nurseEmail,
    required this.nurseSpecialist,
    required this.nurseImageUrl,
    this.chartPdfUrl,
    this.isLoading = false,
    required this.receiverId,
  }) : super(key: key);

  // ✅ URL launcher function
  Future<void> _launchChartPdf() async {
    if (chartPdfUrl == null || chartPdfUrl!.isEmpty) return;
    final Uri uri = Uri.parse(chartPdfUrl!);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isAccepted = status.toLowerCase() == 'accepted';
    final bool isRejected = status.toLowerCase() == 'rejected';

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
              // ── Patient name + status badge ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: patientName,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                  ),
                  _StatusBadge(status: status),
                ],
              ),
              SizedBox(height: 6),

              // ── Treatment type ──
              Row(
                children: [
                  Icon(Icons.healing_outlined, size: 14.sp, color: Colors.grey),
                  SizedBox(width: 4),
                  CustomText(
                    text: 'Treatment: $treatmentType',
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ],
              ),
              SizedBox(height: 4),

              // ── Date ──
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 14.sp, color: Colors.grey),
                  SizedBox(width: 4),
                  CustomText(
                    text: date,
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ],
              ),
              SizedBox(height: 4),

              // ── Time + City ──
              Row(
                children: [
                  Icon(Icons.access_time, size: 14.sp, color: Colors.grey),
                  SizedBox(width: 4),
                  CustomText(text: time, fontSize: 12.sp, color: Colors.grey),
                  Spacer(),
                  Icon(Icons.location_on_outlined,
                      size: 14.sp, color: Colors.grey),
                  SizedBox(width: 4),
                  CustomText(text: city, fontSize: 12.sp, color: Colors.grey),
                ],
              ),

              SizedBox(height: 12),
              Divider(color: Colors.grey.shade200),
              SizedBox(height: 8),

              // ── Nurse Info Label ──
              CustomText(
                text: 'Nurse Info',
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
                color: AppColors.mainColor,
              ),
              SizedBox(height: 10),

              // ── Nurse Info Row (avatar + details) ──
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Picture
                  CircleAvatar(
                    radius: 28.r,
                    backgroundColor: AppColors.mainColor.withOpacity(0.1),
                    child: ClipOval(
                      child: nurseImageUrl.isNotEmpty
                          ? Image.network(
                              nurseImageUrl,
                              width: 56.r,
                              height: 56.r,
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
                              errorBuilder: (context, error, stackTrace) {
                                return _PlaceholderAvatar();
                              },
                            )
                          : _PlaceholderAvatar(),
                    ),
                  ),
                  SizedBox(width: 12.w),

                  // Nurse Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person_outline,
                                size: 14.sp, color: Colors.grey),
                            SizedBox(width: 4),
                            Expanded(
                              child: CustomText(
                                textAlign: TextAlign.start,
                                text: nurseName,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.email_outlined,
                                size: 14.sp, color: Colors.grey),
                            SizedBox(width: 4),
                            Expanded(
                              child: CustomText(
                                textAlign: TextAlign.start,
                                text: nurseEmail,
                                fontSize: 12.sp,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.medical_services_outlined,
                                size: 14.sp, color: Colors.grey),
                            SizedBox(width: 4),
                            Expanded(
                              child: CustomText(
                                textAlign: TextAlign.start,
                                text: nurseSpecialist,
                                fontSize: 12.sp,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14),

              if (!isRejected) ...[
                CustomButtonWidget(
                    btnTextSize: 12.0,
                    btnText: "Message",
                    borderColor: AppColors.mainColor,
                    btnTextColor: AppColors.mainColor,
                    onTap: () {
                      Get.to(() => ChatDetailsPage(
                            name: nurseName,
                            receiverId: receiverId,
                            email: nurseEmail,
                          ));
                    },
                    iconWant: false),
              ],

              SizedBox(height: 10),

              if (isAccepted) ...[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _launchChartPdf,
                    icon: Icon(Icons.picture_as_pdf,
                        color: Colors.white, size: 18.sp),
                    label: Text(
                      'View Chart PDF',
                      style: TextStyle(fontSize: 13.sp, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                  ),
                ),
                // ── Accept / Reject Buttons section replace koro ──
              ] else ...[
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: isLoading ? null : onReject,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: isLoading
                            ? SizedBox(
                                height: 18.h,
                                width: 18.w,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.red,
                                ),
                              )
                            : Text('Reject', style: TextStyle(fontSize: 13.sp)),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed:
                            isLoading ? null : onAccept, // ✅ disable on loading
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: isLoading
                            ? SizedBox(
                                height: 18.h,
                                width: 18.w,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Accept',
                                style: TextStyle(
                                    fontSize: 13.sp, color: Colors.white),
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status.toLowerCase()) {
      case 'accepted':
        color = Colors.green;
        break;
      case 'rejected':
        color = Colors.red;
        break;
      default:
        color = Colors.orange;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

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
        size: 28.sp,
        color: AppColors.mainColor,
      ),
    );
  }
}
