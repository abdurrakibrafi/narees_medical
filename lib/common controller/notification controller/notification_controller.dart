import 'package:get/get.dart';

class NotificationController extends GetxController {
  RxBool isGeneralSelected = true.obs;
  RxBool isSpecialSelected = false.obs;

  void selectGeneral() {
    isGeneralSelected.value = true;
    isSpecialSelected.value = false;
  }

  void selectSpecial() {
    isGeneralSelected.value = false;
    isSpecialSelected.value = true;
  }
}
