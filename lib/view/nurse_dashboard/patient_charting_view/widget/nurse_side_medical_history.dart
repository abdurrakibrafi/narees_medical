// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../common widget/custom_button_widget.dart';
import '../../../../common widget/custom_dropdown_controller.dart';
import '../../../../common widget/custom_text_filed.dart';
import '../../../../uitilies/constant.dart';

class NurseSideMedicalHistory extends StatelessWidget {
  const NurseSideMedicalHistory({super.key});

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
                text: "Log Procedures",
                fontSize: 18.h,
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: CustomDropdown(
                  label: 'Procedure Performed',
                  hint: 'Select Medications Administered',
                  value: 'e.g., Vitamin B12 - 20',
                  items: [
                    'e.g., Vitamin B12 - 20',
                    'General Practitioner',
                    'Nurse',
                    'Surgeon'
                  ],
                  onChanged: (value) {
                    print(value);
                  },
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: CustomDropdown(
                  label: 'Medications Administered',
                  hint: 'Select Medications Administered',
                  value: 'e.g., Vitamin B12 - 20',
                  items: [
                    'e.g., Vitamin B12 - 20',
                    'General Practitioner',
                    'Nurse',
                    'Surgeon'
                  ],
                  onChanged: (value) {
                    print(value);
                  },
                ),
              ),
              SizedBox(height: 20),
              CustomTextField(
                maxLines: 5,
                fillColor: Color(0xFFE4E4E4),
                borderColor: Colors.transparent,
                hintText: "Enter any notes about the procedure",
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
                  onTap: () {},
                  iconWant: false,
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ));
  }
}
