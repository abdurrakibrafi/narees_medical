// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
import 'package:restaurent_discount_app/view/auth_view/forget_password_view/widget/otp_form_filed_widget.dart';
import '../../../uitilies/app_colors.dart';

class OTPFormView extends StatelessWidget {
  OTPFormView({super.key});

  final TextEditingController otpFormFiled = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.mainColor, Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.center,
              ),
            ),
          ),

          Positioned.fill(
            child: Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
            ),
          ),

          // White content overlay with slight transparency
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Image.asset(
                      'assets/images/main_logo_bg.png',
                      height: 180,
                    ),
                    SizedBox(height: 20),
                    CustomText(
                      text: 'Verify your OTP Code',
                      textAlign: TextAlign.center,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    SizedBox(height: 70),

                    OtpForm(controller: otpFormFiled),
                    SizedBox(height: 20),

                    // Remember Me

                    CustomText(
                      text: "Didn’t receive OTP",
                      fontSize: 16,
                    ),
                    CustomText(
                      text: "Resend Code",
                      underline: true,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),

                    SizedBox(height: 20),

                    SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: CustomButtonWidget(
                        btnText: "Verify",
                        onTap: () {},
                        iconWant: false,
                      ),
                    ),

                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
