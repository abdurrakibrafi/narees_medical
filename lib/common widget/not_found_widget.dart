import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';

class NotFoundWidget extends StatelessWidget {
  final String message;
  final String buttonText;
  final VoidCallback? onButtonPressed;

  const NotFoundWidget({
    Key? key,
    this.buttonText = "Retry",
    this.onButtonPressed, required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 150),
          Icon(
            Icons.search_off,
            size: 50.h,
            color: Colors.grey,
          ),
          SizedBox(height: 6.h),
          CustomText(
            text: message,
            textAlign: TextAlign.center,
            fontSize: 22.sp,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
