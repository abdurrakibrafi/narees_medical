// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';

class ChatInputField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool allowImageUpload;
  final bool allowMultipleImages;
  final Function(List<File>)? onImagesSelected; // ✅ নতুন callback

  const ChatInputField({
    Key? key,
    required this.controller,
    required this.onSend,
    this.allowImageUpload = false,
    this.allowMultipleImages = false,
    this.onImagesSelected, // ✅
  }) : super(key: key);

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final ImagePicker _picker = ImagePicker();
  List<File> selectedImages = [];

  Future<void> _pickImages() async {
    if (widget.allowMultipleImages) {
      final List<XFile> picked = await _picker.pickMultiImage();
      if (picked.isNotEmpty) {
        setState(() {
          selectedImages = picked.map((e) => File(e.path)).toList();
        });
        widget.onImagesSelected?.call(selectedImages); // ✅ parent কে জানাও
      }
    } else {
      final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
      if (picked != null) {
        setState(() {
          selectedImages = [File(picked.path)];
        });
        widget.onImagesSelected?.call(selectedImages); // ✅ parent কে জানাও
      }
    }
  }

  void _removeImage(int index) {
    setState(() {
      selectedImages.removeAt(index);
    });
    widget.onImagesSelected?.call(selectedImages); // ✅ remove করলেও parent update
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (selectedImages.isNotEmpty)
          Container(
            height: 90.h,
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: selectedImages.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 8.w),
                      width: 80.w,
                      height: 80.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: FileImage(selectedImages[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 6,
                      child: GestureDetector(
                        onTap: () => _removeImage(index),
                        child: CircleAvatar(
                          radius: 10.r,
                          backgroundColor: Colors.red,
                          child: Icon(Icons.close, size: 12, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

        Padding(
          padding: EdgeInsets.all(10.h),
          child: Row(
            children: [
              if (widget.allowImageUpload) ...[
                GestureDetector(
                  onTap: _pickImages,
                  child: CircleAvatar(
                    radius: 25.r,
                    backgroundColor: AppColors.mainColor,
                    child: Icon(Icons.image, color: Colors.white),
                  ),
                ),
                SizedBox(width: 8.w),
              ],
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    controller: widget.controller,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      hintStyle: GoogleFonts.poppins(
                        color: Colors.white54,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              GestureDetector(
                onTap: widget.onSend,
                child: CircleAvatar(
                  radius: 25.r,
                  backgroundColor: AppColors.mainColor,
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}