// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/patient_charting_view/widget/additional_information_widget.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/patient_charting_view/widget/encounter_data_widget.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/patient_charting_view/widget/nurse_side_medical_history.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/patient_charting_view/widget/payment_side_from_nurse_widget.dart';
import 'package:restaurent_discount_app/view/paitent_dashboard_view/paitient_profile_view/widget/patient_information.dart';
import 'package:restaurent_discount_app/view/paitent_dashboard_view/paitient_profile_view/widget/payment_tab_widget.dart';

class HippaFormView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Number of tabs
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: CustomText(
            text: 'HIPAA Form',
            fontSize: 16.h,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_circle_left_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              color: AppColors.mainColor,
              child: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.white,
                labelColor: Colors.white,
                indicatorColor: Colors.white,
                labelStyle: GoogleFonts.abhayaLibre(fontSize: 15.h),
                tabs: [
                  Tab(
                    text: 'Patient Information',
                  ),
                  Tab(text: 'Encounter'),
                  Tab(text: 'Medical History'),
                  Tab(text: 'Additional Information'),
                  Tab(text: 'Payment'),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            PatientInformationView(),
            EncounterDataWidget(),
            NurseSideMedicalHistory(),
            Additional_information_widget(),
            PaymentSideFromNurseWidget(),
          ],
        ),
      ),
    );
  }
}
