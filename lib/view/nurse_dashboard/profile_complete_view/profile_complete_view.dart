// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_print, sort_child_properties_last

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_dropdown_controller.dart';
import 'package:restaurent_discount_app/common%20widget/custom_text_filed.dart';
import 'package:restaurent_discount_app/uitilies/constant.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_complete_view/second_step_profile.dart';

import '../../../common widget/custom_button_widget.dart';
import '../../paitent_dashboard_view/home_view/controller/get_state_and_city_controller.dart';
import '../../paitent_dashboard_view/paitient_profile_view/controller/update_profile_controller.dart';

class ProfileFillUpView extends StatefulWidget {
  @override
  State<ProfileFillUpView> createState() => _ProfileFillUpViewState();
}

class _ProfileFillUpViewState extends State<ProfileFillUpView> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  final UpdateProfileController _updateProfileController =
      Get.put(UpdateProfileController());

  final GetCityAndStateController _getCityAndStateController =
      Get.put(GetCityAndStateController());

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _zipController;
  late TextEditingController _locationController;
  late TextEditingController _phoneController;

  String? selectedStateId;
  String? selectedCityId;
  String? selectedStateName;
  String? selectedCityName;
  String? selectedSpecialty;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _zipController = TextEditingController();
    _locationController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _zipController.dispose();
    _locationController.dispose();
    _phoneController.dispose();
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

  List<File> selectedDocuments = [];

  Future<void> _pickMultipleDocuments() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );

      if (result != null) {
        setState(() {
          selectedDocuments = result.paths.map((path) => File(path!)).toList();
        });
      }
    } catch (e) {
      print("Error picking documents: $e");
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
              CustomText(text: "Personal Information", fontSize: 15.h),
              SizedBox(height: 10),

              // ── First & Last Name ──
              Row(
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

              // ── Email ──
              CustomTextField(
                readOnly: true,
                controller: _emailController,
                fillColor: Color(0xFFE4E4E4),
                borderColor: Colors.transparent,
                hintText: "Email Address",
                showObscure: false,
              ),
              SizedBox(height: 20),

              // ── Phone ──
              CustomTextField(
                controller: _phoneController,
                fillColor: Color(0xFFE4E4E4),
                borderColor: Colors.transparent,
                hintText: "Phone number",
                showObscure: false,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),

              // ── Location ──
              CustomTextField(
                controller: _locationController,
                fillColor: Color(0xFFE4E4E4),
                borderColor: Colors.transparent,
                hintText: "Enter Location",
                showObscure: false,
              ),
              SizedBox(height: 20),

              // ── Zip Code ──
              CustomTextField(
                controller: _zipController,
                fillColor: Color(0xFFE4E4E4),
                borderColor: Colors.transparent,
                hintText: "Enter Zip Code",
                showObscure: false,
              ),
              SizedBox(height: 20),

              // ── State Dropdown ──
              Obx(() {
                if (_getCityAndStateController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                final states =
                    _getCityAndStateController.cartData.value.data ?? [];
                final stateNames = states.map((s) => s.name ?? '').toList();

                return SizedBox(
                  width: double.infinity,
                  child: CustomDropdown(
                    label: 'State',
                    hint: 'Select a state',
                    value: selectedStateName,
                    items: stateNames,
                    onChanged: (value) {
                      setState(() {
                        selectedStateName = value;
                        selectedCityId = null;
                        selectedCityName = null;

                        final selected =
                            states.firstWhere((s) => s.name == value);
                        selectedStateId = selected.id;
                      });
                    },
                  ),
                );
              }),

              SizedBox(height: 16),

              // ── City Dropdown ──
              Obx(() {
                final states =
                    _getCityAndStateController.cartData.value.data ?? [];

                final selectedState = selectedStateId != null
                    ? states.firstWhereOrNull((s) => s.id == selectedStateId)
                    : null;

                final cities = selectedState?.cities ?? [];
                final cityNames = cities.map((c) => c.name ?? '').toList();

                return SizedBox(
                  width: double.infinity,
                  child: CustomDropdown(
                    label: 'City',
                    hint: selectedStateId == null
                        ? 'First select a state'
                        : 'Select a city',
                    value: selectedCityName,
                    items: cityNames,
                    onChanged: selectedStateId == null
                        ? null
                        : (value) {
                            setState(() {
                              selectedCityName = value;
                              final selected =
                                  cities.firstWhere((c) => c.name == value);
                              selectedCityId = selected.id;
                            });
                          },
                  ),
                );
              }),
              SizedBox(height: 20),

              // ── Specialization ──
              SizedBox(
                width: double.infinity,
                child: CustomDropdown(
                  label: 'Specialization',
                  hint: 'Select Specialization',
                  value: selectedSpecialty,
                  items: [
                    "Phlebotomist with IV Certification",
                    "Paramedic",
                    "Nurse",
                    "Nurse Practitioner",
                    "Physician"
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedSpecialty = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),

              CustomText(
                text: "Upload Documents",
                fontSize: 15.h,
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: _pickMultipleDocuments,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFE4E4E4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: CustomText(
                          text: "Choose file",
                          fontSize: 14.h,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          selectedDocuments.isEmpty
                              ? "No files selected"
                              : "${selectedDocuments.length} file(s) selected",
                          style: TextStyle(color: Colors.grey, fontSize: 14.h),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.upload_file, color: Colors.grey),
                    ],
                  ),
                ),
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
                  btnText: "Next",
                  onTap: () {
                    Get.to(() => SecondStepProfile(
                          profile: _imageFile,
                          nurseDocuments: selectedDocuments,
                          firstName: _firstNameController.text.trim(),
                          lastName: _lastNameController.text.trim(),
                          number: _phoneController.text.trim(),
                          zipcode: _zipController.text.trim(),
                          location: _locationController.text.trim(),
                          special: selectedSpecialty ?? "",
                        ));
                  },
                  iconWant: false,
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
