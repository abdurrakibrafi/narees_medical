// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';

class PaymentReceiptsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Payment Receipts"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 350,
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color:
                          AppColors.mainColor.withOpacity(0.3), // Border color
                      width: 2.0, // Border width
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          text: 'This Month',
                          fontSize: 15.h,
                          fontWeight: FontWeight.w500),
                      IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () {
                          print("Date Picker clicked");
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            // List of payment receipts
            Expanded(
              child: ListView.builder(
                itemCount: 2, // Set the number of receipts here
                itemBuilder: (context, index) {
                  return PaymentReceiptCard(
                    patientName: 'John Dev',
                    treatmentType: 'IV Therapy Session',
                    amount: '\$200.00',
                    date: '24 Feb, 2025',
                    onDownloadPressed: () {
                      // Implement the download functionality
                      print("Download PDF clicked");
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Payment Receipt Card Widget
class PaymentReceiptCard extends StatelessWidget {
  final String patientName;
  final String treatmentType;
  final String amount;
  final String date;
  final VoidCallback onDownloadPressed;

  const PaymentReceiptCard({
    Key? key,
    required this.patientName,
    required this.treatmentType,
    required this.amount,
    required this.date,
    required this.onDownloadPressed,
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
                  fontSize: 15.h,
                  text: 'Patient Name: $patientName',
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),

            CustomText(
              text: 'Treatment Type: $treatmentType',
              fontSize: 15.h,
            ),

            SizedBox(height: 8),
            // Amount and Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'Amount: $amount',
                  fontSize: 14.h,
                ),
                CustomText(
                  text: 'Date: $date',
                  fontSize: 14.h,
                ),
              ],
            ),
            SizedBox(height: 16),
            // Download PDF Button

            CustomButtonWidget(

              gradient: LinearGradient(
                  colors: [Color(0xFF0071BC), Color(0xFF003456)],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight),

              btnText: "Download PDF Receipt",
              onTap: () {},
              iconWant: true,
              iconData: Icons.save_alt,
            )
          ],
        ),
      ),
    );
  }
}
