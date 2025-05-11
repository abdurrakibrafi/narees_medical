// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_text_filed.dart';
import '../../../../uitilies/app_colors.dart';
import '../sign_in_view/sign_in_view.dart';
import 'otp_verify_view.dart';

class CreateNewPassword extends StatelessWidget {
  const CreateNewPassword({super.key});

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
                      text: 'Create New Password !',
                      textAlign: TextAlign.center,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),

                    SizedBox(height: 70),

                    // Email
                    CustomTextField(
                      fillColor: Color(0xFFE4E4E4),
                      borderColor: Colors.transparent,
                      hintText: "Enter new password",
                      showObscure: true,
                    ),
                    SizedBox(height: 20),

                    // Email
                    CustomTextField(
                      fillColor: Color(0xFFE4E4E4),
                      borderColor: Colors.transparent,
                      hintText: "Enter confirm password",
                      showObscure: true,
                    ),
                    SizedBox(height: 20),

                    // Remember Me

                    SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: CustomButtonWidget(
                        gradient: LinearGradient(
                            colors: [Color(0xFF0071BC), Color(0xFF003456)],
                            begin: Alignment.topLeft,
                            end: Alignment.topRight),
                        btnText: "Create",
                        onTap: () {
                          Get.to(() => SignInView());
                        },
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
