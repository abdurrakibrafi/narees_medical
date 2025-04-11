import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIconWithBg extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;
  const CustomIconWithBg({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(100)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image(
            image: AssetImage(icon),
            width: 30.w,
          ),
        ),
      ),
    );
  }
}
