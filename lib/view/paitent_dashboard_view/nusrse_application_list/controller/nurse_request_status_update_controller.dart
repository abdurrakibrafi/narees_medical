// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:restaurent_discount_app/uitilies/custom_toast.dart';
import '../../../../common widget/success_full_page_view.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../../../bottom_navigation_view/bottom_navigation_bar_for_paitient.dart';
import 'nurse_reqeuest_controller.dart';

class NurseRequestStatusUpdateController extends GetxController {
  var isLoading = false.obs;

  final NurseAppointmentRequestController _nurseAppointmentRequestController =
      Get.put(NurseAppointmentRequestController());

  @override
  void onInit() {
    super.onInit();
  }

  statusUpdate({
    required String appointmentId,
    required String status,
  }) async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.patchRequest(
          api: ApiUrl.requestUpdate(appointmentId: appointmentId),
          body: {"status": status},
        ),
      );

      if (responseBody != null && responseBody['success'] == true) {
        CustomToast.showToast(responseBody['message']);
        _nurseAppointmentRequestController.getNurseRequests();

        if (status == "ACCEPTED") {
          Get.offAll(() => SuccesfullyPageForAll(
                title: "Appointment Accepted!",
                subTitle:
                    "The appointment has been accepted successfully. The nurse will be notified shortly.",
                onTap: () {
                  Get.offAll(() => BottomNavigationBarForPaitient());
                },
              ));
        } else {
          Get.offAll(() => SuccesfullyPageForAll(
                title: "Appointment Rejected!",
                subTitle:
                    "The appointment has been rejected. The nurse will be notified shortly.",
                onTap: () {
                  Get.offAll(() => BottomNavigationBarForPaitient());
                },
              ));
        }
      } else {
        throw 'Failed to update appointment status!';
      }
    } catch (e) {
      print("Error occurred: $e");
    } finally {
      isLoading(false);
    }
  }
}
