// patient_charting_view.dart

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';
import 'package:restaurent_discount_app/uitilies/constant.dart';
import 'package:restaurent_discount_app/uitilies/custom_loader.dart';
import 'package:restaurent_discount_app/view/chat_with_nurse_patient.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/patient_charting_view/widget/patient_charting_card_view.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import 'controller/add_patient_charting_via_webview.dart';
import 'controller/patient_charting_controller.dart';

class PatientChartingView extends StatefulWidget {
  const PatientChartingView({super.key});

  @override
  State<PatientChartingView> createState() => _PatientChartingViewState();
}

class _PatientChartingViewState extends State<PatientChartingView> {
  late final PatientChartingController _controller;

  final AddPatientChartingViaWebview _addPatientChartingViaWebview =
      AddPatientChartingViaWebview();

  @override
  void initState() {
    super.initState();
    // ✅ initState e controller initialize + fresh API call
    _controller = Get.put(PatientChartingController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.getPatientCharting();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(leading: Container(), title: "Patient Charting"),
      body: Padding(
        padding: AppPadding.bodyPadding,
        child: Column(
          children: [
            SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (_controller.isLoading.value) {
                  return Center(child: CustomLoader());
                }

                final list = _controller.patientChartingData.value.data ?? [];

                if (list.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage(
                              "assets/images/no-date-calendar_78370-7221.avif"),
                          width: 120,
                        ),
                        SizedBox(height: 10),
                        CustomText(
                          text: "No patient charting found.",
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  color: AppColors.mainColor,
                  onRefresh: () async {
                    await _controller.getPatientCharting();
                  },
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final item = list[index];
                      final appointment = item.appointment;

                      return PatientChartingCard(
                        patientName:
                            '${appointment?.firstName ?? ''} ${appointment?.lastName ?? ''}'
                                .trim(),
                        treatmentType: appointment?.treatmentType ?? 'n/a',
                        city: appointment?.cityRef?.name.toString() ?? 'n/a',
                        date: appointment?.date != null
                            ? '${appointment!.date!.day}/${appointment.date!.month}/${appointment.date!.year}'
                            : '',
                        time: appointment?.date != null
                            ? TimeOfDay.fromDateTime(appointment!.date!)
                                .format(context)
                            : '',
                        status: item.status ?? '',
                        accepted: item.status?.toLowerCase() == 'accepted',

                        // ✅ Patient info
                        patientPhone:
                            appointment?.patient?.fullname.toString() ?? '',
                        patientEmail:
                            appointment?.patient?.email.toString() ?? '',
                        patientImageUrl:
                            appointment?.patient?.profilePicture ?? '',
                        onTap: () {
                          _addPatientChartingViaWebview.addPatientCharting(
                              appointmentId: appointment?.id ?? '');
                        },
                        messageOnTap: () {
                          Get.to(() => ChatDetailsPage(
                                name:
                                    '${appointment?.firstName ?? ''} ${appointment?.lastName ?? ''}'
                                        .trim(),
                              ));
                        },
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
