// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
import 'package:restaurent_discount_app/uitilies/custom_loader.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/cart_view/widget/cart_item_widget.dart'; // Import CartItemWidget
import '../../../common widget/not_found_widget.dart';
import 'controller/cart_get_controller.dart';
import 'controller/delete_cart_controller.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartGetController controller = Get.put(CartGetController());
    final DeleteCartController deleteController =
        Get.put(DeleteCartController());

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
                return Center(child: CustomLoader());
              }

              if (controller.cartData.value.data?.isEmpty ?? true) {
                return Column(
                  children: [
                    SizedBox(height: 150.h),
                    NotFoundWidget(
                      message: "Opps! No item found in your cart.",
                    )
                  ],
                );
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: controller.cartData.value.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    var cartData = controller.cartData.value.data?[index];

                    if (cartData == null || cartData.cartItem.isEmpty) {
                      return Center(
                          child: NotFoundWidget(
                        message: 'Opps! No item available.',
                      ));
                    }

                    var cartItem = cartData.cartItem[0];

                    return CartItemWidget(
                      cartItem: cartItem,
                      onDismissed: () async {
                        await deleteController.deleteCart(
                            cartId: controller
                                .cartData.value.data![index].cartItem[index].id
                                .toString());
                        controller.getCart();
                      },
                      onQuantityUpdate: (int change) {
                        var currentQuantity = cartItem.quantity ?? 0;
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
                                  (cartData.cartItem.isNotEmpty
                                          ? cartData
                                                  .cartItem[0].product?.price ??
                                              0.0
                                          : 0.0) *
                                      (cartData.cartItem.isNotEmpty
                                          ? cartData.cartItem[0].quantity ?? 0
                                          : 0);
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
