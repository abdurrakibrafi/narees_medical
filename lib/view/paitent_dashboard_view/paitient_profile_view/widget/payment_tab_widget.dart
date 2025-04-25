// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/view/paitent_dashboard_view/paitient_profile_view/widget/row_wise_detail_text_widget.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../nurse_dashboard/profile_view/widget/certification_card_widget.dart';

class PaymentTabWidget extends StatelessWidget {
  const PaymentTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: EdgeInsets.all(15),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.withOpacity(0.5), width: 2),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Payment Information Section
              RowWiseDetailTextWidget(title: 'Payment Information:', value: ''),

              CertificateCard(
                  certificateName: "Payment Receipt", fileSize: "456"),

              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
