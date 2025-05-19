import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/appointment_model.dart';

class AllNurseController extends GetxController {
  var isLoading = false.obs;
  var nurseData = AppointmentModel().obs;

  @override
  void onInit() {
    super.onInit();
    getMyAppointment();
  }

  getMyAppointment({dynamic date}) async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: ApiUrl.getMyAppointment(date: date)),
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
