import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';

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
              child: CustomText(
                text: status,
                color: statusColor,
                fontWeight: FontWeight.bold,
                fontSize: 13.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}