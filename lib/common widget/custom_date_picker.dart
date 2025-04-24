// ignore_for_file: prefer_const_constructors_in_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart'; // To format the selected date

class CustomDatePicker extends StatefulWidget {
  final Function(String) onDateSelected;
  final Color color;

  CustomDatePicker({required this.onDateSelected, required this.color});

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  String? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          DateTime? selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );

          if (selectedDate != null) {
            String formattedDate =
                DateFormat('MM-dd-yyyy').format(selectedDate);
            setState(() {
              _selectedDate = formattedDate;
            });
            widget.onDateSelected(formattedDate);
          }
        },
        child: Container(
          width: 150,
          height: 43.h,
          child: Center(
            child: CustomText(
              textAlign: TextAlign.center,
              text: _selectedDate ?? "Select Date",
              fontSize: 13.h,
              color: Colors.black.withOpacity(0.7),
            ),
          ),
          decoration: BoxDecoration(
              color: widget.color, borderRadius: BorderRadius.circular(10)),
        ));
  }
}
