// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';

import '../../common widget/custom text/custom_text_widget.dart';
import '../profile_complete_view/profile_complete_view.dart';

class ProfileCompleteView extends StatefulWidget {
  const ProfileCompleteView({super.key});

  @override
  State<ProfileCompleteView> createState() => _ProfileCompleteViewState();
}

class _ProfileCompleteViewState extends State<ProfileCompleteView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showSuccessDialog();
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Optional: force user to press button
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              color: Color(0xFFE8F4FA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.info_outline, color: AppColors.mainColor, size: 40),
                SizedBox(height: 16),
                CustomText(
                  text: "Complete Your Profile to Get Started!",
                  textAlign: TextAlign.center,
                  color: Colors.blueGrey,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  child: CustomButtonWidget(
                      btnText: "Profile Complete",
                      onTap: () {
                        Get.to(() => ProfileFillUpView());
                      },
                      iconWant: false),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.mainColor, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.center,
              ),
            ),
          ),

          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
            ),
          ),

          // Optional foreground overlay
          Positioned.fill(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
