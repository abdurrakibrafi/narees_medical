// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_text_filed.dart';
import 'package:restaurent_discount_app/view/auth_view/sign_in_view/profile_complete_view.dart';
import '../../../uitilies/app_colors.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

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
                    SizedBox(height: 20),
                    Image.asset(
                      'assets/images/main_logo_bg.png',
                      height: 110,
                    ),
                    SizedBox(height: 20),
                    CustomText(
                      text: 'Welcome! Sign Up to\nCreate your account',
                      textAlign: TextAlign.center,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    SizedBox(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            fillColor: Color(0xFFE4E4E4),
                            borderColor: Colors.transparent,
                            hintText: "First Name",
                            showObscure: false,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: CustomTextField(
                            fillColor: Color(0xFFE4E4E4),
                            borderColor: Colors.transparent,
                            hintText: "Last Name",
                            showObscure: false,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    // Email
                    CustomTextField(
                      fillColor: Color(0xFFE4E4E4),
                      borderColor: Colors.transparent,
                      hintText: "Enter your email",
                      showObscure: false,
                    ),
                    SizedBox(height: 20),


                    // Email
                    CustomTextField(
                      fillColor: Color(0xFFE4E4E4),
                      borderColor: Colors.transparent,
                      hintText: "Enter phone number",
                      showObscure: false,
                    ),
                    SizedBox(height: 20),


                    // Password
                    CustomTextField(
                      fillColor: Color(0xFFE4E4E4),
                      borderColor: Colors.transparent,
                      hintText: "Enter your password",
                      showObscure: true,
                    ),
                    SizedBox(height: 20),


                    // Password
                    CustomTextField(
                      fillColor: Color(0xFFE4E4E4),
                      borderColor: Colors.transparent,
                      hintText: "Enter confirm password",
                      showObscure: true,
                    ),
                    // Remember Me

                    SizedBox(height: 20),

                    // Sign In Button
                    SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: CustomButtonWidget(
                        btnText: "Sign In",
                        onTap: () {
                          Get.to(() => ProfileCompleteView());
                        },
                        iconWant: false,
                      ),
                    ),

                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "Don’t have an account?",
                        ),
                        SizedBox(width: 5),
                        CustomText(
                          text: "Sign In",
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    )
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
