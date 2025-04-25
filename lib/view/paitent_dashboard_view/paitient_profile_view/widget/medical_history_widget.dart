// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/view/paitent_dashboard_view/paitient_profile_view/widget/row_wise_detail_text_widget.dart';
import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../nurse_dashboard/profile_view/widget/certification_card_widget.dart';

class MedicalHistoryWidget extends StatelessWidget {
  const MedicalHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            // Patient Details Section
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Encounter",
                      fontWeight: FontWeight.bold,
                      fontSize: 17.h,
                    ),
                    RowWiseDetailTextWidget(
                        title: 'Blood Pressure:', value: '120/80 mm Hg '),
                    Divider(),
                    RowWiseDetailTextWidget(title: 'Heart Rate:', value: '75'),
                    Divider(),
                    RowWiseDetailTextWidget(
                        title: 'Temperature (°F):', value: '100.2'),
                    Divider(),
                    RowWiseDetailTextWidget(
                        title: 'Oxygen Level (%):', value: '98%'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Medical History",
                      fontWeight: FontWeight.bold,
                      fontSize: 17.h,
                    ),
                    RowWiseDetailTextWidget(title: 'Log Procedures', value: ''),
                    Divider(),
                    RowWiseDetailTextWidget(
                        title: 'Procedure Performed:',
                        value: 'IV Hydration Therapy'),
                    Divider(),
                    RowWiseDetailTextWidget(
                        title: 'Medications Administered:',
                        value: 'Vitamin B12 - 20.00'),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            text: "Procedure Performed:",
                            fontSize: 14.h,
                            fontWeight: FontWeight.w500),
                        SizedBox(
                          width: 145,
                          child: CustomText(
                              textAlign: TextAlign.start,
                              text:
                                  "Patient tolerated the IV hydration therapy well with no immediate complications. No signs of allergic reactions or discomfort during infusion. The site was clean, and dressing was applied post-procedure. Patient advised to hydrate throughout the day.",
                              fontSize: 13.h,
                              color: Colors.grey),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Additional Image, or Documents",
                      fontWeight: FontWeight.bold,
                      fontSize: 17.h,
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            text: "Additional Notes:",
                            fontSize: 14.h,
                            fontWeight: FontWeight.w500),
                        SizedBox(
                          width: 145,
                          child: CustomText(
                              textAlign: TextAlign.start,
                              text:
                                  "Patient tolerated the IV hydration therapy well with no immediate complications. No signs of allergic reactions or discomfort during infusion. The site was clean, and dressing was applied post-procedure. Patient advised to hydrate throughout the day.",
                              fontSize: 13.h,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                    Divider(),
                    CertificateCard(
                      certificateName: 'File of medical',
                      fileSize: '456',
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
