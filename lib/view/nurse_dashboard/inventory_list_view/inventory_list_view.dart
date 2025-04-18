// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/inventory_list_view/widget/inventory_card_widget.dart';

class InventoryList extends StatelessWidget {
  final List<Map<String, String>> inventoryItems = [
    {
      'name': 'Vitamin Boost IV Kit',
      'brand': 'SafeTouch',
      'price': '\$50.00',
      'status': 'In Stock',
      'image':
          'https://www.farmvet.com/site/images/Products/Saline-for-Irrigation-Bottle_media-1.jpg?resizeid=9&resizeh=500&resizew=500'
    },
    {
      'name': 'Vitamin Boost IV Kit',
      'brand': 'SafeTouch',
      'price': '\$50.00',
      'status': 'Out of Stock',
      'image':
          'https://www.farmvet.com/site/images/Products/Saline-for-Irrigation-Bottle_media-1.jpg?resizeid=9&resizeh=500&resizew=500'
    },
    {
      'name': 'Vitamin Boost IV Kit',
      'brand': 'SafeTouch',
      'price': '\$50.00',
      'status': 'In Stock',
      'image':
          'https://www.farmvet.com/site/images/Products/Calcium-Gluconate-23-Solution_media-1.jpg?resizeid=9&resizeh=500&resizew=500'
    },
    {
      'name': 'Vitamin Boost IV Kit',
      'brand': 'SafeTouch',
      'price': '\$50.00',
      'status': 'In Stock',
      'image':
      'https://www.farmvet.com/site/images/Products/Saline-for-Irrigation-Bottle_media-1.jpg?resizeid=9&resizeh=500&resizew=500'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Inventory List"),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search here....',
                hintStyle: GoogleFonts.abhayaLibre(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: AppColors.mainColor),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
                suffixIcon: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.mainColor),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: inventoryItems.length,
                itemBuilder: (context, index) {
                  var item = inventoryItems[index];
                  return InventoryItemCard(item: item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
