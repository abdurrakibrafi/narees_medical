// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';

class InventoryItemCard extends StatelessWidget {
  final Map<String, String> item;

  const InventoryItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            // Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(
                      item['image']!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16),
            // Item details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: item['name']!,
                    fontSize: 16.h,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                      text: item['brand']!,
                      fontSize: 17,
                      color: Colors.black54),
                  SizedBox(height: 8),
                  CustomText(
                      text: item['price']!,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  SizedBox(height: 8),
                  CustomText(
                    text: item['status']!,
                    fontSize: 16,
                    color: item['status'] == 'In Stock'
                        ? Colors.green
                        : Colors.red,
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 34,
                        width: 100,
                        child: CustomButtonWidget(
                            btnTextSize: 11.5,
                            btnText: "Add to Cart",
                            onTap: () {},
                            iconWant: false),
                      ),
                      
                      
                      Icon(Icons.remove_red_eye_outlined,color: Colors.grey,)
                      
                    ],
                  )
                ],
              ),
            ),
            // Add to cart button
          ],
        ),
      ),
    );
  }
}
