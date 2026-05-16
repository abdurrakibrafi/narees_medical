// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/uitilies/constant.dart';
import 'package:restaurent_discount_app/uitilies/custom_loader.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import 'controller/nurse_reqeuest_controller.dart';
import 'widget/nurse_request_card.dart';

class NurseRequestView extends StatelessWidget {
  NurseRequestView({super.key});

  final NurseAppointmentRequestController _nurseAppointmentRequestController =
      Get.put(NurseAppointmentRequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        leading: Container(),
        title: "Appointment Requests",
      ),
      body: Padding(
        padding: AppPadding.bodyPadding,
        child: Column(
          children: [
            SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (_nurseAppointmentRequestController.isLoading.value) {
                  return Center(child: CustomLoader());
                }

                final list = _nurseAppointmentRequestController.requestedData;

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
                          text: "No appointment requests found",
                        )
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final item = list[index];
                    final appointment = item.appointment;

                    // ✅ nurse object from item
                    final nurse = item.nurse;

                    return NurseRequestCard(
                      // ── Patient Info ──
                      patientName:
                          '${appointment?.firstName ?? ''} ${appointment?.lastName ?? ''}'
                              .trim(),
                      treatmentType: appointment?.treatmentType ?? '',
                      city: appointment?.cityRef?.name ??
                          appointment?.zipCode ??
                          '',
                      date: appointment?.date != null
                          ? '${appointment!.date!.day}/${appointment.date!.month}/${appointment.date!.year}'
                          : '',
                      time: appointment?.date != null
                          ? TimeOfDay.fromDateTime(appointment!.date!)
                              .format(context)
                          : '',
                      status: item.status ?? 'Pending',

                      // ── Nurse Info ──
                      nurseName:
                          '${nurse?.firstName ?? ''} ${nurse?.lastName ?? 'n/a'}'
                              .trim(),
                      nurseEmail: nurse?.email ?? 'n/a',
                      nurseSpecialist: nurse?.specialty ?? 'n/a',
                      nurseImageUrl: nurse?.profilePicture ?? 'n/a',

                      // ── Actions ──
                      onAccept: () {
                        // TODO: accept api call
                      },
                      onReject: () {
                        // TODO: reject api call
                      },
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
