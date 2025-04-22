// Certificate Card widget for displaying Certificates
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';

class CertificateCard extends StatelessWidget {
  final String certificateName;
  final String fileSize;

  const CertificateCard({
    Key? key,
    required this.certificateName,
    required this.fileSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Certificate Icon
            Icon(
              Icons.picture_as_pdf,
              color: Colors.blue,
              size: 30,
            ),
            SizedBox(width: 16),
            // Certificate Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    textAlign: TextAlign.start,
                    text: certificateName,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  SizedBox(height: 4),
                  CustomText(
                  text:   fileSize,
                  color: Colors.grey,fontSize: 15,
                  ),
                ],
              ),
            ),
            // Download Button
            IconButton(
              icon: Icon(Icons.download, color: Colors.blue),
              onPressed: () {
                // Implement the download functionality
                print("Download clicked");
              },
            ),
          ],
        ),
      ),
    );
  }
}
