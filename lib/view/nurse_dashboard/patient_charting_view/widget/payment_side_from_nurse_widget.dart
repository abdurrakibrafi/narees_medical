// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20controller/custom%20alert%20dialog/custom_alert_dialog.dart';
import 'package:restaurent_discount_app/common%20widget/custom_success_alert_dialog.dart';
import 'package:restaurent_discount_app/common%20widget/row_wise_widget.dart';
import 'package:restaurent_discount_app/uitilies/constant.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../common widget/custom_button_widget.dart';
import '../../../../common widget/custom_dropdown_controller.dart';
import '../../../../common widget/custom_text_filed.dart';

class PaymentSideFromNurseWidget extends StatelessWidget {
  const PaymentSideFromNurseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: AppPadding.bodyPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            CustomText(
              fontWeight: FontWeight.bold,
              text: "Payment Information",
              fontSize: 18.h,
            ),
            SizedBox(height: 10),
            CustomTextField(
              maxLines: 1,
              fillColor: Color(0xFFE4E4E4),
              borderColor: Colors.transparent,
              hintText: "Total Ammount",
              showObscure: false,
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: CustomDropdown(
                label: 'Select Payment Method',
                hint: 'Select Method',
                value: 'Credit',
                items: ['Debit', 'Credit'],
                onChanged: (value) {
                  print(value);
                },
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 55,
              width: double.infinity,
              child: CustomButtonWidget(
                gradient: LinearGradient(
                    colors: [Color(0xFF0071BC), Color(0xFF003456)],
                    begin: Alignment.topLeft,
                    end: Alignment.topRight),
                btnText: "Submit",
                onTap: () {
                  CustomSuccessAlertDialog.showCustomDialog(
                      customWidgets: [
                        RowWiseWidget(
                            title: "Transaction ID", subTitle: "#TXN20250307"),
                        RowWiseWidget(title: "Date", subTitle: "03-03-24"),
                        RowWiseWidget(
                            title: "Procedure Performed",
                            subTitle: "#TXN20250307"),
                        RowWiseWidget(
                            title: "Payment Method", subTitle: "Credit"),
                        RowWiseWidget(title: "Processed by", subTitle: "Rafi"),
                      ],
                      title: "Payment ",
                      content: "",
                      onConfirm: () {},
                      btnText: 'Go to home');
                },
                iconWant: false,
              ),
            ),
          ],
        ));
  }
}
