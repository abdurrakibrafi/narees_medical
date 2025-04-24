// ignore_for_file: prefer_const_constructors_in_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';

class CustomTimePicker extends StatefulWidget {
  final Function(String) onTimeSelected;
  final Color color;

  CustomTimePicker({required this.onTimeSelected, required this.color});

  @override
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  String? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          TimeOfDay? selectedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );

          if (selectedTime != null) {
            String formattedTime = selectedTime.format(context);
            widget.onTimeSelected(formattedTime);
            setState(() {
              _selectedDate = formattedTime;
            });
          }
        },
        child: Container(
          width: 150,
          height: 43.h,
          child: Center(
            child: CustomText(
              textAlign: TextAlign.center,
              fontSize: 13.h,
              text: _selectedDate ?? "Select Time",
              color: Colors.black.withOpacity(0.7),
            ),
          ),
          decoration: BoxDecoration(
              color: widget.color, borderRadius: BorderRadius.circular(10)),
        ));
  }
}
