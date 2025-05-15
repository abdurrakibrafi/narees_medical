// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';
import 'package:restaurent_discount_app/uitilies/constant.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/nurse_home_view/widget/app_bar_widget_of_nurse.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/nurse_home_view/widget/marketing_material_widget.dart';
import '../../../common widget/row_wise_widget.dart';

class HomeViewForNurse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarForHome(),
      body: SingleChildScrollView(
        padding: AppPadding.bodyPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RowWiseWidget(
              title: 'Appointment Today',
              subTitle: 'See All',
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
                          Icon(
                            Icons.access_time,
                          ),
                          SizedBox(width: 8),
                          CustomText(
                            text: '10:00 AM, March 6, 2025 / 2/A. Florida, USA',
                            color: Colors.black,
                            fontSize: 12.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Marketing Material Section
            SizedBox(height: 24),
            RowWiseWidget(
              title: 'Marketing Material',
              subTitle: 'See All',
            ),
            SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (BuildContext context, index) {
                return MarketingMaterialCard();
              },
            ),
          ],
        ),
      ),
    );
  }
}
