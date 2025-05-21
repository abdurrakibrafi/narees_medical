// ignore_for_file: avoid_print

import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../../../paitent_dashboard_view/appointment_of_patient_view/model/appointment_model.dart';

class GetNurseAppointment extends GetxController {
  var isLoading = false.obs;
  var nurseData = AppointmentModel().obs;

  @override
  void onInit() {
    super.onInit();
    getNurseAppointment();
  }

  getNurseAppointment({dynamic date}) async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: ApiUrl.getNurseAppointment(date: date)),
      );

      if (responseBody != null) {
        nurseData.value = AppointmentModel.fromJson(responseBody);
      } else {
        throw 'Failed to fetch cart data!';
      }
    } catch (e) {
      print("Error occurred: $e");
    } finally {
      isLoading(false);
    }
  }
}
