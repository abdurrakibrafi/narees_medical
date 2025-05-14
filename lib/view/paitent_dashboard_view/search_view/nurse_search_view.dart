// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurent_discount_app/common%20controller/custom%20alert%20dialog/custom_alert_dialog.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_success_alert_dialog.dart';
import 'package:restaurent_discount_app/uitilies/constant.dart';

import '../../../uitilies/app_colors.dart';
import 'nurse_card_widget/nurse_card_widget.dart';

class NurseSearchView extends StatelessWidget {
  const NurseSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Search",leading: Container(),),
      body: Padding(
        padding: AppPadding.bodyPadding,
        child: Column(
          children: [
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search here....',
                hintStyle: GoogleFonts.abhayaLibre(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: AppColors.mainColor),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
                suffixIcon: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.mainColor),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Expanded(
                child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (BuildContext context, index) {
                      return NurseCardWidget(
                        nurseName: "Nurse Emma Davis",
                        distance: "3.2 mi",
                        profileImageUrl:
                            "https://c8.alamy.com/comp/D91YB6/beautiful-medical-nurse-portrait-in-office-D91YB6.jpg",
                        services: ["IV Hydration", "Vitamin B12"],
                        availability:
                            "Available Mar 5, 2025, Morning (8 AM - 12 PM)",
                        onTap: () {
                          CustomSuccessAlertDialog.showCustomDialog(
                              title: "Success",
                              content:
                                  "You have successfully selected nurse. We will let you know when the nurse approve your request.",
                              onConfirm: () {});
                        },
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
