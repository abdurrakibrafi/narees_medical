// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';

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

            Divider(), // Divider after the header

            // ListView to display orders
            Expanded(
              child: ListView.builder(
                itemCount: 4, // Total number of orders
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

// OrderCard Widget to display individual order details
class OrderCard extends StatelessWidget {
  final String productName;
  final String company;
  final int quantity;
  final String status;

  const OrderCard({
    Key? key,
    required this.productName,
    required this.company,
    required this.quantity,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Color for the status text
    Color statusColor;
    if (status == 'Approve') {
      statusColor = Colors.green;
    } else if (status == 'Reject') {
      statusColor = Colors.red;
    } else {
      statusColor = Colors.orange; // Pending color
    }

    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 0.3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Product name and company
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: productName,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.h,
                  ),
                  SizedBox(height: 4),
                  CustomText(
                    text: company,
                    fontSize: 13.h,
                  ),
                ],
              ),
            ),
            // Quantity
            Expanded(
              child: Text('$quantity'),
            ),
            // Status with color
            Expanded(
              child: Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
