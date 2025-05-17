// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_print, sort_child_properties_last

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_dropdown_controller.dart';
import 'package:restaurent_discount_app/common%20widget/custom_text_filed.dart';
import 'package:restaurent_discount_app/uitilies/constant.dart';
import 'package:restaurent_discount_app/uitilies/custom_loader.dart';
import 'package:restaurent_discount_app/view/paitent_dashboard_view/paitient_profile_view/controller/update_profile_controller.dart';
import '../../../common widget/custom_button_widget.dart';

class EditProfile extends StatefulWidget {
  final String firstName;
  final String lastame;
  final String emailAddress;
  final String image;
  final String location;
  final String phoneNumber;
  final String zipCode;

  final bool? spacilizaion;
  final bool? docs;

  const EditProfile(
      {super.key,
      this.spacilizaion,
      this.docs,
      required this.firstName,
      required this.lastame,
      required this.emailAddress,
      required this.image,
      required this.location,
      required this.zipCode,
      required this.phoneNumber});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  String selectedValue = "Specialization";

  final UpdateProfileController _updateProfileController =
      Get.put(UpdateProfileController());

  // Controllers
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _locationController;
  late TextEditingController _zipCodeController;
  late TextEditingController phoneC;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.firstName);
    _lastNameController = TextEditingController(text: widget.lastame);
    _emailController = TextEditingController(text: widget.emailAddress);
    _locationController = TextEditingController(text: widget.location);
    _zipCodeController = TextEditingController(text: widget.zipCode);
    phoneC = TextEditingController(text: widget.phoneNumber);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

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
      appBar: CustomAppBar(title: "Update Profile"),
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
                              widget.image.isNotEmpty
                                  ? widget.image
                                  : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
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
                      controller: _firstNameController,
                      fillColor: Color(0xFFE4E4E4),
                      borderColor: Colors.transparent,
                      hintText: "First Name",
                      showObscure: false,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: CustomTextField(
                      controller: _lastNameController,
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
                readOnly: true,
                controller: _emailController,
                fillColor: Color(0xFFE4E4E4),
                borderColor: Colors.transparent,
                hintText: "Email Address",
                showObscure: false,
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: phoneC,
                fillColor: Color(0xFFE4E4E4),
                borderColor: Colors.transparent,
                hintText: "Phone number",
                showObscure: false,
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: _locationController,
                fillColor: Color(0xFFE4E4E4),
                borderColor: Colors.transparent,
                hintText: "Location",
                showObscure: false,
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: _zipCodeController,
                fillColor: Color(0xFFE4E4E4),
                borderColor: Colors.transparent,
                hintText: "Zip Code",
                showObscure: false,
              ),
              SizedBox(height: 20),
              if (widget.spacilizaion ?? false)
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
              if (widget.docs ?? false) ...[
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
                  ),
                ),
              ],
              SizedBox(height: 20),
              SizedBox(
                height: 55,
                width: double.infinity,
                child: Obx(() {
                  if (_updateProfileController.isLoading.value) {
                    return Center(child: CustomLoader());
                  }
                  return CustomButtonWidget(
                    gradient: LinearGradient(
                        colors: [Color(0xFF0071BC), Color(0xFF003456)],
                        begin: Alignment.topLeft,
                        end: Alignment.topRight),
                    btnText: "Update",
                    onTap: () async {
                      await _updateProfileController.updateProfile(
                        firstName: _firstNameController.text.trim(),
                        lastName: _lastNameController.text.trim(),
                        location: _locationController.text.trim(),
                        zipCode: _zipCodeController.text.trim(),
                        email: _emailController.text.trim(),
                        phoneNumber: phoneC.text,
                        profilePicture:
                            _imageFile != null ? File(_imageFile!.path) : null,
                      );
                    },
                    iconWant: false,
                  );
                }),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
