// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';
import 'package:restaurent_discount_app/uitilies/custom_loader.dart';
import 'package:restaurent_discount_app/view/paitent_dashboard_view/inventory_list_view/widget/inventory_card_widget.dart';
import 'controller/inverntory_product_controller.dart';

class InventoryList extends StatefulWidget {
  @override
  _InventoryListState createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryList> {
  final GetAllInverntoryController controller =
      Get.put(GetAllInverntoryController());

  @override
  void initState() {
    super.initState();
    controller.getInventory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        leading: Container(),
        title: "Inventory List",
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search here....',
                hintStyle: GoogleFonts.abhayaLibre(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: AppColors.mainColor),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
                suffixIcon: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.mainColor),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            Obx(() {
              if (controller.isLoading.value) {
                return Expanded(
                  child: Center(
                    child: CustomLoader(),
                  ),
                );
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: controller.inventoryList.length,
                  itemBuilder: (context, index) {
                    var item = controller.inventoryList[index];
                    return InventoryItemCard(
                        item: item);
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
