// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../common widget/custom_button_widget.dart';
import '../../../../common widget/custom_dropdown_controller.dart';
import '../../../../common widget/custom_text_filed.dart';
import '../../../../uitilies/constant.dart';

class Additional_information_widget extends StatelessWidget {
  const Additional_information_widget({super.key});

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
                text: "Attach Notes, Images, or Documents",
                fontSize: 18.h,
              ),
              SizedBox(height: 10),
              CustomTextField(
                maxLines: 5,
                fillColor: Color(0xFFE4E4E4),
                borderColor: Colors.transparent,
                hintText:
                    "Enter any additional notes about the patient or treatment",
                showObscure: false,
              ),

              SizedBox(height: 20),
              CustomText(
                text: "Upload Documents",
                fontSize: 15.h,
              ),
              SizedBox(height: 10),
              Container(
                  color: Color(0xFFE4E4E4),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(3),
                        child: CustomText(
                          text: "Choose file",
                          fontSize: 14.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey),
                        ),
                      ),
                      SizedBox(width: 10),
                      CustomText(
                        text: "attach your file here",
                        color: Colors.grey,
                        fontSize: 14.h,
                      )
                    ],
                  )),

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
