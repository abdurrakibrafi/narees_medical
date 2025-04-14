import 'package:flutter/material.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';

class CertificateWidget extends StatelessWidget {
  const CertificateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage(
              'assets/images/certificate.jpeg'), // Replace with your background image
          fit: BoxFit.cover, // Ensure image covers the area
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title Text
          Text(
            'Completion Certificate 🎉',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14, // Adjusted size to fit
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6), // Smaller spacing between text and button
          // Description Text
          const Text(
            'You have successfully completed your\ncourse. Download and your certificate.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12, // Smaller font size to fit within the container
              color: Colors.white,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 10), // Adjusted height to fit well
          // Button
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Implement download logic
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.download),
            label: CustomText(
              text: 'Download Certificate',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
