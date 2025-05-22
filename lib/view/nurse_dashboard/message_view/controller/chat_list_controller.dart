// ignore_for_file: avoid_print

import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/chat_list_model.dart';

class GetChatListController extends GetxController {
  var isLoading = false.obs;
  var nurseData = ChatListModel().obs;

  @override
  void onInit() {
    super.onInit();
    getChatList();
  }

  getChatList() async {
    try {
      isLoading(true);

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(api: ApiUrl.chatList),
      );

      if (responseBody != null) {
        nurseData.value = ChatListModel.fromJson(responseBody);
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
