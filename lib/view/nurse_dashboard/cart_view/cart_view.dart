// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItem> cartItems = [
    CartItem(
      imageUrl: 'https://via.placeholder.com/150',
      name: 'Vitamin Boost IV Kit',
      brand: 'SafeTouch',
      price: 50.00,
      status: 'In Stock',
      quantity: 1,
    ),
    CartItem(
      imageUrl: 'https://via.placeholder.com/150',
      name: 'Vitamin Boost IV Kit',
      brand: 'SafeTouch',
      price: 50.00,
      status: 'Out of Stock',
      quantity: 1,
    ),
    CartItem(
      imageUrl: 'https://via.placeholder.com/150',
      name: 'Vitamin Boost IV Kit',
      brand: 'SafeTouch',
      price: 50.00,
      status: 'In Stock',
      quantity: 1,
    ),
  ];

  double get totalPrice {
    double total = 0.0;
    for (var item in cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  void increaseQuantity(int index) {
    setState(() {
      cartItems[index].quantity++;
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "My Cart"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.white,
                    elevation: 2,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          // Product Image
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(cartItems[index].imageUrl),
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
                                Text(
                                  cartItems[index].name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  cartItems[index].brand,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '\$${cartItems[index].price.toString()}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                // Quantity and remove button
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.remove),
                                          onPressed: cartItems[index].status ==
                                                  'In Stock'
                                              ? () => decreaseQuantity(index)
                                              : null,
                                        ),
                                        Text(
                                          cartItems[index].quantity.toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: cartItems[index].status ==
                                                  'In Stock'
                                              ? () => increaseQuantity(index)
                                              : null,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(),
            SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Total",
                      fontSize: 18.h,
                      fontWeight: FontWeight.bold,
                    ),
                    Text(
                      '\$${totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                CustomButtonWidget(
                  btnTextSize: 16.0,
                    btnText: "Proceed to Payment",
                    onTap: () {},
                    iconWant: false),
                SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CartItem {
  final String imageUrl;
  final String name;
  final String brand;
  final double price;
  final String status;
  int quantity;

  CartItem({
    required this.imageUrl,
    required this.name,
    required this.brand,
    required this.price,
    required this.status,
    this.quantity = 1,
  });
}
