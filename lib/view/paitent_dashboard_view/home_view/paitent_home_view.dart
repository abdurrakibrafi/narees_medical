// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_date_picker.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';
import 'package:restaurent_discount_app/uitilies/constant.dart';
import 'package:restaurent_discount_app/uitilies/custom_loader.dart';
import 'package:restaurent_discount_app/uitilies/custom_toast.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/nurse_home_view/widget/app_bar_widget_of_nurse.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_dropdown_controller.dart'
    show CustomDropdown;
import '../../../common widget/custom_text_filed.dart';
import '../../../common widget/custom_time_picker.dart';
import 'controller/patient_appointment_make_controller.dart';

class HomeViewForPaitinet extends StatefulWidget {
  @override
  State<HomeViewForPaitinet> createState() => _HomeViewForPaitinetState();
}

class _HomeViewForPaitinetState extends State<HomeViewForPaitinet> {
  String selectedTreatment = 'IV Hydration';
  String selectedDate = "Select Date";
  String selectedTime = "Select Time";
  bool reminder = false;

  // Controllers for text fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  final AppointmentMakeController _appointmentMakeController =
      Get.put(AppointmentMakeController());

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    locationController.dispose();
    zipCodeController.dispose();
    phoneController.dispose();
    reasonController.dispose();
    super.dispose();
  }

  void _submit() {
    if (selectedDate == "Select Date" || selectedTime == "Select Time") {
      CustomToast.showToast(' Please Select date and time', isError: true);
      return;
    }

    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        locationController.text.isEmpty ||
        zipCodeController.text.isEmpty ||
        phoneController.text.isEmpty ||
        reasonController.text.isEmpty) {
      CustomToast.showToast('Please fill all fields', isError: true);
      return;
    }

    final String dateTime = '$selectedDate $selectedTime';

    _appointmentMakeController.addProductToCart(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      treatmentType: selectedTreatment,
      phoneNumber: phoneController.text.trim(),
      reason: reasonController.text.trim(),
      date: dateTime,
      location: locationController.text.trim(),
      reminder: reminder,
      zipCode: zipCodeController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarForHome(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Card(
              color: Colors.white,
              elevation: 2,
              child: Padding(
                padding: AppPadding.bodyPadding,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    CustomText(
                      text: "Add Your Appointment",
                      fontSize: 15.h,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: firstNameController,
                            fillColor: Color(0xFFE4E4E4),
                            borderColor: Colors.transparent,
                            hintText: "First Name",
                            showObscure: false,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: CustomTextField(
                            controller: lastNameController,
                            fillColor: Color(0xFFE4E4E4),
                            borderColor: Colors.transparent,
                            hintText: "Last Name",
                            showObscure: false,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: CustomDropdown(
                        label: 'Treatment Type',
                        hint: 'Select Specialization',
                        value: selectedTreatment,
                        items: [
                          'IV Hydration',
                          'Vitamin B12 Infusion',
                          'Pain Management',
                          'Surgeon'
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedTreatment = value!;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomDatePicker(
                          onDateSelected: (date) {
                            setState(() {
                              selectedDate = date;
                            });
                          },
                          color: Color(0xFFE4E4E4),
                        ),
                        CustomTimePicker(
                          onTimeSelected: (time) {
                            setState(() {
                              selectedTime = time;
                            });
                          },
                          color: Color(0xFFE4E4E4),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      controller: locationController,
                      fillColor: Color(0xFFE4E4E4),
                      borderColor: Colors.transparent,
                      hintText: "Enter Location",
                      showObscure: false,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: zipCodeController,
                            fillColor: Color(0xFFE4E4E4),
                            borderColor: Colors.transparent,
                            hintText: "Zip Code",
                            showObscure: false,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: CustomTextField(
                            controller: phoneController,
                            fillColor: Color(0xFFE4E4E4),
                            borderColor: Colors.transparent,
                            hintText: "Phone Number",
                            showObscure: false,
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      controller: reasonController,
                      maxLines: 4,
                      fillColor: Color(0xFFE4E4E4),
                      borderColor: Colors.transparent,
                      hintText: "Reason for appointment",
                      showObscure: false,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: AppColors.mainColor,
                          value: reminder,
                          onChanged: (value) {
                            setState(() {
                              reminder = value ?? false;
                            });
                          },
                        ),
                        SizedBox(width: 8),
                        CustomText(
                          text: "Set Reminder",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Obx(() {
                      if (_appointmentMakeController.isLoading.value) {
                        return Center(child: CustomLoader());
                      }
                      return CustomButtonWidget(
                        gradient: LinearGradient(
                          colors: [Color(0xFF0071BC), Color(0xFF003456)],
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                        ),
                        btnText: "Submit",
                        onTap: _submit,
                        iconWant: false,
                      );
                    }),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
