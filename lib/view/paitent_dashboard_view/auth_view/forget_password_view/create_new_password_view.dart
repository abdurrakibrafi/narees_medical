// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_text_filed.dart';
import 'package:restaurent_discount_app/uitilies/custom_loader.dart';
import 'package:restaurent_discount_app/view/paitent_dashboard_view/auth_view/forget_password_view/controller/reset_password_controller.dart';
import '../../../../uitilies/app_colors.dart';
import '../../../../uitilies/custom_toast.dart';

class CreateNewPassword extends StatelessWidget {
  CreateNewPassword({super.key});

  final CreateNewPasswordController _createNewPasswordController =
      Get.put(CreateNewPasswordController());

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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

                    // Password Field
                    CustomTextField(
                      controller: passwordController,
                      fillColor: Color(0xFFE4E4E4),
                      borderColor: Colors.transparent,
                      hintText: "Enter new password",
                      showObscure: true,
                    ),
                    SizedBox(height: 20),

                    // Confirm Password Field
                    CustomTextField(
                      controller: confirmPasswordController,
                      fillColor: Color(0xFFE4E4E4),
                      borderColor: Colors.transparent,
                      hintText: "Enter confirm password",
                      showObscure: true,
                    ),
                    SizedBox(height: 20),

                    Obx(() {
                      return _createNewPasswordController.isLoading.value
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
                                btnText: "Create",
                                onTap: () {
                                  String password = passwordController.text;
                                  String confirmPassword =
                                      confirmPasswordController.text;

                                  if (password.isEmpty ||
                                      confirmPassword.isEmpty) {
                                    CustomToast.showToast(
                                      "Please fill out both fields",
                                      isError: true,
                                    );
                                  } else if (password != confirmPassword) {
                                    CustomToast.showToast(
                                      "Passwords do not match",
                                      isError: true,
                                    );
                                  } else {
                                    _createNewPasswordController.resetPassword(
                                        newPass: password);
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
