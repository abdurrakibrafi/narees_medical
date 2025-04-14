// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/view/tranning_module/module_list_screen.dart';

class TrainingModuleCard extends StatelessWidget {
  final String title;
  final String lessons;

  const TrainingModuleCard({
    required this.title,
    required this.lessons,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: (){
        Get.to(()=> ModuleListScreen());
      },

        child: Container(
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
              CustomText(
                  text: title, fontSize: 17, fontWeight: FontWeight.bold),
              SizedBox(
                height: 4,
              ),
              CustomText(text: lessons, fontSize: 16),
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
              CustomText(
                  text: "50%", fontSize: 12, fontWeight: FontWeight.bold),
            ],
          ),
        ],
      ),
    ));
  }
}
