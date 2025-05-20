// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../common widget/custom_button_widget.dart';

class PaymentReceiptCard extends StatelessWidget {
  final String patientName;
  final String treatmentType;
  final String amount;
  final String date;
  final bool showBtn;
  final VoidCallback onDownloadPressed;

  const PaymentReceiptCard({
    Key? key,
    required this.patientName,
    required this.treatmentType,
    required this.amount,
    required this.date,
    required this.onDownloadPressed,
    required this.showBtn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 1.5,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  fontSize: 13.h,
                  text: 'Transaction ID: $patientName',
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),

            CustomText(
              text: 'Treatment Type: $treatmentType',
              fontSize: 13.h,
            ),

            SizedBox(height: 8),
            // Amount and Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'Amount: $amount',
                  fontSize: 13.h,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  text: 'Date: $date',
                  fontSize: 14.h,
                ),
              ],
            ),
            SizedBox(height: 16),

            // Conditionally show Download button
            if (showBtn)
              CustomButtonWidget(
                btnTextSize: 13.0,
                gradient: LinearGradient(
                  colors: [Color(0xFF0071BC), Color(0xFF003456)],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                ),
                btnText: "Download PDF Receipt",
                onTap: onDownloadPressed,
                iconWant: true,
                iconData: Icons.save_alt,
              ),
          ],
        ),
      ),
    );
  }
}
