// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';

class NurseCardWidget extends StatelessWidget {
  final String nurseName;
  final String distance;
  final String profileImageUrl;
  final List<String> services;
  final String availability;
  final VoidCallback onTap;

  const NurseCardWidget({
    required this.nurseName,
    required this.distance,
    required this.profileImageUrl,
    required this.services,
    required this.availability,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            // Top Row: Profile + Name + Distance
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(profileImageUrl),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CustomText(
                    textAlign: TextAlign.start,
                    text: nurseName,
                    fontSize: 17.h,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Services Tags
            Row(
              children: services.map((service) {
                return Padding(
                  padding: EdgeInsets.only(right: 6),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: service == "IV Hydration"
                          ? Colors.blue.shade100
                          : Colors.green.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      service,
                      style: TextStyle(
                        color: service == "IV Hydration"
                            ? Colors.blue
                            : Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            Divider(height: 20),

            // Availability
            Row(
              children: [
                Icon(Icons.calendar_today_outlined, size: 16),
                SizedBox(width: 6),
                Expanded(
                  child: CustomText(
                    textAlign: TextAlign.start,
                    text: availability,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            // Select Button

            SizedBox(
              height: 31.h,
              child: CustomButtonWidget(
                  btnTextSize: 15.0,
                  btnText: "Select Nurse",
                  onTap: onTap,
                  iconWant: false),
            )
          ],
        ),
      ),
    );
  }
}
