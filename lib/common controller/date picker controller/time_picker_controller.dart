import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddRestaurentController extends GetxController {
  var startTime = Rx<TimeOfDay?>(null);
  var startTimeOne = Rx<TimeOfDay?>(null);
  var endTime = Rx<TimeOfDay?>(null);
  var endTimeOne = Rx<TimeOfDay?>(null);
  Future<void> selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      if (isStartTime) {
        startTime.value = picked;
        startTimeOne.value = picked;
      } else {
        endTime.value = picked;
        endTimeOne.value = picked;
      }
    }
  }
}




class DayPickerController extends GetxController {
  var startDay = ''.obs;
  var endDay = ''.obs;

  Future<void> pickStartDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      startDay.value = DateFormat('EEEE').format(pickedDate);
    }
  }

  Future<void> pickEndDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      endDay.value = DateFormat('EEEE').format(pickedDate);
    }
  }
}

