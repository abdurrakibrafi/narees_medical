import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';

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