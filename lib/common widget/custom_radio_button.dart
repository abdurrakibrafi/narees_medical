// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRadioButton extends StatelessWidget {
  final List<String> options;
  final String selectedValue;
  final ValueChanged<String> onChanged;
  final Color selectedColor;

  CustomRadioButton({
    required this.options,
    required this.selectedValue,
    required this.onChanged,
    this.selectedColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: options.map((option) {
          return Row(
            children: [
              Radio<String>(
                value: option,
                groupValue: selectedValue,
                onChanged: (value) {
                  if (value != null) {
                    onChanged(value);
                  }
                },
                activeColor: selectedColor,
              ),
              Text(
                option,
                style: GoogleFonts.kumbhSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.h,
                ),
              ),
              if (option != options.last) SizedBox(width: 20),
            ],
          );
        }).toList(),
      ),
    );
  }
}
