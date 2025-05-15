// second_step_profile.dart

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurent_discount_app/uitilies/custom_loader.dart';
import 'package:restaurent_discount_app/uitilies/custom_toast.dart';
import 'package:signature/signature.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
import 'package:restaurent_discount_app/uitilies/constant.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import 'controller/profile_complete_controller.dart';

class SecondStepProfile extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String number;
  final String zipcode;
  final String location;
  final String special;
  final List<File>? nurseDocuments;
  final XFile? profile;

  const SecondStepProfile({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.number,
    required this.zipcode,
    required this.location,
    required this.special,
    this.nurseDocuments,
    this.profile,
  }) : super(key: key);

  @override
  State<SecondStepProfile> createState() => _SecondStepProfileState();
}

class _SecondStepProfileState extends State<SecondStepProfile> {
  bool baaChecked = false;
  bool socialMediaChecked = false;
  bool harassmentPolicyChecked = false;
  bool recurringPaymentChecked = false;

  final List<String> urls = [
    'https://www.example.com/baa',
    'https://www.example.com/social-media',
    'https://www.example.com/harassment-policy',
    'https://www.example.com/recurring-payment',
  ];

  final SignatureController _signatureController = SignatureController(
    penColor: Colors.black,
    penStrokeWidth: 2,
    exportBackgroundColor: Colors.white,
  );

  final ProfileCompleteController _profileController =
      Get.put(ProfileCompleteController());

  bool get allAgreementsChecked =>
      baaChecked &&
      socialMediaChecked &&
      harassmentPolicyChecked &&
      recurringPaymentChecked;

  Future<File?> _exportSignature() async {
    if (_signatureController.isNotEmpty) {
      final Uint8List? data = await _signatureController.toPngBytes();
      if (data != null) {
        final tempDir = Directory.systemTemp;
        final file =
            await File('${tempDir.path}/signature.png').writeAsBytes(data);
        return file;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Profile Complete"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: widget.profile != null
                          ? FileImage(File(widget.profile!.path))
                          : NetworkImage(
                                  'https://www.w3schools.com/w3images/avatar2.png')
                              as ImageProvider,
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomText(
                    text: 'Agreements',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  ...[
                    {
                      'checked': baaChecked,
                      'label': 'Business Associate Agreement (BAA)',
                      'url': urls[0],
                      'onChanged': (bool? v) {
                        setState(() {
                          baaChecked = v ?? false;
                        });
                      }
                    },
                    {
                      'checked': socialMediaChecked,
                      'label': 'Social Media Agreement',
                      'url': urls[1],
                      'onChanged': (bool? v) {
                        setState(() {
                          socialMediaChecked = v ?? false;
                        });
                      }
                    },
                    {
                      'checked': harassmentPolicyChecked,
                      'label': 'Harassment Policy',
                      'url': urls[2],
                      'onChanged': (bool? v) {
                        setState(() {
                          harassmentPolicyChecked = v ?? false;
                        });
                      }
                    },
                    {
                      'checked': recurringPaymentChecked,
                      'label': 'Recurring Payment Agreement',
                      'url': urls[3],
                      'onChanged': (bool? v) {
                        setState(() {
                          recurringPaymentChecked = v ?? false;
                        });
                      }
                    },
                  ].map((e) {
                    return Row(
                      children: [
                        Checkbox(
                          value: e['checked'] as bool,
                          onChanged: e['onChanged'] as void Function(bool?)?,
                          activeColor: Color(0xFF0071BC),
                        ),
                        GestureDetector(
                          onTap: () => _launchURL(e['url'] as String),
                          child: CustomText(
                            underline: true,
                            fontSize: 14.h,
                            text: e['label'] as String,
                            color: Color(0xFF0071BC),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                  SizedBox(height: 20),
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: AppPadding.bodyPadding,
                      child: Column(
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
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Signature(
                                controller: _signatureController,
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _signatureController.clear();
                                  });
                                },
                                child: Text(
                                  'Clear Signature',
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
                  _profileController.isLoading.value
                      ? Center(child: CustomLoader())
                      : SizedBox(
                          height: 50,
                          child: CustomButtonWidget(
                            gradient: LinearGradient(
                                colors: [Color(0xFF0071BC), Color(0xFF003456)],
                                begin: Alignment.topLeft,
                                end: Alignment.topRight),
                            btnText: "Submit",
                            onTap: () async {
                              if (!allAgreementsChecked) {
                                CustomToast.showToast(
                                    "Please agree with the agreements",
                                    isError: true);

                                return;
                              }
                              if (_signatureController.isEmpty) {
                                CustomToast.showToast(
                                    "Please provide your signature",
                                    isError: true);
                                return;
                              }
                              File? signatureFile = await _exportSignature();

                              await _profileController.register(
                                firstName: widget.firstName,
                                lastName: widget.lastName,
                                phoneNumber: widget.number,
                                location: widget.location,
                                zipCode: widget.zipcode,
                                specialty: widget.special,
                                profilePicture: widget.profile != null
                                    ? File(widget.profile!.path)
                                    : null,
                                signature: signatureFile,
                                nurseDocuments: widget.nurseDocuments,
                              );
                            },
                            iconWant: false,
                          ),
                        ),
                  SizedBox(height: 20),
                ],
              )),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
