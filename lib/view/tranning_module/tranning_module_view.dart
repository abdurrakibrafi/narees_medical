// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/view/tranning_module/widget/course_card_widget.dart';
import 'package:restaurent_discount_app/view/tranning_module/widget/tranning_module_card_widget.dart';

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
                        icon: "assets/images/availabele.png")),
                SizedBox(width: 16),
                Expanded(
                    child: CourseCard(
                        title: "Completed\nCourses",
                        value: "10",
                        icon: "assets/images/complete.png")),
              ],
            ),
            const SizedBox(height: 24),
            CustomText(
              text: "Training Module Course",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 16),
             Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TrainingModuleCard(
                        title: "Hydration Therapy Basics",
                        lessons: "21/24 Lesson"),
                    TrainingModuleCard(
                        title: "IV Insertion Techniques",
                        lessons: "21/24 Lesson"),
                    TrainingModuleCard(
                        title: "Emergency Protocols in IV Therapy",
                        lessons: "21/24 Lesson"),
                    TrainingModuleCard(
                        title: "Infection Control in IV Therapy",
                        lessons: "21/24 Lesson"),
                    TrainingModuleCard(
                        title: "Infection Control in IV Therapy",
                        lessons: "21/24 Lesson"),
                    TrainingModuleCard(
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


