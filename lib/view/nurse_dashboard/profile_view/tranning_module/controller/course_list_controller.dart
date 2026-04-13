import 'package:get/get.dart';
import '../../../../../uitilies/api/api_url.dart';
import '../../../../../uitilies/api/base_client.dart';
import '../model/course_list_model.dart';
import '../model/modules_model.dart';

class CourseListController extends GetxController {
  var isLoading = false.obs;
  var course = CourseListModel().obs;

  @override
  void onInit() {
    super.onInit();
    getCourseList();
  }

  getCourseList() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: ApiUrl.allCourse),
      );

      if (responseBody != null) {
        course.value = CourseListModel.fromJson(responseBody);
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
