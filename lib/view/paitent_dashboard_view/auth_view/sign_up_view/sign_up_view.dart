// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_text_filed.dart';
import 'package:restaurent_discount_app/view/paitent_dashboard_view/auth_view/sign_up_view/controller/sign_up_controller.dart';
import '../../../../uitilies/app_colors.dart';
import '../../../../uitilies/custom_loader.dart';
import '../../../../uitilies/custom_toast.dart';
import '../sign_in_view/profile_complete_view.dart';
import '../sign_in_view/sign_in_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  String _selectedRole = 'Patient';
  final RegisterController _registerController = Get.put(RegisterController());

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
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
        Positioned.fill(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SafeArea(
              child: SingleChildScrollView(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: _firstNameController,
                            fillColor: Color(0xFFE4E4E4),
                            borderColor: Colors.transparent,
                            hintText: "First Name",
                            showObscure: false,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: CustomTextField(
                            controller: _lastNameController,
                            fillColor: Color(0xFFE4E4E4),
                            borderColor: Colors.transparent,
                            hintText: "Last Name",
                            showObscure: false,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      controller: _emailController,
                      fillColor: Color(0xFFE4E4E4),
                      borderColor: Colors.transparent,
                      hintText: "Enter your email",
                      showObscure: false,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      controller: _phoneController,
                      fillColor: Color(0xFFE4E4E4),
                      borderColor: Colors.transparent,
                      hintText: "Enter phone number",
                      showObscure: false,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      controller: _passwordController,
                      fillColor: Color(0xFFE4E4E4),
                      borderColor: Colors.transparent,
                      hintText: "Enter your password",
                      showObscure: true,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      controller: _confirmPasswordController,
                      fillColor: Color(0xFFE4E4E4),
                      borderColor: Colors.transparent,
                      hintText: "Enter confirm password",
                      showObscure: true,
                    ),
                    SizedBox(height: 20),
                    Obx(() {
                      return _registerController.isLoading.value == true
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
                                btnText: "Sign Up",
                                onTap: () {
                                  if (_firstNameController.text.isEmpty ||
                                      _lastNameController.text.isEmpty ||
                                      _emailController.text.isEmpty ||
                                      _phoneController.text.isEmpty ||
                                      _passwordController.text.isEmpty ||
                                      _confirmPasswordController.text.isEmpty) {
                                    CustomToast.showToast(
                                        "All fields are required!",
                                        isError: true);
                                  } else if (_passwordController.text !=
                                      _confirmPasswordController.text) {
                                    CustomToast.showToast(
                                        "Passwords do not match!",
                                        isError: true);
                                  } else {
                                    String role = _selectedRole == 'Patient'
                                        ? 'PATIENT'
                                        : 'NURSE';
                                    _registerController.register(
                                      firstName: _firstNameController.text,
                                      lastName: _lastNameController.text,
                                      email: _emailController.text,
                                      role: role,
                                      phoneNumber: _phoneController.text,
                                      password: _passwordController.text,
                                    );
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
