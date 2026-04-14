// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:restaurent_discount_app/common widget/custom text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common widget/not_found_widget.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';
import 'package:restaurent_discount_app/uitilies/custom_loader.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/tranning_module/model/modules_model.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/tranning_module/widget/tranning_module_enrol_popup.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/widget/certification_card_widget.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/widget/module_card_widget.dart';

import 'controller/all_modules_controller_get.dart';
import 'controller/course_list_controller.dart';
import 'controller/enroll_course_controller.dart';
import 'model/course_list_model.dart';
import 'module_wise_video.dart';

class TrainingAndCertificationPage extends StatelessWidget {
  TrainingAndCertificationPage({super.key});

  final CourseListController _controller =
  Get.put(CourseListController());

  final EnrollCourseController _enrollCourseController =
  Get.put(EnrollCourseController());

  final AllModulesControllerGet _allModulesControllerGet =
  Get.put(AllModulesControllerGet());

  List<CourseList> get _courses {
    return _controller.course.value.data ?? [];
  }

  // ✅ FIX: OPEN CERTIFICATE FUNCTION
  Future<void> openCertificate(String? url) async {
    if (url == null || url.isEmpty) {
      Get.snackbar(
        "Error",
        "Certificate not available",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final Uri uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      Get.snackbar(
        "Error",
        "Could not open certificate",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,

        // ───────── APP BAR ─────────
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: CustomText(
            text: 'Training & Certification',
            fontSize: 14.h,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_circle_left_rounded),
            onPressed: () => Navigator.pop(context),
          ),
          bottom: TabBar(
            indicatorColor: AppColors.mainColor,
            labelStyle:
            GoogleFonts.abhayaLibre(fontSize: 11.h),
            tabs: [
              Tab(text: 'Courses'),
              Tab(text: 'Certificate'),
            ],
          ),
        ),

        // ───────── BODY ─────────
        body: TabBarView(
          children: [

            // ================= COURSES =================
            Obx(() {
              if (_controller.isLoading.value) {
                return Center(child: CustomLoader());
              }

              if (_courses.isEmpty) {
                return NotFoundWidget(
                    message: "No Courses Available!");
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
                            moduleName:
                            course.courseName ??
                                'not available',
                            totalLessons:
                            '${course.count?.modules ?? 0} Lessons',
                            onTap: () {
                              _enrollCourseController
                                  .addCourseEnroll(
                                  courseId:
                                  course.id.toString());
                              Get.back();
                            },
                          );
                        }
                      },
                      moduleName:
                      course.courseName ?? 'not available',
                      totalLessons:
                      '${course.count?.modules ?? 0} Lessons',
                    );
                  },
                ),
              );
            }),

            // ================= CERTIFICATES =================
            Obx(() {
              if (_allModulesControllerGet.isLoading.value) {
                return Center(child: CustomLoader());
              }

              final List<ModuleData> data =
                  _allModulesControllerGet
                      .module.value.data ??
                      [];

              if (data.isEmpty) {
                return NotFoundWidget(
                    message:
                    "No Certificate Available!");
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final moduleData = data[index];
                  final training =
                      moduleData.trainingModule;

                  return Padding(
                    padding:
                    const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap: () {
                        // 🔥 OPEN CERTIFICATE
                        openCertificate(
                            training?.certificateUrl);
                      },
                      child: CertificateCard(
                        certificateName:
                        training?.courseName ??
                            'No Certificate Name',
                        fileSize: "PDF File",
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}