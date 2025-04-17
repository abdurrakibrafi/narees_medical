// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/nurse_home_view/widget/app_bar_widget_of_nurse.dart';

class HomeViewForNurse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarForHome(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Circle + Icon
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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Appointment Today",
                    fontWeight: FontWeight.bold,
                    fontSize: 16.h,
                  ),
                  CustomText(
                    text: "See All",
                  )
                ],
              ),

              SizedBox(height: 10),

              // Appointment Section
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF0071BC),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "John Date",
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text: 'Treatment Type: Hydration Therapy',
                      color: Colors.white,
                      fontSize: 16.h,
                    ),
                    SizedBox(height: 8),
                    Container(


                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF519ed1),

                      ),

                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Icon(Icons.access_time,),
                              SizedBox(width: 8),
                              CustomText(
                                text:
                                    '10:00 AM, March 6, 2025 / 2/A. Florida, USA',
                                color: Colors.black,
                                fontSize: 12.h,
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),

              // Marketing Material Section
              SizedBox(height: 24),
              Text(
                'Marketing Material',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/marketing_image.jpg',
                        height: 180, width: double.infinity, fit: BoxFit.cover),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Revitalize your body with a premium IV hydration session! 💧\n\nFeeling tired or dehydrated? Our mobile IV therapy comes to you! Book with me today for a quick energy boost. #MobileIV #VitaMedics',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                      ),
                      child: Text(
                        '2 days ago',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
