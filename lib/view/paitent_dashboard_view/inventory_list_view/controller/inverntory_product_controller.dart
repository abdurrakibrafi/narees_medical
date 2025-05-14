import 'package:get/get.dart';

import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/inventory_product_model.dart';

class GetAllInverntoryController extends GetxController {
  var isLoading = false.obs;
  var isMoreLoading = false.obs;

  var currentPage = 1.obs;
  var hasMorePages = true.obs;

  var inventoryList = <Inventory>[].obs;

  @override
  void onInit() {
    super.onInit();
    getInventory();
  }

  Future<void> getInventory({int page = 1}) async {
    try {
      if (page == 1) {
        isLoading(true);
      } else {
        isMoreLoading(true);
      }

      // Send request and await response
      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.getRequest(
          api: ApiUrl.inventoryForPatient(role: 'PATIENT'),
        ),
      );

      if (responseBody['success'] == true) {
        ProductModel productModel = ProductModel.fromJson(responseBody);

        if (page == 1) {
          inventoryList.clear();
        }

        inventoryList.addAll(productModel.data?.data ?? []);

        currentPage.value = page;
        hasMorePages.value =
            (productModel.data?.meta?.totalPage ?? 0) > currentPage.value;
      } else {
        hasMorePages(false);
        print("Error: ${responseBody['message']}");
      }

      print("Inventory fetched: $inventoryList");
    } catch (e) {
      print('Error occurred: $e');
    } finally {
      isLoading(false);
      isMoreLoading(false);
    }
  }

  void loadNextPage() {
    if (!isMoreLoading.value && hasMorePages.value) {
      getInventory(page: currentPage.value + 1);
    }
  }
}
