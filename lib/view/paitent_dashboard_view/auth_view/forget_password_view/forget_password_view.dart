// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_text_filed.dart';
import 'package:restaurent_discount_app/uitilies/custom_loader.dart';
import 'package:restaurent_discount_app/view/paitent_dashboard_view/auth_view/forget_password_view/controller/forget_password_controller.dart';
import '../../../../uitilies/app_colors.dart';
import '../../../../uitilies/custom_toast.dart';
import 'otp_verify_view.dart';

class ForgetPasswordView extends StatelessWidget {
  ForgetPasswordView({super.key});

  final ForgetPasswordController _forgetPasswordController =
      Get.put(ForgetPasswordController());

  final TextEditingController _emailC = TextEditingController();

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
                      text: 'Forgot Password?',
                      textAlign: TextAlign.center,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    SizedBox(height: 70),

                    // Email
                    CustomTextField(
                      controller: _emailC,
                      fillColor: Color(0xFFE4E4E4),
                      borderColor: Colors.transparent,
                      hintText: "Enter your email",
                      showObscure: false,
                    ),
                    SizedBox(height: 20),

                    // Remember Me

                    Obx(() {
                      return _forgetPasswordController.isLoading.value == true
                          ? CustomLoader()
                          : SizedBox(
                              height: 55,
                              width: double.infinity,
                              child: CustomButtonWidget(
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF0071BC),
                                      Color(0xFF003456)
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.topRight),
                                btnText: "Send",
                                onTap: () {
                                  if (_emailC.text.isEmpty) {
                                    CustomToast.showToast("Please enter a mail",
                                        isError: true);
                                  } else {
                                    _forgetPasswordController.forgetPass(
                                        email: _emailC.text);
                                  }
                                },
                                iconWant: false,
                              ),
                            );
                    }),

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
