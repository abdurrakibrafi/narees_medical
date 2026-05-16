import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/patient_charting_model.dart';

class PatientChartingController extends GetxController {
  var isLoading = false.obs;
  var patientChartingData = PatientChartingModel().obs;

  @override
  void onInit() {
    super.onInit();
    getPatientCharting();
  }

  getPatientCharting() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: ApiUrl.patientChartingGet()),
      );

      if (responseBody != null) {
        patientChartingData.value = PatientChartingModel.fromJson(responseBody);
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
