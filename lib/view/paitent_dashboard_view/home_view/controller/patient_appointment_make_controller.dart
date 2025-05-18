import 'dart:convert';
import 'package:restaurent_discount_app/common%20widget/success_full_page_view.dart';
import 'package:restaurent_discount_app/uitilies/api/base_client.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/view/paitent_dashboard_view/home_view/paitent_home_view.dart';
import '../../../../uitilies/custom_toast.dart';
import 'package:restaurent_discount_app/uitilies/api/api_url.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/cart_view/cart_view.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/cart_view/controller/cart_get_controller.dart';

import '../../../bottom_navigation_view/bottom_navigation_bar_for_paitient.dart';

class AppointmentMakeController extends GetxController {
  var isLoading = false.obs;

  final CartGetController _controller = Get.put(CartGetController());

  Future<void> addProductToCart({
    required String firstName,
    required String lastName,
    required String treatmentType,
    required String phoneNumber,
    required String reason,
    required String date,
    required String location,
    required bool reminder,
    required String zipCode,
  }) async {
    isLoading(true);

    Map<String, dynamic> body = {
      "firstName": firstName,
      "lastName": lastName,
      "treatmentType": treatmentType,
      "phoneNumber": phoneNumber,
      "isRemainder": reminder,
      "reason": reason,
      "date": date,
      "location": location,
      "zipCode": zipCode
    };

    try {
      var response = await BaseClient.postRequest(
        api: ApiUrl.appointmentCreate,
        body: body,
      );

      if (response.statusCode == 200) {
        CustomToast.showToast("Appointment Create  successfully",
            isError: false);

        Get.to(() => SuccesfullyPageForAll(
            title: "Successfully",
            subTitle: "Appointment Create  successfully",
            onTap: () {
              Get.offAll(() => BottomNavigationBarForPaitient());
            }));
      } else {
        throw 'Failed to add product to cart: ${response.body}';
      }
    } catch (e) {
      print("Error occurred while adding product to cart: $e");
    } finally {
      isLoading(false);
    }
  }
}
