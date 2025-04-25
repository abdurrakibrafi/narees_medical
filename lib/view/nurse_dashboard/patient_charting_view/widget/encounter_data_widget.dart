// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../common widget/custom_button_widget.dart';
import '../../../../common widget/custom_text_filed.dart';
import '../../../../uitilies/constant.dart';
import '../../../profile_complete_view/second_step_profile.dart';

class EncounterDataWidget extends StatelessWidget {
  const EncounterDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: AppPadding.bodyPadding,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              CustomText(
                fontWeight: FontWeight.bold,
                text: "Encounter Information",
                fontSize: 16.h,
              ),
              SizedBox(height: 10),
              CustomTextField(
                fillColor: Color(0xFFE4E4E4),
                borderColor: Colors.transparent,
                hintText: "Blood Pressure",
                showObscure: false,
              ),
              SizedBox(height: 20),
              CustomTextField(
                fillColor: Color(0xFFE4E4E4),
                borderColor: Colors.transparent,
                hintText: "Heart Rate (bpm)",
                showObscure: false,
              ),
              SizedBox(height: 20),
              CustomTextField(
                fillColor: Color(0xFFE4E4E4),
                borderColor: Colors.transparent,
                hintText: "Temperature (°F)",
                showObscure: false,
              ),
              SizedBox(height: 20),
              CustomTextField(
                fillColor: Color(0xFFE4E4E4),
                borderColor: Colors.transparent,
                hintText: "Oxygen Level (%)",
                showObscure: false,
              ),
              SizedBox(height: 30),
              SizedBox(
                height: 55,
                width: double.infinity,
                child: CustomButtonWidget(
                  gradient: LinearGradient(
                      colors: [Color(0xFF0071BC), Color(0xFF003456)],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight),
                  btnText: "Submit",
                  onTap: () {
                    Get.to(() => SecondStepProfile());
                  },
                  iconWant: false,
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ));
  }
}
