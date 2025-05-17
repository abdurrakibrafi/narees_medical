import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
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
    _controller.getMyOrders(); // Call API on init
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Supply Order History"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 40.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0071BC), Color(0xFF003456)],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Products',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15.h,
                    ),
                    CustomText(
                      text: 'Quantity',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15.h,
                    ),
                    CustomText(
                      text: 'Status',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15.h,
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            Expanded(
              child: Obx(() {
                if (_controller.isLoading.value) {
                  return Center(child: CustomLoader());
                }

                final orders = _controller.cartData.value.data ?? [];

                if (orders.isEmpty) {
                  return Center(child: Text("No supply orders found."));
                }

                return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    final firstItem = order.orderItems.isNotEmpty
                        ? order.orderItems[0]
                        : null;

                    return OrderCard(
                      productName:
                          firstItem?.product?.name ?? "Unknown Product",
                      company: firstItem?.product?.supplierName ??
                          "Unknown Supplier",
                      quantity: firstItem?.quantity ?? 0,
                      status: order.status ?? "Unknown",
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
