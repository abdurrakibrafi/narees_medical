import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';

class ViewAppointmentDetailsWidget extends StatefulWidget {
  final String title;
  final String value;

  const ViewAppointmentDetailsWidget(
      {super.key, required this.title, required this.value});

  @override
  _ViewAppointmentDetailsWidgetState createState() =>
      _ViewAppointmentDetailsWidgetState();
}

class _ViewAppointmentDetailsWidgetState
    extends State<ViewAppointmentDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          textAlign: TextAlign.start,
          text: widget.title,
          fontSize: 17.sp,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
        SizedBox(height: 5.h),
        CustomText(
          textAlign: TextAlign.start,
          text: widget.value,
          fontSize: 16.sp,
          color: Colors.black,
        ),
      ],
    );
  }
}
