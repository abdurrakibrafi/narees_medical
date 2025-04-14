import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../module_details_view.dart';

class ModuleListTab extends StatelessWidget {
  const ModuleListTab();

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
