import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';

class TimeController extends GetxController {
  var selectedTime = 'Schedule Time'.obs;

  void pickTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            timePickerTheme: TimePickerThemeData(
              dialBackgroundColor: AppColors.mainColor, // Dial background color
              hourMinuteTextColor:
                  AppColors.mainColor, // Hour and minute text color
              hourMinuteColor: AppColors.mainColor,
            ),
            dialogBackgroundColor: Colors.white, // Background color
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      final now = DateTime.now();
      final formattedTime = TimeOfDay(
        hour: pickedTime.hour,
        minute: pickedTime.minute,
      ).format(context);

      selectedTime.value = formattedTime;
    }
  }
}
