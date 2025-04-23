// Custom Bottom Sheet Widget
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';

import '../../../../common widget/custom_date_picker.dart';
import '../../../../common widget/custom_dropdown_controller.dart';
import '../../../../common widget/custom_text_filed.dart';
import '../../../../common widget/custom_time_picker.dart';

class CustomBottomSheet extends StatefulWidget {
  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  String selectedDate = "Select Date";
  String selectedTime = "Select Time";
  String selectedForm =
      "HIPAA Compliant Consent Form"; // Default value for form selection

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text: "Send Form to Patient",
            fontSize: 20.h,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),

          // Form Dropdown
          SizedBox(
            width: double.infinity,
            child: CustomDropdown(
              label: 'Form',
              hint: 'Select Form',
              value: selectedForm,
              items: [
                'HIPAA Compliant Consent Form',
                'Medical History Form',
                'Payment Agreement Form',
              ],
              onChanged: (value) {
                setState(() {
                  selectedForm = value!;
                });
              },
            ),
          ),

          SizedBox(height: 20),

          // First Name & Last Name Fields
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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

          // Email Field
          CustomTextField(
            fillColor: Color(0xFFE4E4E4),
            borderColor: Colors.transparent,
            hintText: "Enter email",
            showObscure: false,
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

          // Send Form Button and Cancel Button

          CustomButtonWidget(
              btnText: "Send Form", onTap: () {}, iconWant: false),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}
