import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';
import 'package:restaurent_discount_app/uitilies/constant.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/patient_charting_view/widget/patient_charting_card_view.dart';

import 'add_patient_chart_view.dart';

class PatientChartingView extends StatelessWidget {
  const PatientChartingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(leading: Container(), title: "Patient Charting"),
        body: Padding(
          padding: AppPadding.bodyPadding,
          child: Column(
            children: [
              SizedBox(height: 20),
              CustomButtonWidget(
                btnColor: Color(0xFFE8F4FA),
                btnTextSize: 13.h,
                btnTextColor: AppColors.mainColor,
                btnText: "Add Patient Chart",
                onTap: () {
                  Get.to(() => AddPatientChartView());
                },
                iconWant: true,
                suffixIconColor: AppColors.mainColor.withOpacity(0.4),
                iconData: Icons.add,
              ),
              SizedBox(height: 20),
              Expanded(child:
                  ListView.builder(itemBuilder: (BuildContext context, index) {
                return PatientChartingCard();
              }))
            ],
          ),
        ));
  }
}
