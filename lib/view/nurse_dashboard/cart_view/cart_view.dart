// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/cart_view/widget/cart_item_widget.dart'; // Import CartItemWidget
import 'controller/cart_get_controller.dart'; // Import CartGetController

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartGetController controller = Get.put(CartGetController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "My Cart"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: controller.cartData.value.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    var cartData = controller.cartData.value.data?[index];
                    if (cartData == null) return Container();
                    return CartItemWidget(
                      cartItem: cartData.cartItem[
                          0], // Assuming there's at least one cart item
                      onDismissed: () {
                        controller.cartData.value.data?.removeAt(index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                "${cartData.cartItem[0].product?.name} removed from cart"),
                          ),
                        );
                      },
                      onQuantityUpdate: (int change) {
                        var currentQuantity =
                            cartData.cartItem[0].quantity ?? 0;
                        var newQuantity = currentQuantity + change;
                        if (newQuantity > 0) {}
                      },
                    );
                  },
                ),
              );
            }),
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
                    Obx(() {
                      double totalPrice = controller.cartData.value.data?.fold(
                            0.0,
                            (sum, cartData) {
                              return sum! +
                                  (cartData.cartItem[0].product?.price ?? 0.0) *
                                      (cartData.cartItem[0].quantity ?? 0);
                            },
                          ) ??
                          0.0;

                      return Text(
                        '\$${totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }),
                  ],
                ),
                SizedBox(height: 10),
                CustomButtonWidget(
                  gradient: LinearGradient(
                      colors: [Color(0xFF0071BC), Color(0xFF003456)],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight),
                  btnTextSize: 16.0,
                  btnText: "Proceed to Payment",
                  onTap: () {
                    // Handle proceed to payment logic
                  },
                  iconWant: false,
                ),
                SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
