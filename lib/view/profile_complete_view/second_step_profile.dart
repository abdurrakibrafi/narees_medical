// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher
import 'package:webview_flutter/webview_flutter.dart'; // Import webview_flutter

import '../../common widget/custom text/custom_text_widget.dart';

class SecondStepProfile extends StatefulWidget {
  const SecondStepProfile({super.key});

  @override
  _SecondStepProfileState createState() => _SecondStepProfileState();
}

class _SecondStepProfileState extends State<SecondStepProfile> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Profile Complete"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                    setState(() {
                      baaChecked = value!;
                    });
                  },
                  activeColor: Color(0xFF0071BC), // Active color for checkbox
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
                    setState(() {
                      socialMediaChecked = value!;
                    });
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
                    setState(() {
                      harassmentPolicyChecked = value!;
                    });
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
                    setState(() {
                      recurringPaymentChecked = value!;
                    });
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
            Text(
              'Signature',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isSignatureDrawn = true;
                      isSignatureUploaded = false;
                    });
                  },
                  child: Text('Draw'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isSignatureUploaded = true;
                      isSignatureDrawn = false;
                    });
                  },
                  child: Text('Upload'),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (isSignatureUploaded)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text('Drag & Drop a signature image or'),
                        ElevatedButton(
                          onPressed: () {
                            // Implement image selection functionality
                          },
                          child: Text('SELECT IMAGE'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'By signing this document with an electronic signature, you agree that such signature will be valid as the document signature as the law allows.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            if (isSignatureDrawn)
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text('Signature Drawing Area'),
                    // Implement drawing area (can use a custom package like flutter_signature_pad)
                  ],
                ),
              ),
            SizedBox(height: 20),

            // Clear Signature
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      isSignatureDrawn = false;
                      isSignatureUploaded = false;
                    });
                  },
                  child: Text(
                    'Clear',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Submit Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle form submission
                },
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
