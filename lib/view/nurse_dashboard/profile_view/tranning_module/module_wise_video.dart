// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/uitilies/custom_loader.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/tranning_module/widget/lessonCard_widget.dart';
import '../../../../common widget/custom text/custom_text_widget.dart';
import 'controller/all_modules_controller_get.dart';
import 'model/modules_model.dart';

class ModuleWiseVideo extends StatefulWidget {
  const ModuleWiseVideo({super.key});

  @override
  State<ModuleWiseVideo> createState() => _ModuleWiseVideoState();
}

class _ModuleWiseVideoState extends State<ModuleWiseVideo> {
  int? _expandedIndex;

  final AllModulesControllerGet _controller =
      Get.put(AllModulesControllerGet());

  // ✅ Progress %
  int get _progressPercent {
    final data = _controller.module.value.data;
    if (data != null && data.isNotEmpty) {
      return data.first.progressPercent ?? 0;
    }
    return 0;
  }

  // ✅ 🔥 FIXED: ALL modules (not only first)
  List<Module> get _modules {
    final data = _controller.module.value.data;

    if (data != null && data.isNotEmpty) {
      final modules =
          data.expand<Module>((e) => e.trainingModule?.modules ?? []).toList();

      modules.sort((a, b) => (a.serial ?? 0).compareTo(b.serial ?? 0));

      return modules;
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      // ───────────── APP BAR ─────────────
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_circle_left_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: CustomText(
          text: "Course Modules",
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),

        // ───────── HEADER ─────────
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Obx(() => Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _statChip(
                          Icons.play_lesson_rounded,
                          '${_modules.length} Lessons',
                        ),
                        const SizedBox(width: 10),
                        _statChip(Icons.timer_outlined, 'Self-paced'),
                        const SizedBox(width: 10),
                        _statChip(
                          Icons.bar_chart_rounded,
                          '$_progressPercent% Done',
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: _progressPercent / 100,
                        minHeight: 5,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          const Color(0xFF185FA5),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),

      // ───────────── BODY ─────────────
      body: Obx(() {
        if (_controller.isLoading.value) {
          return Center(child: CustomLoader());
        }

        if (_modules.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.video_library_outlined,
                    size: 48, color: Colors.grey.shade400),
                const SizedBox(height: 12),
                Text(
                  'No lessons available',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _controller.module.value.data?.length ?? 0,
          itemBuilder: (context, courseIndex) {
            final courseData = _controller.module.value.data![courseIndex];

            final modules = courseData.trainingModule?.modules ?? [];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ Course Title
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    courseData.trainingModule?.courseName ?? '',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),

                // ✅ Modules List
                ...List.generate(modules.length, (index) {
                  final module = modules[index];
                  final globalIndex = "$courseIndex-$index";

                  final isExpanded = _expandedIndex == globalIndex.hashCode;

                  final isUnlocked = module.progresses.isNotEmpty
                      ? (module.progresses.first.isUnlocked ?? false)
                      : index == 0;

                  return LessonCard(
                    module: module,
                    isExpanded: isExpanded,
                    isUnlocked: isUnlocked,
                    onTap: () {
                      if (!isUnlocked) {
                        Get.snackbar(
                          'Locked',
                          'Complete previous lesson first',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.black87,
                          colorText: Colors.white,
                        );
                        return;
                      }

                      setState(() {
                        _expandedIndex =
                            isExpanded ? null : globalIndex.hashCode;
                      });
                    },
                  );
                }),

                const SizedBox(height: 10),
              ],
            );
          },
        );
      }),
    );
  }

  // ───────── STAT CHIP ─────────
  Widget _statChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF185FA5).withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 13, color: const Color(0xFF185FA5)),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: Color(0xFF185FA5)),
          ),
        ],
      ),
    );
  }
}
