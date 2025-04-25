// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20controller/custom%20alert%20dialog/custom_alert_dialog.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
import 'package:restaurent_discount_app/uitilies/constant.dart';
import 'package:signature/signature.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import '../../common widget/custom text/custom_text_widget.dart';
import '../tranning_module/tranning_module_view.dart';
import 'controller/signature_controller.dart';

class SecondStepProfile extends StatelessWidget {
  const SecondStepProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final SignatureSelectController controller =
        Get.put(SignatureSelectController());

    final SignatureController _signatureController = SignatureController(
      penColor: Colors.black,
      penStrokeWidth: 2,
      exportBackgroundColor: Colors.white,
    );

    bool baaChecked = false;
    bool socialMediaChecked = false;
    bool harassmentPolicyChecked = false;
    bool recurringPaymentChecked = false;

    bool isSignatureDrawn = false;
    bool isSignatureUploaded = false;

    // URLs for the checkboxes
    final List<String> urls = [
      'https://www.example.com/baa',
      'https://www.example.com/social-media',
      'https://www.example.com/harassment-policy',
      'https://www.example.com/recurring-payment',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Profile Complete"),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Image
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        'https://www.w3schools.com/w3images/avatar2.png'),
                  ),
                ),
                SizedBox(height: 20),

                // Agreements Section
                CustomText(
                  text: 'Agreements',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),

                // Agreements checkboxes in a Row
                Row(
                  children: [
                    Checkbox(
                      value: baaChecked,
                      onChanged: (value) {
                        baaChecked = value!;
                      },
                      activeColor: Color(0xFF0071BC),
                    ),
                    GestureDetector(
                      onTap: () => _launchURL(urls[0]),
                      child: CustomText(
                        underline: true,
                        fontSize: 14.h,
                        text: 'Business Associate Agreement (BAA)',
                        color: Color(0xFF0071BC),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: socialMediaChecked,
                      onChanged: (value) {
                        socialMediaChecked = value!;
                      },
                      activeColor: Color(0xFF0071BC),
                    ),
                    GestureDetector(
                      onTap: () => _launchURL(urls[1]),
                      child: CustomText(
                        underline: true,
                        fontSize: 14.h,
                        text: 'Social Media Agreement',
                        color: Color(0xFF0071BC),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: harassmentPolicyChecked,
                      onChanged: (value) {
                        harassmentPolicyChecked = value!;
                      },
                      activeColor: Color(0xFF0071BC),
                    ),
                    GestureDetector(
                      onTap: () => _launchURL(urls[2]),
                      child: CustomText(
                        underline: true,
                        fontSize: 14.h,
                        text: 'Harassment Policy',
                        color: Color(0xFF0071BC),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: recurringPaymentChecked,
                      onChanged: (value) {
                        recurringPaymentChecked = value!;
                      },
                      activeColor: Color(0xFF0071BC),
                    ),
                    GestureDetector(
                      onTap: () => _launchURL(urls[3]),
                      child: CustomText(
                        underline: true,
                        fontSize: 14.h,
                        text: 'Recurring Payment Agreement',
                        color: Color(0xFF0071BC),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Signature Section

                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: AppPadding.bodyPadding,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        CustomText(
                          text: 'Signature',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        SizedBox(height: 10),
                        Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.isDrawSelected.value = true;
                                      isSignatureDrawn = true;
                                      isSignatureUploaded = false;
                                    },
                                    child: Column(
                                      children: [
                                        CustomText(
                                          fontSize: 19,
                                          text: 'Draw',
                                          color: Colors.black,
                                        ),
                                        if (controller.isDrawSelected.value)
                                          Container(
                                            height: 2,
                                            width: 50,
                                            color: Colors
                                                .blue, // Add an underline when selected
                                          )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  GestureDetector(
                                    onTap: () {
                                      controller.isDrawSelected.value = false;
                                      isSignatureUploaded = true;
                                      isSignatureDrawn = false;
                                    },
                                    child: Column(
                                      children: [
                                        CustomText(
                                          fontSize: 19,
                                          text: 'Upload',
                                          color: Colors.black,
                                        ),
                                        if (!controller.isDrawSelected.value)
                                          Container(
                                            height: 2,
                                            width: 50,
                                            color: Colors
                                                .blue, // Add an underline when selected
                                          )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              if (controller.isDrawSelected.value) ...[
                                Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 150,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Signature(
                                          controller: _signatureController,
                                          backgroundColor: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ] else ...[
                                DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: Radius.circular(12),
                                  color: Colors.grey,
                                  dashPattern: [8, 4],
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      children: [
                                        CustomText(
                                          text: 'Drop a signature image',
                                          fontSize: 15.h,
                                        ),
                                        SizedBox(height: 10),
                                        SizedBox(
                                          height: 39,
                                          width: 100,
                                          child: CustomButtonWidget(
                                              btnTextSize: 15.0,
                                              btnText: "Select",
                                              onTap: () {},
                                              iconWant: false),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: recurringPaymentChecked,
                              onChanged: (value) {
                                recurringPaymentChecked = value!;
                              },
                              activeColor: Color(0xFF0071BC),
                            ),
                            Container(
                              width: 250,
                              child: CustomText(
                                fontSize: 10,
                                textAlign: TextAlign.start,
                                text:
                                    'By signing this document with an electronic signature, you agree that such signature will be valid as the document signature as the law allows.',
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                        // Clear Signature
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                _signatureController.clear();
                              },
                              child: Text(
                                'Clear',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),

                SizedBox(
                  height: 50,
                  child: CustomButtonWidget(
                    gradient: LinearGradient(
                        colors: [Color(0xFF0071BC), Color(0xFF003456)],
                        begin: Alignment.topLeft,
                        end: Alignment.topRight),

                      btnText: "Submit",
                      onTap: () {
                        CustomAlertDialog.showCustomDialog(
                            title: "Congrats",
                            content:
                                "Your profile is complete! Now, complete your training to unlock full access.",
                            cancelName: "No",
                            actionName: "Ok",
                            confirmText: "Ok",
                            onConfirm: () {
                              Get.to(() => TrainingPortalScreen());
                            });
                      },
                      iconWant: false),
                ),

                SizedBox(height: 20),
              ],
            ),
          )),
    );
  }

  // Method to launch the URL using the default browser
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
