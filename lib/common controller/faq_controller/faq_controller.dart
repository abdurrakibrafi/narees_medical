import 'package:get/get.dart';

class FaqController extends GetxController {
  var faqItems = <FaqItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFaqItems();
  }

  void loadFaqItems() {
    faqItems.addAll([
      FaqItem(
          question: "Question number:1",
          answer:
              "Navigate to the  section on the main menu. You'll see a list of available discounts and promotions from various restaurants. You can also use the search bar to find offers by restaurant name or cuisine type."),
      FaqItem(
          question: "Question number:2",
          answer: "Navigate to the  section on the main menu."),
      FaqItem(
          question: "Question number:3",
          answer: "Navigate to the  section on the main menu."),
    ]);
  }

  void toggleFaqItem(int index) {
    faqItems[index].isExpanded = !faqItems[index].isExpanded;
    faqItems.refresh();
  }
}

class FaqItem {
  String question;
  String answer;
  bool isExpanded;

  FaqItem(
      {required this.question, required this.answer, this.isExpanded = false});
}
