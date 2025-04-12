import 'package:flutter/material.dart';
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
                  children: [
                    SizedBox(height: 40),

                    SizedBox(height: 20),
                    CustomText(
                      text: 'Welcome! Sign in to\nYour Nurse Portal',
                      textAlign: TextAlign.center,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    SizedBox(height: 30),

                    SizedBox(height: 20),

                    // Sign In Button
                    SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: CustomButtonWidget(
                        btnText: "Sign In",
                        onTap: () {
                          // Get.to(() => ProfileCompleteView());
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
