// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common widget/custom text/custom_text_widget.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const CourseCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F8FD),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 36, color: Colors.blue),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  textAlign: TextAlign.start,
                  fontWeight: FontWeight.bold,
                  text: title,
                  fontSize: 13),
              CustomText(

                  text: value, fontSize: 25, fontWeight: FontWeight.bold),
            ],
          ),
        ],
      ),
    );
  }
}
