import 'dart:convert';
import 'package:restaurent_discount_app/uitilies/api/base_client.dart'; // Import BaseClient
import 'package:get/get.dart';
import '../../../../uitilies/custom_toast.dart';
import 'package:restaurent_discount_app/uitilies/api/api_url.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/cart_view/cart_view.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/cart_view/controller/cart_get_controller.dart';

class AddToCartController extends GetxController {
  var isLoading = false.obs;

  final CartGetController _controller = Get.put(CartGetController());

  Future<void> addProductToCart(
      {required String productId, required dynamic quantity}) async {
    isLoading(true);

    List<Map<String, dynamic>> body = [
      {
        "productId": productId.toString(),
        "quantity": quantity,
      }
    ];

    try {
      // Call the postRequest method from BaseClient
      var response = await BaseClient.postRequest(
        api: ApiUrl.cartAdd, // API endpoint for adding a product to the cart
        body: body, // The body of the request is now a map
      );

      // Check the response status code
      if (response.statusCode == 200) {
        // Show success message
        CustomToast.showToast("Product added to cart successfully",
            isError: false);

        // Navigate to the cart page and refresh the cart data
        Get.to(() => CartPage());
        _controller.getCart(); // Refresh the cart data
      } else {
        // If the request fails, throw an error with the response body
        throw 'Failed to add product to cart: ${response.body}';
      }
    } catch (e) {
      // Catch any errors and print them
      print("Error occurred while adding product to cart: $e");
    } finally {
      // Set loading to false after the request is complete
      isLoading(false);
    }
  }
}
