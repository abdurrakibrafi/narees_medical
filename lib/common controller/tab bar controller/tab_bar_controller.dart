import 'package:get/get.dart';

class TabBarController extends GetxController {
  var selectedItemIndex = 0.obs;

  void selectItem(int index) {
    selectedItemIndex.value = index;
  }

  List<Map<String, dynamic>> filterItemsByStatus(List<Map<String, dynamic>> items, String status) {

      return items.where((item) => item['status'] == status).toList();
    }

}
