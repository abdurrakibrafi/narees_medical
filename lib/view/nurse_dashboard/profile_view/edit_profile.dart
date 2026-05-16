// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_print, sort_child_properties_last

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_dropdown_controller.dart';
import 'package:restaurent_discount_app/common%20widget/custom_text_filed.dart';
import 'package:restaurent_discount_app/uitilies/constant.dart';
import 'package:restaurent_discount_app/uitilies/custom_loader.dart';
import 'package:restaurent_discount_app/view/paitent_dashboard_view/paitient_profile_view/controller/update_profile_controller.dart';
import '../../../common widget/custom_button_widget.dart';
import '../../paitent_dashboard_view/home_view/controller/get_state_and_city_controller.dart';

class EditProfile extends StatefulWidget {
  final String firstName;
  final String lastame;
  final String emailAddress;
  final String image;
  final String location;
  final String phoneNumber;
  final bool route;
  final bool? spacilizaion;
  final bool? docs;

  final String? initialStateId;
  final String? initialStateName;
  final String? initialCityId;
  final String? initialCityName;
  final String? initialSpecialty;

  const EditProfile({
    super.key,
    this.spacilizaion,
    this.docs,
    required this.firstName,
    required this.lastame,
    required this.emailAddress,
    required this.image,
    required this.location,
    required this.phoneNumber,
    required this.route,
    this.initialStateId,
    this.initialStateName,
    this.initialCityId,
    this.initialCityName,
    this.initialSpecialty,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  List<XFile> _documentFiles = [];

  final UpdateProfileController _updateProfileController =
      Get.put(UpdateProfileController());

  final GetCityAndStateController _getCityAndStateController =
      Get.put(GetCityAndStateController());

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _locationController;
  late TextEditingController phoneC;

  String? selectedStateId;
  String? selectedCityId;
  String? selectedStateName;
  String? selectedCityName;
  String? selectedSpecialty;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.firstName);
    _lastNameController = TextEditingController(text: widget.lastame);
    _emailController = TextEditingController(text: widget.emailAddress);
    _locationController = TextEditingController(text: widget.location);
    phoneC = TextEditingController(text: widget.phoneNumber);

    selectedStateId = widget.initialStateId;
    selectedStateName = widget.initialStateName;
    selectedCityId = widget.initialCityId;
    selectedCityName = widget.initialCityName;
    selectedSpecialty = widget.initialSpecialty;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final states = _getCityAndStateController.cartData.value.data ?? [];
      if (selectedStateId != null && states.isNotEmpty) {
        final matchedState = states.firstWhereOrNull(
          (s) => s.id == selectedStateId,
        );
        if (matchedState != null) {
          setState(() {
            selectedStateName = matchedState.name;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    phoneC.dispose();
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

  Future<void> _pickDocuments() async {
    try {
      final picked = await _picker.pickMultiImage();
      if (picked.isNotEmpty) {
        setState(() {
          _documentFiles.addAll(picked);
        });
      }
    } catch (e) {
      print("Error selecting documents: $e");
    }
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),

              // ── Profile Image ──
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
                controller: phoneC,
                fillColor: Color(0xFFE4E4E4),
                borderColor: Colors.transparent,
                hintText: "Phone number",
                showObscure: false,
                keyboardType: TextInputType.phone,
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
              SizedBox(height: 10),

              // ── Specialization (optional) ──
              if (widget.spacilizaion ?? false) ...[
                SizedBox(
                  width: double.infinity,
                  child: CustomDropdown(
                    label: 'Specialization',
                    hint: 'Select Specialization',
                    value: selectedSpecialty,
                    items: [
                      'IV Therapy Specialist',
                      'General Practitioner',
                      'Nurse',
                      'Surgeon',
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedSpecialty = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
              ],

              // ── Documents (optional) ──
              if (widget.docs ?? false) ...[
                CustomText(text: "Upload Documents", fontSize: 15.h),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: _pickDocuments,
                  child: Container(
                    color: Color(0xFFE4E4E4),
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: CustomText(
                            text: "Choose file",
                            fontSize: 14.h,
                          ),
                        ),
                        SizedBox(width: 10),
                        CustomText(
                          text: "Add more images",
                          color: Colors.grey,
                          fontSize: 14.h,
                        ),
                      ],
                    ),
                  ),
                ),
                ..._documentFiles.map((file) => Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        file.name,
                        style:
                            TextStyle(fontSize: 12.sp, color: Colors.black54),
                      ),
                    )),
                SizedBox(height: 20),
              ],

              // ── Update Button ──
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
                      end: Alignment.topRight,
                    ),
                    btnText: "Update",
                    onTap: () async {
                      await _updateProfileController.updateProfile(
                        cityName: selectedCityName,
                        firstName: _firstNameController.text.trim(),
                        lastName: _lastNameController.text.trim(),
                        location: _locationController.text.trim(),
                        email: _emailController.text.trim(),
                        phoneNumber: phoneC.text.trim(),
                        profilePicture:
                            _imageFile != null ? File(_imageFile!.path) : null,
                        docs: _documentFiles
                            .map((xfile) => File(xfile.path))
                            .toList(),
                        route: widget.route,
                        stateId: selectedStateId,
                        cityId: selectedCityId,
                        specialty: selectedSpecialty,
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
