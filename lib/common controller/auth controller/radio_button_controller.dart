import 'package:get/get.dart';

class RadioController extends GetxController {
  var selectedRadio = 'Details'.obs;

  void setSelectedRadio(String value) {
    selectedRadio.value = value;
  }
}
