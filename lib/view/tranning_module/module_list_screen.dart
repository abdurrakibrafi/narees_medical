// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';

import 'package:restaurent_discount_app/view/tranning_module/widget/module_list_tab_widget.dart';

class ModuleListScreen extends StatelessWidget {
  const ModuleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(title: "Training Module List"),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0071BC), Color(0xFF003456)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: CustomText(
                textAlign: TextAlign.start,
                text: 'IV Insertion Techniques',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.h,
              ),
            ),
            TabBar(
              labelStyle: GoogleFonts.abhayaLibre(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: GoogleFonts.abhayaLibre(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
              tabs: [
                Tab(text: 'Modules'),
                Tab(text: 'Certificate'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ModuleListTab(),
                  Container(
                    height: 120, // Fixed height for the container
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(
                        12), // Reduced padding to fit the content inside
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
                        CustomText(
                          text: 'Completion Certificate 🎉',
                          textAlign: TextAlign.center,

                          fontSize: 20.h, // Adjusted size to fit
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        const SizedBox(
                            height:
                                6), // Smaller spacing between text and button
                        // Description Text
                        CustomText(
                          text:
                              'You have successfully completed your\ncourse. Download and your certificate.',
                          textAlign: TextAlign.center,

                          fontSize:
                              18, // Smaller font size to fit within the container
                          color: Colors.white,
                        ),
                        const SizedBox(
                            height: 10),
                        // Button
                        ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Implement download logic
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: const Icon(Icons.download),
                          label: const Text(
                            'Download Certificate',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
