import 'package:get/get.dart';

class CountdownController extends GetxController {
  // Timer countdown value
  RxInt countdown = 45.obs;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  Future<void> startTimer() async {
    countdown.value = 45;
    while (countdown.value > 0) {
      await Future.delayed(Duration(seconds: 1));
      countdown.value--;
      update();
    }
  }

  String get formattedTime {
    int minutes = countdown.value ~/ 60;
    int seconds = countdown.value % 60;
    return '${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}';
  }
}
