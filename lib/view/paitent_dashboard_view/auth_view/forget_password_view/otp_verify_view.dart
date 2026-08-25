// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
import 'package:restaurent_discount_app/uitilies/custom_loader.dart';
import 'package:restaurent_discount_app/uitilies/custom_toast.dart';
import 'package:restaurent_discount_app/view/paitent_dashboard_view/auth_view/forget_password_view/controller/otp_verify_controller.dart';
import 'package:restaurent_discount_app/view/paitent_dashboard_view/auth_view/forget_password_view/widget/otp_form_filed_widget.dart';
import '../../../../uitilies/app_colors.dart';
import 'create_new_password_view.dart';

class OTPFormView extends StatelessWidget {
  final String email;

  OTPFormView({super.key, required this.email});

  final TextEditingController otpFormFiled = TextEditingController();
  final OTPController _otpController = Get.put(OTPController());

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
                      text: 'Verify your  account',
                      textAlign: TextAlign.center,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),

                    SizedBox(height: 20),

                    CustomText(
                      text:
                          '   We sent a 6-digit verification code to $email \n Enter the code below to continue.',
                      textAlign: TextAlign.center,
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.8),
                    ),

                    SizedBox(height: 40),

                    OtpForm(controller: otpFormFiled),
                    SizedBox(height: 20),

                    // Remember Me

                    CustomText(
                      fontFamily: 'Sanchez',
                      text: "Didn’t receive Code?",
                      fontSize: 16,
                    ),
                    CustomText(
                      fontFamily: 'Sanchez',
                      text: "Resend Code",
                      underline: true,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),

                    SizedBox(height: 20),

                    Obx(() {
                      return _otpController.isLoading.value == true
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
                                btnText: "Submit",
                                onTap: () {
                                  if (otpFormFiled.text.isEmpty) {
                                    CustomToast.showToast("Please enter otp",
                                        isError: true);
                                  } else {
                                    _otpController.otpSubmit(
                                        otp: otpFormFiled.text);
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
