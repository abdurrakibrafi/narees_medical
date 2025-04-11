import 'package:get/get.dart';

class DropdownController extends GetxController {
  var isDropdownOpen = false.obs;
  var selectedPerson = 'Number of Person'.obs;

  void toggleDropdown() {
    isDropdownOpen.value = !isDropdownOpen.value;
  }

  void selectPerson(String person) {
    selectedPerson.value = person;
    toggleDropdown();
  }
}
