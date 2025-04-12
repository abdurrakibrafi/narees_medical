// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_print, sort_child_properties_last

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_dropdown_controller.dart';
import 'package:restaurent_discount_app/common%20widget/custom_text_filed.dart';
import 'package:restaurent_discount_app/uitilies/constant.dart';

class ProfileFillUpView extends StatefulWidget {
  @override
  State<ProfileFillUpView> createState() => _ProfileFillUpViewState();
}

class _ProfileFillUpViewState extends State<ProfileFillUpView> {
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
      appBar: CustomAppBar(title: "Profile Complete"),
      backgroundColor: Colors.white,
      body: Container(
          padding: AppPadding.bodyPadding,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Center(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: _imageFile != null
                            ? Image.file(
                                File(_imageFile!.path),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => _showImagePickerOptions(context),
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.blue,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                CustomText(
                  text: "Personal Information",
                  fontSize: 15.h,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomTextField(
                        fillColor: Color(0xFFE4E4E4),
                        borderColor: Colors.transparent,
                        hintText: "First Name",
                        showObscure: false,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: CustomTextField(
                        fillColor: Color(0xFFE4E4E4),
                        borderColor: Colors.transparent,
                        hintText: "Last Name",
                        showObscure: false,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                CustomTextField(
                  fillColor: Color(0xFFE4E4E4),
                  borderColor: Colors.transparent,
                  hintText: "Email Address",
                  showObscure: false,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  fillColor: Color(0xFFE4E4E4),
                  borderColor: Colors.transparent,
                  hintText: "Phone number",
                  showObscure: false,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  fillColor: Color(0xFFE4E4E4),
                  borderColor: Colors.transparent,
                  hintText: "Registration Id",
                  showObscure: false,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  fillColor: Color(0xFFE4E4E4),
                  borderColor: Colors.transparent,
                  hintText: "Joined Date",
                  showObscure: false,
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: CustomDropdown(
                    label: 'Specialization',
                    hint: 'Select Specialization',
                    value: 'IV Therapy Specialist',
                    items: [
                      'IV Therapy Specialist',
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
                          text: "Add more image",
                          color: Colors.grey,
                          fontSize: 14.h,
                        )
                      ],
                    )),
                SizedBox(height: 30),

              ],
            ),
          )),
    );
  }
}
