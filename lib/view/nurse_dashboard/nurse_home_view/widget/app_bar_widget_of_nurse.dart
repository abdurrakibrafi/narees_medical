// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';
import 'package:shimmer/shimmer.dart';

import 'package:restaurent_discount_app/common%20widget/chached_network_image.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/cart_view/cart_view.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/notification_view/notification_view.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/controller/get_profile_controller.dart';

class CustomAppBarForHome extends StatefulWidget
    implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  CustomAppBarForHome({Key? key})
      : preferredSize = Size.fromHeight(82),
        super(key: key);

  @override
  State<CustomAppBarForHome> createState() =>
      _CustomAppBarForHomeState();
}

class _CustomAppBarForHomeState extends State<CustomAppBarForHome> {
  late final ProfileGetController _profileGetController;

  @override
  void initState() {
    super.initState();

    _profileGetController = Get.put(ProfileGetController());
    _profileGetController.getProfile();
  }

  // ============================================================
  // DEVICE TIME BASED GREETING
  // ============================================================

  String getGreeting() {
    final int hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return "Good Morning";
    } else if (hour >= 12 && hour < 17) {
      return "Good Afternoon";
    } else if (hour >= 17 && hour < 21) {
      return "Good Evening";
    } else {
      return "Good Night";
    }
  }

  // ============================================================
  // GREETING ICON
  // ============================================================

  String getGreetingEmoji() {
    final int hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return "";
    } else if (hour >= 12 && hour < 17) {
      return "";
    } else if (hour >= 17 && hour < 21) {
      return "";
    } else {
      return "";
    }
  }

  // ============================================================
  // SHIMMER AVATAR
  // ============================================================

  Widget _buildShimmerAvatar() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: 50.w,
        height: 50.w,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  // ============================================================
  // SHIMMER TEXT
  // ============================================================

  Widget _buildShimmerText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: 90.w,
            height: 11.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(5.r),
            ),
          ),
        ),

        SizedBox(height: 7.h),

        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: 125.w,
            height: 17.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(5.r),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // PROFILE AVATAR
  // ============================================================

  Widget _buildProfileAvatar(String imageUrl) {
    final bool hasImage = imageUrl.trim().isNotEmpty;

    return Container(
      width: 50.w,
      height: 50.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFF5F5F5),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipOval(
        child: hasImage
            ? CustomCachedImage(
          imageUrl: imageUrl,
          width: 50.w,
          height: 50.w,
          fit: BoxFit.cover,
        )
            : Container(
          color: Color(0xFFF3F4F6),
          child: Center(
            child: Icon(
              Icons.person_rounded,
              size: 30.sp,
              color: Colors.grey.shade500,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // ACTION BUTTON
  // ============================================================

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(100.r),
        child: Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey.shade200,
              width: 1,
            ),
          ),
          child: Center(
            child: Icon(
              icon,
              size: 21.sp,
              color: AppColors.mainColor,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: widget.preferredSize.height,
      titleSpacing: 16.w,

      // ========================================================
      // PROFILE + GREETING
      // ========================================================

      title: Obx(() {
        if (_profileGetController.isLoading.value) {
          return Row(
            children: [
              _buildShimmerAvatar(),
              SizedBox(width: 10.w),
              _buildShimmerText(),
            ],
          );
        }

        final profile = _profileGetController.profile.value.data;

        final String imageUrl = profile?.profilePicture ?? "";

        final String firstName =
        profile?.firstName?.trim().isNotEmpty == true
            ? profile!.firstName!.trim()
            : "there";

        final String greeting = getGreeting();
        final String greetingEmoji = getGreetingEmoji();

        return Row(
          children: [
            // ==================================================
            // PROFILE IMAGE
            // ==================================================

            _buildProfileAvatar(imageUrl),

            SizedBox(width: 11.w),

            // ==================================================
            // GREETING + NAME
            // ==================================================

            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // First Line
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          greeting,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),

                      SizedBox(width: 5.w),

                      Text(
                        greetingEmoji,
                        style: TextStyle(
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 3.h),

                  // Second Line - Name
                  Text(
                    "$firstName 👋",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1F1F1F),
                      letterSpacing: 0.1,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),

      // ========================================================
      // ACTIONS
      // ========================================================

      actions: [
        // Notification
        _buildActionButton(
          icon: Icons.notifications_none_rounded,
          onTap: () {
            Get.to(() => NotificationPage());
          },
        ),

        SizedBox(width: 9.w),

        // Cart
        _buildActionButton(
          icon: Icons.shopping_bag_outlined,
          onTap: () {
            Get.to(() => CartPage());
          },
        ),

        SizedBox(width: 16.w),
      ],
    );
  }
}