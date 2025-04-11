// text_styles.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle dynamicStyle({
    required double fontSize,
    required FontWeight fontWeight,
    Color? color,
  }) {
    return GoogleFonts.kumbhSans(
      fontSize: fontSize.h,
      fontWeight: fontWeight,
      color: color ?? Colors.black,
    );
  }


}
