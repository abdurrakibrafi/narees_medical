import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/uitilies/custom_loader.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/widget/order_card_widget.dart';
import 'controller/get_supply_order_controller.dart';

class SupplyOrderHistoryPage extends StatefulWidget {
  @override
  State<SupplyOrderHistoryPage> createState() => _SupplyOrderHistoryPageState();
}

class _SupplyOrderHistoryPageState extends State<SupplyOrderHistoryPage> {
  final GetSupplyOrderController _controller =
      Get.put(GetSupplyOrderController());

  @override
  void initState() {
    super.initState();
    _controller.getMyOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Supply Order History"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (_controller.isLoading.value) {
            return Center(child: CustomLoader());
          }

          final orders = _controller.cartData.value.data ?? [];

          if (orders.isEmpty) {
            return Center(
              child: Text(
                "No supply orders found.",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return OrderCard(order: order);
            },
          );
        }),
      ),
    );
  }
}
