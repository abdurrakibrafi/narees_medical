import 'package:flutter/material.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/patient_charting_view/widget/patient_charting_card_view.dart';

class PatientChartingView extends StatelessWidget {
  const PatientChartingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(leading: Container(), title: "Patient Charting"),
      body: Column(
        children: [
          Expanded(child:
              ListView.builder(itemBuilder: (BuildContext context, index) {
            return PatientChartingCard();
          }))
        ],
      ),
    );
  }
}
