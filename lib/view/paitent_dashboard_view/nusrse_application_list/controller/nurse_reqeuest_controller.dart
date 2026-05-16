import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../../../nurse_dashboard/patient_charting_view/model/patient_charting_model.dart'; // reuse same model

class NurseAppointmentRequestController extends GetxController {
  var isLoading = false.obs;
  var requestedData = <PatientCharting>[].obs; // PatientCharting is your item model

  @override
  void onInit() {
    super.onInit();
    getNurseRequests();
  }

  getNurseRequests() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: ApiUrl.patientChartingGet()),
      );

      if (responseBody != null) {
        PatientChartingModel result = PatientChartingModel.fromJson(responseBody);
        requestedData.value = result.data ?? [];
      } else {
        throw 'Failed to fetch nurse requests!';
      }
    } catch (e) {
      print("Error occurred: $e");
    } finally {
      isLoading(false);
    }
  }
}