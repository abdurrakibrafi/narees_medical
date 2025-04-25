// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';

import '../../../nurse_dashboard/profile_view/widget/certification_card_widget.dart';

class PatientInformationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(15),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.5), width: 2)),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('First Name:', 'Anna'),
                      Divider(),
                      _buildDetailRow('Last Name:', 'Suraiya'),
                      Divider(),
                      _buildDetailRow('Email Address:', 'anna879@gmail.com'),
                      Divider(),
                      _buildDetailRow('Phone Number:', '(234) 555-1234'),
                      Divider(),
                      _buildDetailRow(
                          'Treatment Type:', 'Hydration IV Treatment'),
                      Divider(),
                      _buildDetailRow(
                          'Physical address:', '123/A, Florida, UK'),
                      Divider(),
                      _buildDetailRow('Location:', '123/A, Florida, UK'),
                      Divider(),
                      _buildDetailRow('Zip Code:', '1217'),

                      SizedBox(height: 10.h),

                      // Document Section
                      CustomText(
                          text: 'Document',
                          fontSize: 18.h,
                          fontWeight: FontWeight.bold),
                      CertificateCard(
                        certificateName: 'Hydration Therapy.pdf',
                        fileSize: '153 Mb',
                      ),

                      SizedBox(height: 10.h),

                      CustomText(
                          text: 'Patient ID',
                          fontSize: 17.h,
                          fontWeight: FontWeight.bold),
                      SizedBox(height: 10.h),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTn1VL1TA_ZSbMC9SQ-gtV_fxlDEImE8HWvbVxKea6F5aZ04YjpiecrhwwvCrX8jQQyUH0&usqp=CAU', // Replace with your image asset path
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 150.h,
                        ),
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ))));
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
