// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';
import 'package:restaurent_discount_app/uitilies/custom_loader.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/cart_view/cart_view.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/cart_view/controller/add_to_cart_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ViewInventoryPage extends StatefulWidget {
  final String proName;
  final String proId;
  final dynamic price;
  final List<dynamic> images;
  final String desc;
  final String supplierName;

  const ViewInventoryPage(
      {Key? key,
      required this.proName,
      this.price,
      required this.images,
      required this.desc,
      required this.supplierName,
      required this.proId})
      : super(key: key);

  @override
  _ViewInventoryPageState createState() => _ViewInventoryPageState();
}

class _ViewInventoryPageState extends State<ViewInventoryPage> {
  int quantity = 1;
  late double price;
  int currentIndex = 0;

  final AddToCartController _addToCartController =
      Get.put(AddToCartController());

  @override
  void initState() {
    super.initState();
    price = widget.price ?? 50.00;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "View Inventory"),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: widget.proName,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  underline: true,
                  text: widget.supplierName, // Use passed supplier name
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
                            itemCount:
                                widget.images.length, // Use passed images list
                            onPageChanged: (index) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              return Image.network(
                                widget.images[index], // Display passed image
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
                            count:
                                widget.images.length, // Use passed image count
                            effect: WormEffect(
                              dotColor: Colors.grey,
                              activeDotColor: AppColors.mainColor,
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
                    CustomText(
                        text: '\$$price',
                        fontSize: 24.h,
                        fontWeight: FontWeight.bold),
                  ],
                ),
                SizedBox(height: 5),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Qty: ",
                          fontSize: 18.h,
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            setState(() {
                              if (quantity > 1) quantity--;
                            });
                          },
                        ),
                        CustomText(
                          text: '$quantity',
                          fontSize: 17.h,
                          fontWeight: FontWeight.bold,
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
                    CustomText(
                      text: 'Total: \$${(price * quantity).toStringAsFixed(2)}',
                      fontSize: 16.h,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                Divider(),
                CustomText(
                  text: 'Description',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 5),
                CustomText(
                  textAlign: TextAlign.start,
                  text: widget.desc,
                  fontSize: 16,
                ),
                SizedBox(height: 40),
                Obx(() {
                  return _addToCartController.isLoading.value == true
                      ? CustomLoader()
                      : CustomButtonWidget(
                          gradient: LinearGradient(
                              colors: [Color(0xFF0071BC), Color(0xFF003456)],
                              begin: Alignment.topLeft,
                              end: Alignment.topRight),
                          btnText: "Add to Cart",
                          onTap: () {
                            _addToCartController.addProductToCart(
                                productId: widget.proId, quantity: quantity);
                          },
                          iconWant: false);
                }),
                SizedBox(height: 40),
              ],
            ),
          )),
    );
  }
}
