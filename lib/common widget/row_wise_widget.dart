import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom text/custom_text_widget.dart';

class RowWiseWidget extends StatelessWidget {
  final String title;
  final String subTitle;

  const RowWiseWidget({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: title,
          fontWeight: FontWeight.bold,
          fontSize: 16.h,
        ),
        CustomText(
          text: subTitle,
        )
      ],
    );
  }
}
