// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_text_filed.dart';

import '../../../../uitilies/app_colors.dart';
import '../sign_in_view/profile_complete_view.dart';
import '../sign_in_view/sign_in_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  String _selectedRole = 'Patient'; // Default selected role

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
                child: SingleChildScrollView(
                  // Make the content scrollable
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

                      // Centering the Radio Buttons for Nurse and Patient
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Radio<String>(
                                  activeColor: AppColors.mainColor,
                                  value: 'Provider',
                                  groupValue: _selectedRole,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedRole = value!;
                                    });
                                  },
                                ),
                                CustomText(
                                  text: 'Provider',
                                  fontSize: 16,
                                ),
                              ],
                            ),
                            SizedBox(width: 20),
                            Row(
                              children: [
                                Radio<String>(
                                  activeColor: AppColors.mainColor,
                                  value: 'Patient',
                                  groupValue: _selectedRole,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedRole = value!;
                                    });
                                  },
                                ),
                                CustomText(
                                  text: 'Patient',
                                  fontSize: 16,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),

                      // First and Last Name fields
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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

                      // Phone number
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

                      // Confirm Password
                      CustomTextField(
                        fillColor: Color(0xFFE4E4E4),
                        borderColor: Colors.transparent,
                        hintText: "Enter confirm password",
                        showObscure: true,
                      ),

                      SizedBox(height: 20),

                      // Sign Up Button
                      SizedBox(
                        height: 55,
                        width: double.infinity,
                        child: CustomButtonWidget(
                          gradient: LinearGradient(
                              colors: [Color(0xFF0071BC), Color(0xFF003456)],
                              begin: Alignment.topLeft,
                              end: Alignment.topRight),
                          btnText: "Sign Up",
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
                            text: "Already have an account?",
                          ),
                          SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => SignInView());
                            },
                            child: CustomText(
                              text: "Sign In",
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
