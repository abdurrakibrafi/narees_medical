// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_text_filed.dart';
import 'package:restaurent_discount_app/view/sign_in_view/profile_complete_view.dart';

import '../../uitilies/app_colors.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

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
                      text: 'Welcome! Sign in to\nYour Nurse Portal',
                      textAlign: TextAlign.center,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    SizedBox(height: 30),

                    // Email
                    CustomTextField(
                      fillColor: Color(0xFFE4E4E4),
                      borderColor: Colors.transparent,
                      hintText: "Enter your email",
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

                    // Remember Me
                    Row(
                      children: [
                        Theme(
                          data: Theme.of(context).copyWith(
                            checkboxTheme: CheckboxThemeData(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                                side: BorderSide(color: AppColors.mainColor),
                              ),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                            ),
                          ),
                          child: Checkbox(
                            value: false,
                            onChanged: (_) {},
                            side: BorderSide(
                                color:
                                    AppColors.mainColor), // Also directly here
                            activeColor: AppColors.mainColor,
                          ),
                        ),
                        SizedBox(width: 4), // optional spacing
                        CustomText(
                          text: "Remember Me",
                          color: AppColors.mainColor.withOpacity(0.8),
                        ),
                      ],
                    ),
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
