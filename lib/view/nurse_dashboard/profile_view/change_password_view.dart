// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
import 'package:restaurent_discount_app/uitilies/constant.dart';

import '../../../common widget/custom_text_filed.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(title: "Change Password"),
        body: Padding(
          padding: AppPadding.bodyPadding,
          child: Column(
            children: [
              SizedBox(height: 35.h),
              CustomTextField(
                fillColor: Color(0xFFE4E4E4),
                borderColor: Colors.transparent,
                hintText: "Enter current password",
                showObscure: false,
              ),
              SizedBox(height: 15.h),
              CustomTextField(
                fillColor: Color(0xFFE4E4E4),
                borderColor: Colors.transparent,
                hintText: "Enter new password",
                showObscure: false,
              ),
              SizedBox(height: 15.h),
              CustomTextField(
                fillColor: Color(0xFFE4E4E4),
                borderColor: Colors.transparent,
                hintText: "Enter confirm password",
                showObscure: false,
              ),
              SizedBox(height: 25.h),
              CustomButtonWidget(
                  gradient: LinearGradient(
                      colors: [
                        Color(0xFF0071BC),
                        Color(0xFF003456)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight),
                  btnText: "Update Password", onTap: () {}, iconWant: false)
            ],
          ),
        ));
  }
}
