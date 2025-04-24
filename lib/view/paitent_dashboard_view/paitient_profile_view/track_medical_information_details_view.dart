// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/widget/certification_card_widget.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/widget/module_card_widget.dart';

class TrackMedicalDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: CustomText(
            text: 'Training & Certification',
            fontSize: 16.h,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_circle_left_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: TabBar(
            indicatorColor: AppColors.mainColor,
            labelStyle: GoogleFonts.abhayaLibre(fontSize: 15.h),
            tabs: [
              Tab(
                text: 'Completed Modules',
              ),
              Tab(text: 'Certificate'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Completed Modules Tab
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: 4, // Total number of modules
                itemBuilder: (context, index) {
                  return ModuleCard(
                    moduleName: 'Hydration Therapy Basics',
                    progress: '100%',
                    totalLessons: '21/24 Lesson',
                  );
                },
              ),
            ),
            // Certificate Tab
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: 3, // Total number of certificates
                itemBuilder: (context, index) {
                  return CertificateCard(
                    certificateName: 'Hydration Therapy Basics Certificate.pdf',
                    fileSize: '153 Mb',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
