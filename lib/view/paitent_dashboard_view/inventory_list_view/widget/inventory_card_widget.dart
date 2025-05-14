// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';
import '../inventory_details_view.dart';
import '../model/inventory_product_model.dart';

class InventoryItemCard extends StatelessWidget {
  final Inventory item;

  const InventoryItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                // Image
                Container(
                  width: 100,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(
                        item.productImages.isNotEmpty
                            ? item.productImages[0].url!
                            : '',
                      ),
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
                        text: item.name ?? 'Unknown Name',
                        fontSize: 16.h,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        text: item.supplierName ?? 'Unknown Supplier',
                        fontSize: 17,
                        color: Colors.black54,
                      ),
                      SizedBox(height: 8),
                      CustomText(
                        text: item.price != null ? '\$${item.price}' : 'N/A',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 8),
                      CustomText(
                        text: item.stockStatus ?? 'Stock Unknown',
                        fontSize: 16,
                        color: item.stockStatus == 'In Stock'
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
                              btnColor: AppColors.mainColor,
                              btnTextSize: 11.5,
                              btnText: "Add to Cart",
                              onTap: () {},
                              iconWant: false,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Pass necessary data to ViewInventoryPage
                              Get.to(() => ViewInventoryPage(
                                proName: item.name ?? 'Unknown Name',
                                price: item.price ?? 0.0,
                                images: item.productImages
                                    .map((image) => image.url)
                                    .toList(),
                                desc: item.description ?? 'No Description Available',
                                supplierName: item.supplierName ?? 'Unknown Supplier', proId: item.productId.toString(),
                              ));
                            },
                            child: Icon(
                              Icons.remove_red_eye_outlined,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 1,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              decoration: BoxDecoration(
                  color: Color(0xFFE8F4FA),
                  borderRadius: BorderRadius.circular(10)),
              child: CustomText(
                text: item.quantity?.toString() ?? "0", // Display quantity
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.mainColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
