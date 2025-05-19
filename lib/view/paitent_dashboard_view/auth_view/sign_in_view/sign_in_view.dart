// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_text_filed.dart';
import 'package:restaurent_discount_app/uitilies/custom_loader.dart';
import 'package:restaurent_discount_app/view/paitent_dashboard_view/auth_view/sign_in_view/controller/sign_in_controller.dart';
import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../uitilies/app_colors.dart';
import '../../../../uitilies/custom_toast.dart';
import '../forget_password_view/forget_password_view.dart';
import '../sign_up_view/sign_up_view.dart';

class SignInView extends StatelessWidget {
  SignInView({super.key});

  final SignInController _signInController = Get.put(SignInController());

  final TextEditingController _emailC = TextEditingController();
  final TextEditingController _passwordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
            child: SafeArea(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Image.asset(
                      'assets/images/main_logo_bg.png',
                      height: 180,
                    ),
                    SizedBox(height: 20),
                    CustomText(
                      text: 'Welcome to Sign in!\n',
                      textAlign: TextAlign.center,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    SizedBox(height: 30),

                    // Email
                    CustomTextField(
                      controller: _emailC,
                      fillColor: Color(0xFFE4E4E4),
                      borderColor: Colors.transparent,
                      hintText: "Enter your email",
                      showObscure: false,
                    ),
                    SizedBox(height: 20),

                    // Password
                    CustomTextField(
                      controller: _passwordC,
                      fillColor: Color(0xFFE4E4E4),
                      borderColor: Colors.transparent,
                      hintText: "Enter your password",
                      showObscure: true,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Theme(
                              data: Theme.of(context).copyWith(
                                checkboxTheme: CheckboxThemeData(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    side:
                                        BorderSide(color: AppColors.mainColor),
                                  ),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                ),
                              ),
                              child: Checkbox(
                                value: false,
                                onChanged: (_) {},
                                side: BorderSide(color: AppColors.mainColor),
                                activeColor: AppColors.mainColor,
                              ),
                            ),
                            SizedBox(width: 4),
                            CustomText(
                              text: "Remember Me",
                              fontSize: 16,
                              color: AppColors.mainColor.withOpacity(0.8),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => ForgetPasswordView());
                          },
                          child: CustomText(
                            text: "Forgot Password",
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 20),

                    // Sign In Button
                    Obx(() {
                      return _signInController.isLoading.value == true
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
                                btnText: "Sign In",
                                onTap: () {
                                  if (_emailC.text.isEmpty ||
                                      _passwordC.text.isEmpty) {
                                    CustomToast.showToast(
                                        "All fields are required!",
                                        isError: true);
                                  } else {
                                    _signInController.login(
                                        email: _emailC.text,
                                        password: _passwordC.text);
                                  }
                                },
                                iconWant: false,
                              ),
                            );
                    }),

                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "Don’t have an account?",
                        ),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => SignUpView());
                          },
                          child: CustomText(
                            text: "Sign Up",
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 40),
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
