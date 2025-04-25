// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/appointment_view/widget/bottom_sheet_for_send_form.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/appointment_view/widget/view_appointment_details_widget.dart';

class ViewAppointmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Appointment Details"),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Card(
          elevation: 3.4,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // First Name & Last Name
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ViewAppointmentDetailsWidget(
                        title: 'First Name', value: 'Rafi'),
                    ViewAppointmentDetailsWidget(
                        title: 'Last Name', value: 'Rakib'),
                  ],
                ),
                SizedBox(height: 10.h),

                // Email & Phone Number
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ViewAppointmentDetailsWidget(
                        title: 'Email Address', value: 'Bill1234@gmail.com'),
                    ViewAppointmentDetailsWidget(
                        title: 'Phone Number', value: '+880123456789'),
                  ],
                ),
                SizedBox(height: 10.h),

                // Treatment Type & Date of Birth
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ViewAppointmentDetailsWidget(
                        title: 'Treatment Type', value: 'HYDRATION IV'),
                    ViewAppointmentDetailsWidget(
                        title: 'Date of Birth', value: '04-12-2001'),
                  ],
                ),
                SizedBox(height: 10.h),

                // Selected Date & Selected Time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ViewAppointmentDetailsWidget(
                        title: 'Selected Date', value: 'March 07, 2025'),
                    ViewAppointmentDetailsWidget(
                        title: 'Selected Time', value: '3:00 PM'),
                  ],
                ),
                SizedBox(height: 10.h),

                // Location & Zip Code
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ViewAppointmentDetailsWidget(
                        title: 'Location', value: '2/A, Florida, USA'),
                    ViewAppointmentDetailsWidget(
                        title: 'Zip Code', value: '342568'),
                  ],
                ),
                SizedBox(height: 10.h),

                // GFE Status
                Padding(
                  padding: EdgeInsets.only(bottom: 16.0.h),
                  child: ViewAppointmentDetailsWidget(
                      title: 'GFE Status', value: 'Pending'),
                ),

                Spacer(),

                Align(
                  alignment: Alignment.center,
                  child: CustomButtonWidget(
                    gradient: LinearGradient(
                        colors: [Color(0xFF0071BC), Color(0xFF003456)],
                        begin: Alignment.topLeft,
                        end: Alignment.topRight),


                    btnText: "Send Form to Patient",
                    onTap: () {
                      // Open the custom bottom sheet when clicked
                      showModalBottomSheet(

                        backgroundColor: Colors.white,
                        context: context,
                        builder: (context) {
                          return CustomBottomSheet();
                        },
                      );
                    },
                    iconWant: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
