// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';

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
              color: Colors.blue.shade800,
              child: CustomText(
                textAlign: TextAlign.start,
                text: 'IV Insertion Techniques',
                color: Colors.white,
                fontSize: 16,
              ),
            ),
             TabBar(
              labelStyle:  GoogleFonts.abhayaLibre(
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
              tabs:  [
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

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (index + 1).toString().padLeft(2, '0'),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(module["title"],
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(module["duration"],
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              Icon(statusIcon, color: Colors.blue, size: 28),
            ],
          ),
        );
      },
    );
  }
}
