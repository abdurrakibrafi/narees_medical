// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ViewInventoryPage extends StatefulWidget {
  const ViewInventoryPage({Key? key}) : super(key: key);

  @override
  _ViewInventoryPageState createState() => _ViewInventoryPageState();
}

class _ViewInventoryPageState extends State<ViewInventoryPage> {
  int quantity = 1;
  double price = 50.00;
  int currentIndex = 0;

  final List<String> imageUrls = [
    'https://www.farmvet.com/site/images/Products/Saline-for-Irrigation-Bottle_media-1.jpg?resizeid=9&resizeh=500&resizew=500',
    'https://www.farmvet.com/site/images/Products/Calcium-Gluconate-23-Solution_media-1.jpg?resizeid=9&resizeh=500&resizew=500',
    'https://www.farmvet.com/site/images/Products/Saline-for-Irrigation-Bottle_media-1.jpg?resizeid=9&resizeh=500&resizew=500',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "View Inventory"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Recovery Hydration IV Kit',
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            CustomText(
              underline: true,
              text: 'Medical Supplies Co.',
              fontSize: 15.h,
              color: AppColors.mainColor,
            ),
            SizedBox(height: 12),

            Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  children: [
                    SizedBox(
                      height: 260,
                      child: PageView.builder(
                        itemCount: imageUrls.length,
                        onPageChanged: (index) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Image.network(
                            imageUrls[index],
                            fit: BoxFit.fitHeight,
                          );
                        },
                      ),
                    ),
                    // Page indicator
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SmoothPageIndicator(
                        controller: PageController(initialPage: 0),
                        count: imageUrls.length,
                        effect: WormEffect(
                          dotColor: Colors.grey,
                          activeDotColor: Colors.blue,
                          dotHeight: 10,
                          dotWidth: 10,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            Row(
              children: [
                Text(
                  '\$$price',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  'Qty: $quantity',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Quantity Picker
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    setState(() {
                      if (quantity > 1) quantity--;
                    });
                  },
                ),
                Text(
                  '$quantity',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            // Total Price Calculation
            Text(
              'Total: \$${(price * quantity).toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Description Section
            Text(
              'Description',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'The Recovery Hydration IV Kit is specially formulated to help you recover quickly after a long night, intense workout, or dehydration. This solution includes a powerful blend of fluids and vitamins that will rehydrate and restore your body.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            // Additional Info Section
            Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 5),
                Text(
                  'B Complex: Boosts energy and supports a healthy metabolism.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
