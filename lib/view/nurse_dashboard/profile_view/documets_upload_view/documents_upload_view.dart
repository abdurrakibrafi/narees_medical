// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';

class DocumentsUploadView extends StatefulWidget {
  const DocumentsUploadView({super.key});

  @override
  State<DocumentsUploadView> createState() => _DocumentsUploadViewState();
}

class _DocumentsUploadViewState extends State<DocumentsUploadView> {
  final Map<int, PlatformFile?> _selectedFiles = {};

  Future<void> _pickDocument(int index) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );

      if (result != null) {
        setState(() {
          _selectedFiles[index] = result.files.first;
        });
      }
    } catch (e) {
      debugPrint("Error picking file: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(
        title: 'Upload Documents',
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUploadSection(
              index: 0,
              title: "Government-Issued Photo ID",
              statusText: "REQUIRED",
              statusColor: Colors.red,
            ),
            SizedBox(height: 20.h),
            _buildUploadSection(
              index: 1,
              title: "State Professional License/Certification",
              statusText: "REQUIRED",
              statusColor: Colors.red,
            ),
            SizedBox(height: 20.h),
            _buildUploadSection(
              index: 2,
              title: "DEA Registration",
              statusText: "If Applicable",
              statusColor: AppColors.orangeColor,
            ),
            SizedBox(height: 20.h),
            _buildUploadSection(
              index: 3,
              title: "Other Document/Certification",
              statusText: "Optional",
              statusColor: Colors.grey,
            ),
            SizedBox(height: 20.h),
            _buildUploadSection(
              index: 4,
              title: "Other Document/Certification",
              statusText: "Optional",
              statusColor: Colors.grey,
            ),
            SizedBox(height: 40.h),
            CustomButtonWidget(
              btnText: 'Submit Documents',
              onTap: () {
                if (_selectedFiles[0] == null || _selectedFiles[1] == null) {
                  Get.snackbar(
                    "Error",
                    "Please upload required documents",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                } else {
                  debugPrint(
                      "Files to upload: ${_selectedFiles.values.map((e) => e?.name).toList()}");
                }
              },
              iconWant: false,
              btnColor: AppColors.mainColor,
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadSection({
    required int index,
    required String title,
    required String statusText,
    required Color statusColor,
  }) {
    final selectedFile = _selectedFiles[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: CustomText(
                text: title,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.left,
              ),
            ),
            CustomText(
              text: " — $statusText",
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: statusColor,
            ),
          ],
        ),
        SizedBox(height: 10.h),
        GestureDetector(
          onTap: () => _pickDocument(index),
          child: DottedBorder(
            color: AppColors.mainColor.withOpacity(0.5),
            strokeWidth: 1.5,
            dashPattern: [6, 3],
            borderType: BorderType.RRect,
            radius: Radius.circular(10.r),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    selectedFile != null
                        ? Icons.check_circle
                        : Icons.cloud_upload_outlined,
                    size: 40.sp,
                    color: selectedFile != null
                        ? Colors.green
                        : AppColors.mainColor,
                  ),
                  SizedBox(height: 8.h),
                  CustomText(
                    text: selectedFile != null
                        ? selectedFile.name
                        : "Tap to upload document",
                    fontSize: 13.sp,
                    color: Colors.black87,
                  ),
                  SizedBox(height: 4.h),
                  CustomText(
                    text: "Supported: JPG, PNG, PDF",
                    fontSize: 11.sp,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
