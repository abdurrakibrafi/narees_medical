// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';

class PatientInformationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: Colors.grey.withOpacity(0.5), width: 2)),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('First Name:', 'Anna'),
                  Divider(),
                  _buildDetailRow('Last Name:', 'Suraiya'),
                  _buildDetailRow('Email Address:', 'anna879@gmail.com'),
                  _buildDetailRow('Phone Number:', '(234) 555-1234'),
                  _buildDetailRow('Treatment Type:', 'Hydration IV Treatment'),
                  _buildDetailRow('Physical address:', '123/A, Florida, UK'),
                  _buildDetailRow('Location:', '123/A, Florida, UK'),
                  _buildDetailRow('Zip Code:', '1217'),

                  SizedBox(height: 30.h),

                  // Document Section
                  Text('Document',
                      style: TextStyle(
                          fontSize: 20.h, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10.h),
                  _buildDownloadLink('Download HIPAA Compliant.pdf', '153 Mb'),
                  _buildDownloadLink('Download Medical History.pdf', '153 Mb'),
                  _buildDownloadLink(
                      'Download Payment Agreement.pdf', '153 Mb'),

                  SizedBox(height: 30.h),

                  Text('Patient ID',
                      style: TextStyle(
                          fontSize: 20.h, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10.h),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      'assets/patient_id_card.png', // Replace with your image asset path
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200.h,
                    ),
                  ),
                ],
              ),
            )));
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: title, fontSize: 16.h, fontWeight: FontWeight.w500),
          CustomText(text: value, fontSize: 16.h, color: Colors.grey),
        ],
      ),
    );
  }

  // Helper function for creating download links
  Widget _buildDownloadLink(String title, String size) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(fontSize: 16.h, fontWeight: FontWeight.w500)),
          Text(size, style: TextStyle(fontSize: 14.h, color: Colors.blue)),
          Icon(Icons.download, color: Colors.blue),
        ],
      ),
    );
  }
}
