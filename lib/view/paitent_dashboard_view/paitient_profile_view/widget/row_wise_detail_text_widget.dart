import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';

class RowWiseDetailTextWidget extends StatelessWidget {
  final String title;
  final String value;

  const RowWiseDetailTextWidget(
      {super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: title, fontSize: 16.h, fontWeight: FontWeight.w500),
          CustomText(text: value, fontSize: 16.h, color: Colors.grey),
        ],
      ),
    );
  }
}
