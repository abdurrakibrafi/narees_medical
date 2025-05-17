// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/widget/order_card_widget.dart';

class SupplyOrderHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Supply Order History"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
                height: 40.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFF0071BC), Color(0xFF003456)],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Products',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 15.h,
                      ),
                      CustomText(
                        text: 'Quantity',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 15.h,
                      ),
                      CustomText(
                        text: 'Status',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 15.h,
                      ),
                    ],
                  ),
                )),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return OrderCard(
                    productName: 'IV Fluid Bag (1L Saline)',
                    company: 'Medical Supplies Co.',
                    quantity: 12,
                    status: index == 0
                        ? 'Approve'
                        : index == 1
                            ? 'Reject'
                            : 'Pending',
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
