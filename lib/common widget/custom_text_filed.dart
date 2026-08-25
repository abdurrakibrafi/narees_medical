import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final bool showObscure;
  final bool? readOnly;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Color? fillColor;
  final Color? borderColor;
  final int? maxLines;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.showObscure,
    this.keyboardType,
    this.controller,
    this.prefixIcon,
    this.fillColor,
    this.borderColor,
    this.maxLines,
    this.readOnly,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      color: Colors.transparent,
      child: TextFormField(
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        readOnly: widget.readOnly ?? false,
        obscureText: widget.showObscure ? _obscureText : false,
        maxLines: widget.showObscure ? 1 : (widget.maxLines ?? 1),

        // Input text font
        style: TextStyle(
          fontFamily: 'Sanchez',
          fontSize: 14.sp,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),

        decoration: InputDecoration(
          // White background
          filled: true,
          fillColor: widget.fillColor ?? Colors.white,

          contentPadding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 14.h,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              color: widget.borderColor ?? AppColors.mainColor,
              width: 1,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              color: widget.borderColor ?? AppColors.mainColor,
              width: 1,
            ),
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(
              color: widget.borderColor ?? AppColors.mainColor,
              width: 1,
            ),
          ),

          prefixIcon: widget.prefixIcon != null
              ? Icon(
            widget.prefixIcon,
            color: AppColors.mainColor,
          )
              : null,

          suffixIcon: widget.showObscure
              ? IconButton(
            icon: Icon(
              _obscureText
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: AppColors.mainColor,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
              : null,

          hintText: widget.hintText,

          // Hint font
          hintStyle: TextStyle(
            fontFamily: 'Sanchez',
            fontSize: 12.sp,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}