// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';

class TrainingAndCertificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
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

// Module Card widget for displaying Completed Modules
class ModuleCard extends StatelessWidget {
  final String moduleName;
  final String progress;
  final String totalLessons;

  const ModuleCard({
    Key? key,
    required this.moduleName,
    required this.progress,
    required this.totalLessons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Progress Circle
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue, width: 3),
              ),
              child: Center(
                child: CustomText(
                  text: progress,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 16),
            // Module Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: moduleName,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.h,
                  ),
                  SizedBox(height: 4),
                  CustomText(
                    text: totalLessons,
                    fontSize: 15.h,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Certificate Card widget for displaying Certificates
class CertificateCard extends StatelessWidget {
  final String certificateName;
  final String fileSize;

  const CertificateCard({
    Key? key,
    required this.certificateName,
    required this.fileSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Certificate Icon
            Icon(
              Icons.picture_as_pdf,
              color: Colors.blue,
              size: 30,
            ),
            SizedBox(width: 16),
            // Certificate Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    certificateName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    fileSize,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            // Download Button
            IconButton(
              icon: Icon(Icons.download, color: Colors.blue),
              onPressed: () {
                // Implement the download functionality
                print("Download clicked");
              },
            ),
          ],
        ),
      ),
    );
  }
}
