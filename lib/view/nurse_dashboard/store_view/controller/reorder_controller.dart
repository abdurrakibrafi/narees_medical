import 'package:get/get.dart';
import 'package:restaurent_discount_app/uitilies/api/api_url.dart';
import 'package:restaurent_discount_app/uitilies/api/base_client.dart';
import 'package:restaurent_discount_app/uitilies/custom_toast.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/cart_view/cart_view.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/cart_view/controller/cart_get_controller.dart';

import '../../profile_view/model/supply_order_model_history.dart';

/// Puts every item of a past supply order back into the cart in one request
/// (the cart/add endpoint accepts a list) and opens the cart.
class ReorderController extends GetxController {
  /// Id of the order currently being re-added, so only its button spins.
  final reorderingId = RxnString();

  Future<void> reorder(Order order) async {
    if (reorderingId.value != null) return;

    final items = order.orderItems
        .where((i) => (i.productId ?? i.product?.id) != null && (i.quantity ?? 0) > 0)
        .map((i) => {
              'productId': (i.productId ?? i.product!.id).toString(),
              'quantity': i.quantity,
            })
        .toList();

    if (items.isEmpty) {
      CustomToast.showToast('This order has no items to reorder', isError: true);
      return;
    }

    reorderingId.value = order.id ?? '';
    try {
      final response =
          await BaseClient.postRequest(api: ApiUrl.cartAdd, body: items);

      if (response.statusCode == 200 || response.statusCode == 201) {
        CustomToast.showToast('Items added to your cart', isError: false);
        Get.put(CartGetController()).getCart();
        Get.to(() => CartPage());
      } else {
        CustomToast.showToast('Could not reorder. Please try again.',
            isError: true);
      }
    } catch (e) {
      CustomToast.showToast('Could not reorder. Please try again.',
          isError: true);
    } finally {
      reorderingId.value = null;
    }
  }
}
