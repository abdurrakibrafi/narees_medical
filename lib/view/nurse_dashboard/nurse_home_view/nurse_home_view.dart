// home_view_for_nurse.dart
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/not_found_widget.dart';
import 'package:restaurent_discount_app/uitilies/constant.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/appointment_view/controller/get_nurse_appoitment_controller.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/nurse_home_view/widget/app_bar_widget_of_nurse.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/nurse_home_view/widget/marketing_material_widget.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/nurse_home_view/widget/today_appointment_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import '../../../common widget/row_wise_widget.dart';
import 'controller/marketing_material_controller.dart';

class HomeViewForNurse extends StatefulWidget {
  @override
  State<HomeViewForNurse> createState() => _HomeViewForNurseState();
}

class _HomeViewForNurseState extends State<HomeViewForNurse> {
  final MarketingMaterialController controller =
      Get.put(MarketingMaterialController());

  final GetNurseAppointment _getNurseAppointment =
      Get.put(GetNurseAppointment());

  @override
  void initState() {
    super.initState();

    final today = DateTime.now();
    final formattedDate =
        "${today.year.toString().padLeft(4, '0')}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

    controller.getMaterial();
    _getNurseAppointment.getNurseAppointment(date: formattedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarForHome(),
      body: SingleChildScrollView(
        padding: AppPadding.bodyPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RowWiseWidget(
              title: 'Appointment Today',
              subTitle: 'See All',
            ),
            SizedBox(height: 10),
            Obx(() {
              if (_getNurseAppointment.isLoading.value) {
                return TodayAppointmentWidget.shimmer();
              }
              if (_getNurseAppointment.nurseData.value.data == null ||
                  _getNurseAppointment.nurseData.value.data!.data.isEmpty) {
                return NotFoundWidget(message: "No Appointment Today");
              }

              final appointment =
                  _getNurseAppointment.nurseData.value.data!.data.first;

              return TodayAppointmentWidget(
                patientName:
                    "${appointment.firstName ?? ''} ${appointment.lastName ?? ''}",
                treatmentType: appointment.treatmentType ?? '',
                timeAndLocation:
                    "${_formatDate(appointment.date)} / ${appointment.location ?? ''}",
                date: appointment.date ?? DateTime.now(),
              );
            }),
            SizedBox(height: 24),
            RowWiseWidget(
              title: 'Marketing Material',
              subTitle: 'See All',
            ),
            SizedBox(height: 8),
            Obx(() {
              if (controller.isLoading.value) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: MarketingMaterialCard(
                        desc: ' ',
                        tag: ' ',
                        image: '',
                        onTap: () {},
                      ),
                    );
                  },
                );
              }

              if (controller.cartData.value.data == null ||
                  controller.cartData.value.data!.data.isEmpty) {
                return NotFoundWidget(message: "No Marketing Material Found");
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.cartData.value.data!.data.length,
                itemBuilder: (context, index) {
                  final marketItem =
                      controller.cartData.value.data!.data[index];

                  return MarketingMaterialCard(
                    createdAt: marketItem.createdAt,
                    desc: marketItem.content ?? '',
                    tag: marketItem.tags.isNotEmpty
                        ? marketItem.tags.map((tag) => '#$tag').join(' ')
                        : '',
                    image: marketItem.marketingMaterialDocument.isNotEmpty
                        ? marketItem.marketingMaterialDocument[0].url ?? ''
                        : '',
                    onTap: () async {
                      final title = marketItem.tags.isNotEmpty
                          ? marketItem.tags.map((tag) => '#$tag').join(' ')
                          : 'Check this out';

                      final content = marketItem.content ?? '';

                      final imageUrl = marketItem
                              .marketingMaterialDocument.isNotEmpty
                          ? marketItem.marketingMaterialDocument[0].url ?? ''
                          : '';

                      String shareText = "$title\n\n$content";

                      if (imageUrl.isNotEmpty) {
                        shareText += "\n\n$imageUrl";
                      }

                      await Share.share(shareText);
                    },
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
}
