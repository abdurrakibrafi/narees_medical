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
                    RowWiseDetailTextWidget(
                        title: 'First Name:', value: 'Anna'),
                    Divider(),
                    RowWiseDetailTextWidget(
                        title: 'Last Name:', value: 'Suraiya'),
                    Divider(),
                    RowWiseDetailTextWidget(
                        title: 'Email Address:', value: 'anna879@gmail.com'),
                    Divider(),
                    RowWiseDetailTextWidget(
                        title: 'Phone Number:', value: '(234) 555-1234'),
                    Divider(),
                    RowWiseDetailTextWidget(
                        title: 'Treatment Type:', value: 'Hydration IV Treatment'),
                    Divider(),
                    RowWiseDetailTextWidget(
                        title: 'Physical address:', value: '123/A, Florida, UK'),
                    Divider(),
                    RowWiseDetailTextWidget(
                        title: 'Location:', value: '123/A, Florida, UK'),
                    Divider(),
                    RowWiseDetailTextWidget(
                        title: 'Zip Code:', value: '1217'),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),

            // Patient ID Section
            SizedBox(height: 10.h),
            CustomText(
              text: 'Patient ID',
              fontSize: 17.h,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 10.h),

            // Patient ID Image
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTn1VL1TA_ZSbMC9SQ-gtV_fxlDEImE8HWvbVxKea6F5aZ04YjpiecrhwwvCrX8jQQyUH0&usqp=CAU',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 150.h,
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
