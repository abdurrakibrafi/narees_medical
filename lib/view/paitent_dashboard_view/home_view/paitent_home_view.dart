// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_date_picker.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';
import 'package:restaurent_discount_app/uitilies/constant.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/nurse_home_view/widget/app_bar_widget_of_nurse.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/nurse_home_view/widget/marketing_material_widget.dart';
import '../../../common widget/custom_dropdown_controller.dart'
    show CustomDropdown;
import '../../../common widget/custom_text_filed.dart';
import '../../../common widget/custom_time_picker.dart';
import '../../../common widget/row_wise_widget.dart';

class HomeViewForPaitinet extends StatefulWidget {
  @override
  State<HomeViewForPaitinet> createState() => _HomeViewForPaitinetState();
}

class _HomeViewForPaitinetState extends State<HomeViewForPaitinet> {
  String selectedTreatment = 'IV Hydration';
  String selectedDate = "Select Date";
  String selectedTime = "Select Time";

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
            // The 'Order Supplies' Card
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0.2),
                    Colors.white,
                    Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue.withOpacity(0.2),
                          ),
                          child: Icon(
                            Icons.add,
                            color: AppColors.mainColor,
                            size: 18,
                          ),
                        ),
                        SizedBox(width: 12),
                        CustomText(
                          text: 'ORDER SUPPLIES',
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
                            fillColor: Color(0xFFE4E4E4),
                            borderColor: Colors.transparent,
                            hintText: "Zip Code",
                            showObscure: false,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: CustomTextField(
                            fillColor: Color(0xFFE4E4E4),
                            borderColor: Colors.transparent,
                            hintText: "Phone Number",
                            showObscure: false,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      maxLines: 4,
                      fillColor: Color(0xFFE4E4E4),
                      borderColor: Colors.transparent,
                      hintText: "Reason for appointment",
                      showObscure: false,
                    ),
                    SizedBox(height: 30),
                    CustomButtonWidget(
                        btnText: "Submit", onTap: () {}, iconWant: false),
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
