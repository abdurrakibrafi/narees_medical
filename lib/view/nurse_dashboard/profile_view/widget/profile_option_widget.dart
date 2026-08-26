// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? color;

  const ProfileOption({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
     this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: color ?? AppColors.mainColor.withOpacity(0.8),
              size: 23,
            ),
            SizedBox(width: 16),
            Expanded(
              child: CustomText(
                fontFamily: 'Sanchez',
                textAlign: TextAlign.start,
                text: title,
                fontSize: 14,
                color: color ?? Colors.black,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 21,
            ),
          ],
        ),
      ),
    );
  }
}
