// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/view/tranning_module/widget/course_card_widget.dart';

class TrainingPortalScreen extends StatelessWidget {
  const TrainingPortalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Training Portal"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            const SizedBox(height: 16),
            Row(
              children: const [
                Expanded(
                    child: CourseCard(
                        title: "Total\nCourse Available",
                        value: "20",
                        icon: Icons.menu_book)),
                SizedBox(width: 16),
                Expanded(
                    child: CourseCard(
                        title: "Completed\nCourses",
                        value: "10",
                        icon: Icons.school)),
              ],
            ),
            const SizedBox(height: 24),
            CustomText(
              text: "Training Module Course",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 16),
            const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _TrainingModuleCard(
                        title: "Hydration Therapy Basics",
                        lessons: "21/24 Lesson"),
                    _TrainingModuleCard(
                        title: "IV Insertion Techniques",
                        lessons: "21/24 Lesson"),
                    _TrainingModuleCard(
                        title: "Emergency Protocols in IV Therapy",
                        lessons: "21/24 Lesson"),
                    _TrainingModuleCard(
                        title: "Infection Control in IV Therapy",
                        lessons: "21/24 Lesson"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintStyle: GoogleFonts.abhayaLibre(),
        hintText: "Search here.....",
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      ),
    );
  }
}

class _TrainingModuleCard extends StatelessWidget {
  final String title;
  final String lessons;

  const _TrainingModuleCard({
    required this.title,
    required this.lessons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(lessons, style: const TextStyle(fontSize: 12)),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  value: 0.5,
                  strokeWidth: 4,
                  color: Colors.blue,
                  backgroundColor: Colors.grey.shade200,
                ),
              ),
              const Text("50%",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
