import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  CustomText({
    super.key,
    this.maxLines,
    this.textAlign = TextAlign.center,
    this.left = 0,
    this.right = 0,
    this.top = 0,
    this.bottom = 0,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
    this.color = Colors.black,
    this.text = "",
    this.overflow = TextOverflow.fade,
    this.letterSpace,
    this.underline = false,
  });

  final double left;
  final double right;
  final double top;
  final double bottom;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final String text;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final dynamic letterSpace;
  final bool underline; // Boolean flag to decide whether to underline

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
      child: Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        style: GoogleFonts.abhayaLibre(
          letterSpacing: letterSpace,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          decorationColor: Colors.grey,
          decoration: underline ? TextDecoration.underline : TextDecoration.none, // Conditionally apply underline
        ),
      ),
    );
  }
}
