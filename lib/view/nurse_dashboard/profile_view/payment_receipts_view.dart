// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/common%20widget/not_found_widget.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/widget/payment_reciet_card_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';

import 'controller/get_payment_receipts_controller.dart';

class PaymentReceiptsPage extends StatefulWidget {
  @override
  State<PaymentReceiptsPage> createState() => _PaymentReceiptsPageState();
}

class _PaymentReceiptsPageState extends State<PaymentReceiptsPage> {
  final ReceiptController _receiptController = Get.put(ReceiptController());

  @override
  void initState() {
    super.initState();
    _receiptController.getReceipt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Payment Receipts"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (_receiptController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          final receipts = _receiptController.cartData.value.data ?? [];

          if (receipts.isEmpty) {
            return Center(
                child: NotFoundWidget(message: "No Payment Receipts found"));
          }

          return ListView.builder(
            itemCount: receipts.length,
            itemBuilder: (context, index) {
              final receipt = receipts[index];
              final patientName = receipt.userId ?? "Unknown";
              final treatmentType = receipt.orderItems.isNotEmpty
                  ? receipt.orderItems[0].product?.name ?? "N/A"
                  : "N/A";
              final amount = receipt.payment?.amount != null
                  ? "\$${receipt.payment!.amount!.toStringAsFixed(2)}"
                  : "N/A";
              final date = receipt.createdAt != null
                  ? "${receipt.createdAt!.day}/${receipt.createdAt!.month}/${receipt.createdAt!.year}"
                  : "N/A";
              final receiptUrl = receipt.payment?.receptUrl;

              return PaymentReceiptCard(
                patientName: patientName,
                treatmentType: treatmentType,
                amount: amount,
                date: date,
                onDownloadPressed: () async {
                  print("=================$receiptUrl");

                  if (receiptUrl != null) {
                    final uri = Uri.parse(receiptUrl);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    } else {
                      Get.snackbar(
                        "Error",
                        "Could not launch receipt URL",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  } else {
                    Get.snackbar(
                      "Error",
                      "Receipt URL not available or invalid",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                showBtn: receipt.payment?.status == "PAID" ? true : false,
              );
            },
          );
        }),
      ),
    );
  }
}
