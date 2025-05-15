// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/chached_network_image.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/cart_view/cart_view.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/notification_view/notification_view.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/controller/get_profile_controller.dart';

class CustomAppBarForHome extends StatefulWidget
    implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  CustomAppBarForHome({Key? key})
      : preferredSize = Size.fromHeight(90),
        super(key: key);

  @override
  _CustomAppBarForHomeState createState() => _CustomAppBarForHomeState();
}

class _CustomAppBarForHomeState extends State<CustomAppBarForHome> {
  late final ProfileGetController _profileGetController;

  @override
  void initState() {
    super.initState();
    _profileGetController = Get.put(ProfileGetController());
    _profileGetController.getProfile();
  }

  Widget _buildShimmerAvatar() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildShimmerText({required double width, required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        color: Colors.grey.shade300,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      backgroundColor: Colors.white,
      toolbarHeight: widget.preferredSize.height,
      title: Obx(() {
        if (_profileGetController.isLoading.value) {
          return Row(
            children: [
              _buildShimmerAvatar(),
              SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildShimmerText(width: 120.w, height: 18.h),
                  SizedBox(height: 6),
                  _buildShimmerText(width: 100.w, height: 14.h),
                ],
              ),
            ],
          );
        } else {
          final profile = _profileGetController.profile.value.data;
          final String imageUrl = profile?.profilePicture ?? "";
          final String name = profile?.firstName ?? "Hello n/a 👋";

          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: ClipOval(
                  child: CustomCachedImage(
                    imageUrl: imageUrl,
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
                    text: name,
                    fontSize: 16.h,
                    fontWeight: FontWeight.bold,
                  ),
                  Text(
                    'How are you today?',
                    style: TextStyle(
                      fontSize: 13.h,
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
            ],
          );
        }
      }),
      actions: [
        GestureDetector(
          onTap: () {
            Get.to(() => NotificationPage());
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF3E3E3E),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Padding(
              padding: EdgeInsets.all(6),
              child: Image.asset(
                "assets/images/notification.png",
                width: 25,
              ),
            ),
          ),
        ),
        SizedBox(width: 15),
        GestureDetector(
          onTap: () {
            Get.to(() => CartPage());
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF3E3E3E),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Padding(
              padding: EdgeInsets.all(6),
              child: Image.asset(
                "assets/images/Cart.png",
                width: 25,
              ),
            ),
          ),
        ),
        SizedBox(width: 15),
      ],
    );
  }
}
