// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_print, sort_child_properties_last

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_text_filed.dart';
import 'package:restaurent_discount_app/uitilies/constant.dart';
import 'package:restaurent_discount_app/view/profile_complete_view/second_step_profile.dart';

import '../../../common widget/custom_button_widget.dart';

class AddPatientChartView extends StatefulWidget {
  @override
  State<AddPatientChartView> createState() => _AddPatientChartViewState();
}

class _AddPatientChartViewState extends State<AddPatientChartView> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  String selectedValue = "Specialization";

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _imageFile = pickedFile;
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Pick from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a Photo'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Add Patient Chart"),
      backgroundColor: Colors.white,
      body: Container(
          padding: AppPadding.bodyPadding,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Patient Information",
                  fontSize: 15.h,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  fillColor: Color(0xFFE4E4E4),
                  borderColor: Colors.transparent,
                  hintText: "Patient Name",
                  showObscure: false,
                ),
                SizedBox(height: 10),
                CustomText(
                  text: "Treatment Type",
                  fontSize: 15.h,
                ),
                SizedBox(height: 10),
                CustomTextField(
                  fillColor: Color(0xFFE4E4E4),
                  borderColor: Colors.transparent,
                  hintText: "Treatment Type",
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
                SizedBox(height: 20),
                CustomText(
                  text: "Upload GOOD FAITH EXAM results",
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
                    onTap: () {
                      Get.to(() => SecondStepProfile());
                    },
                    iconWant: false,
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          )),
    );
  }
}
