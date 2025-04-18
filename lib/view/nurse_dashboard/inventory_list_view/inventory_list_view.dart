import 'package:flutter/material.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/inventory_list_view/widget/inventory_card_widget.dart';


class InventoryList extends StatelessWidget {
  final List<Map<String, String>> inventoryItems = [
    {
      'name': 'Vitamin Boost IV Kit',
      'brand': 'SafeTouch',
      'price': '\$50.00',
      'status': 'In Stock',
      'image': 'assets/iv1.jpg'
    },
    {
      'name': 'Vitamin Boost IV Kit',
      'brand': 'SafeTouch',
      'price': '\$50.00',
      'status': 'Out of Stock',
      'image': 'assets/iv2.jpg'
    },
    {
      'name': 'Vitamin Boost IV Kit',
      'brand': 'SafeTouch',
      'price': '\$50.00',
      'status': 'In Stock',
      'image': 'assets/iv3.jpg'
    },
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Inventory List"),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                hintText: 'Search here...',
                hintStyle: TextStyle(color: Colors.black54),
                prefixIcon: Icon(Icons.search, color: Colors.blue),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 10),
            // Showing result count
            Text(
              'Showing ${inventoryItems.length} Results',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            SizedBox(height: 20),
            // List of items
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


