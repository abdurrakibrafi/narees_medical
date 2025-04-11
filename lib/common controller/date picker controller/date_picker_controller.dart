import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';

class DateController extends GetxController {
  var selectedDate = 'Date'.obs;

  void pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.mainColor, // Header background color
              onPrimary: Colors.white, // Header text color
              surface: AppColors.mainColor, // Background color
              onSurface: Colors.white, // Text color
            ),
            dialogBackgroundColor: Colors.blue[50],
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      selectedDate.value =
          '${pickedDate.day}-${pickedDate.month}-${pickedDate.year}';
    }
  }
}
