// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/not_found_widget.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';
import 'package:restaurent_discount_app/uitilies/custom_loader.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/tranning_module/widget/tranning_module_enrol_popup.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/widget/certification_card_widget.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/widget/module_card_widget.dart';

import 'controller/course_list_controller.dart';
import 'controller/enroll_course_controller.dart';
import 'model/course_list_model.dart';
import 'module_wise_video.dart';

class TrainingAndCertificationPage extends StatelessWidget {
  final CourseListController _controller = Get.put(CourseListController());

  final EnrollCourseController _enrollCourseController =
      Get.put(EnrollCourseController());

  List<CourseList> get _courses {
    return _controller.course.value.data ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: CustomText(
            text: 'Training & Certification',
            fontSize: 14.h,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_circle_left_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: TabBar(
            indicatorColor: AppColors.mainColor,
            labelStyle: GoogleFonts.abhayaLibre(fontSize: 11.h),
            tabs: [
              Tab(
                text: 'Courses',
              ),
              Tab(text: 'Certificate'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Obx(() {
              if (_controller.isLoading.value) {
                return Center(
                  child: CustomLoader(),
                );
              }

              if (_courses.isEmpty) {
                return NotFoundWidget(message: "No Courses Available!");
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: _courses.length,
                  itemBuilder: (context, index) {
                    final course = _courses[index];

                    return ModuleCard(
                      onTap: () {
                        if (course.isEnrolled == true) {
                          Get.to(() => ModuleWiseVideo());
                        } else {
                          showEnrollDialog(
                            context,
                            moduleName: course.courseName ?? 'not available',
                            totalLessons:
                                '${course.count?.modules ?? 0} Lessons',
                            onTap: () {
                              _enrollCourseController.addCourseEnroll(
                                  courseId: course.id.toString());

                              Get.back();
                            },
                          );
                        }
                      },
                      moduleName: course.courseName ?? 'not available',
                      totalLessons: '${course.count?.modules ?? 0} Lessons',
                    );
                  },
                ),
              );
            }),
            // Certificate Tab
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: 3, // Total number of certificates
                itemBuilder: (context, index) {
                  return CertificateCard(
                    certificateName: 'Hydration Therapy Basics Certificate.pdf',
                    fileSize: '153 Mb',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
