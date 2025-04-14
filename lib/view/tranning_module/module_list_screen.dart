// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/view/tranning_module/module_details_view.dart'
    show TrainingModuleDetailScreen;

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
            const Expanded(
              child: TabBarView(
                children: [
                  _ModuleListTab(),
                  Center(child: Text('Certificate Tab')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModuleListTab extends StatelessWidget {
  const _ModuleListTab();

  final List<Map<String, dynamic>> modules = const [
    {
      "title": "Importance of Hand Hygiene",
      "duration": "01:30 mins",
      "status": "done"
    },
    {
      "title": "Importance of Hand Hygiene",
      "duration": "01:30 mins",
      "status": "done"
    },
    {
      "title": "Risk of Infection in IV Therapy",
      "duration": "01:30 mins",
      "status": "pause"
    },
    {
      "title": "Risk of Infection in IV Therapy",
      "duration": "01:30 mins",
      "status": "pause"
    },
    {
      "title": "Risk of Infection in IV Therapy",
      "duration": "01:30 mins",
      "status": "pause"
    },
    {
      "title": "Risk of Infection in IV Therapy",
      "duration": "01:30 mins",
      "status": "pause"
    },
    {
      "title": "Risk of Infection in IV Therapy",
      "duration": "01:30 mins",
      "status": "pause"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: modules.length,
      itemBuilder: (context, index) {
        final module = modules[index];
        final statusIcon = module["status"] == "done"
            ? Icons.check_circle
            : Icons.pause_circle_filled;

        return GestureDetector(
            onTap: () {
              Get.to(() => TrainingModuleDetailScreen());
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: (index + 1).toString().padLeft(2, '0'),
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: module["title"],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        const SizedBox(height: 4),
                        CustomText(
                          text: module["duration"],
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ],
                    ),
                  ),
                  Icon(statusIcon, color: Colors.blue, size: 28),
                ],
              ),
            ));
      },
    );
  }
}
