// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/cart_view/cart_view.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/inventory_list_view/inventory_list_view.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/notification_view/notification_view.dart';

class CustomAppBarForHome extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  CustomAppBarForHome({Key? key})
      : preferredSize = Size.fromHeight(90),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      backgroundColor: Colors.white,
      toolbarHeight: preferredSize.height,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              shape: BoxShape.circle,
              color: Colors.white, // Border color
            ),
            child: ClipOval(
              child: Image.network(
                "https://media.istockphoto.com/id/1329569957/photo/happy-young-female-doctor-looking-at-camera.jpg?s=612x612&w=0&k=20&c=7Wq_Y2cl0T4op6Wg_3DFc-xtZfCqTTDvfaXkPGyrHDM=",
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Hello Samantha 👋',

                fontSize: 16.h, // Adjust size as needed
                fontWeight: FontWeight.bold,
              ),
              Text(
                'How are you today?',
                style: TextStyle(
                  fontSize: 13.h, // Adjust size as needed
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Get.to(() => NotificationPage());
          },
          child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFF3E3E3E),
                  borderRadius: BorderRadius.circular(100)),
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Image(
                  image: AssetImage("assets/images/notification.png"),
                  width: 25,
                ),
              )),
        ),
        SizedBox(width: 15),
        GestureDetector(
          onTap: () {
            Get.to(() => CartPage());
          },
          child: Container(
              decoration: BoxDecoration(
                  color: Color(0xFF3E3E3E),
                  borderRadius: BorderRadius.circular(100)),
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Image(
                  image: AssetImage("assets/images/Cart.png"),
                  width: 25,
                ),
              )),
        ),
        SizedBox(width: 15),
      ],
    );
  }
}
