// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import '../model/cart_model.dart'; // Import the CartData model

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final Function onDismissed;
  final Function onQuantityUpdate;

  const CartItemWidget({
    Key? key,
    required this.cartItem,
    required this.onDismissed,
    required this.onQuantityUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(cartItem.id ?? ''),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        onDismissed();
      },
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red,
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              size: 30.h,
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
      ),
      child: Card(
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
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(
                        cartItem.product!.productImages[0].url.toString()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: cartItem.product?.name ?? 'Unknown Name',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    Text(
                      cartItem.product?.supplierName ?? 'Unknown Brand',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 8),
                    CustomText(
                      text:
                          'Product Price: \$${cartItem.product?.price?.toString() ?? '0.0'}',
                      fontSize: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CustomText(
                                text: "Qty: ${cartItem.quantity.toString()}",
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
