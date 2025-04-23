// ignore_for_file: prefer_const_constructors_in_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            onTimeSelected(formattedTime); // Call the callback
          }
        },
        child: Container(
          height: 35.h,
          child: Center(
            child: Text(
                textAlign: TextAlign.center, _selectedDate ?? "Select Time"),
          ),
          decoration: BoxDecoration(
              color: widget.color, borderRadius: BorderRadius.circular(10)),
        ));
  }
}
