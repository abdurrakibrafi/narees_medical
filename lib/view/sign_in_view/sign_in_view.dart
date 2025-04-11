// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_text_filed.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/Tunnel.png', // ✅ replace with your background image
              fit: BoxFit.cover,
            ),
          ),

          // Top to center gradient overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).size.height * 0.5,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF0070D2),
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                ),
              ),
            ),
          ),

          // Foreground white content
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.95),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Image.asset(
                      'assets/images/main_logo_bg.png', // ✅ replace with your logo
                      height: 180,
                    ),
                    SizedBox(height: 30),
                    CustomText(
                      text: 'Welcome! Sign in to\nYour Nurse Portal',
                      textAlign: TextAlign.center,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    SizedBox(height: 30),

                    // Email
                    CustomTextField(
                      hintText: "Enter your email",
                      showObscure: false,
                    ),
                    SizedBox(height: 20),

                    // Password
                    CustomTextField(
                      hintText: "Enter your password",
                      showObscure: true,
                    ),
                    SizedBox(height: 10),

                    // Remember Me
                    Row(
                      children: [
                        Checkbox(value: false, onChanged: (_) {}),
                        Text("Remember Me"),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Sign In Button
                    SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: CustomButtonWidget(
                        btnText: "Sign In",
                        onTap: () {},
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
