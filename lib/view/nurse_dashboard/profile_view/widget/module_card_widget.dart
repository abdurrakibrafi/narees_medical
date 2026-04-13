// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';

class ModuleCard extends StatelessWidget {
  final String moduleName;
  final String totalLessons;

  const ModuleCard({
    Key? key,
    required this.moduleName,
    required this.totalLessons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            SizedBox(width: 16),
            // Module Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.menu_book_sharp,
                        size: 15,
                        color: AppColors.mainColor,
                      ),
                      SizedBox(width: 4),
                      CustomText(
                        text: "Course Name:",
                        fontSize: 10.h,
                      )
                    ],
                  ),
                  CustomText(
                    text: moduleName,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.h,
                  ),
                  SizedBox(height: 4),
                  CustomText(
                    text: "Total Lesson: $totalLessons",
                    fontSize: 12.h,
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
