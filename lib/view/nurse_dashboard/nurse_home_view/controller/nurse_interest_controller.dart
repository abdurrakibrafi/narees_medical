import 'package:get/get.dart';
import 'package:restaurent_discount_app/uitilies/custom_toast.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/appointment_view/controller/get_nurse_appoitment_controller.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';

class AppointmentInterestController extends GetxController {
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  final GetNurseAppointment appointmentController =
      Get.put(GetNurseAppointment());
  appointmentInterest({
    required String appointmentId,
  }) async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
            api: ApiUrl.appointmentInterest(appointmentId: appointmentId),
            body: {}),
      );

      if (responseBody != null && responseBody['success'] == true) {
        CustomToast.showToast(responseBody['message']);
        appointmentController.getNurseAppointment();
      } else {
        throw 'Failed to fetch Stripe connect URL!';
      }
    } catch (e) {
      print("Error occurred: $e");
    } finally {
      isLoading(false);
    }
  }
}
