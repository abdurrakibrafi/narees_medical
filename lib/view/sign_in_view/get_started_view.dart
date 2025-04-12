import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:restaurent_discount_app/view/sign_in_view/sign_in_view.dart';
import '../../common widget/custom text/custom_text_widget.dart';
import '../../common widget/custom_button_widget.dart';

class GetStartedView extends StatelessWidget {
  const GetStartedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/onboard.png',
              fit: BoxFit.cover,
            ),
          ),

          // White content overlay with slight transparency
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                      text: 'Streamline Your Workflow, Focus on Care',
                      textAlign: TextAlign.center,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),

                    CustomText(
                      text:
                          ' Manage patients, track appointments, and handle supplies effortlessly',
                      textAlign: TextAlign.center,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    SizedBox(height: 20),

                    // Sign In Button
                    SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: CustomButtonWidget(
                        btnText: "Get Started",
                        onTap: () {
                          Get.to(() => SignInView());
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
