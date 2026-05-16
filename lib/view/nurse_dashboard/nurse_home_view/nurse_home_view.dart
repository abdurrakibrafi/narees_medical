// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/uitilies/custom_loader.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/nurse_home_view/widget/app_bar_widget_of_nurse.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/nurse_home_view/widget/marketing_material_widget.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/nurse_home_view/widget/nurse_interested_dialog_box.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/nurse_home_view/widget/today_appointment_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

import '../appointment_view/controller/get_nurse_appoitment_controller.dart';
import 'controller/marketing_material_controller.dart';
import '../../../common widget/row_wise_widget.dart';
import '../../../common widget/not_found_widget.dart';
import 'controller/nurse_interest_controller.dart';

class HomeViewForNurse extends StatefulWidget {
  @override
  State<HomeViewForNurse> createState() => _HomeViewForNurseState();
}

class _HomeViewForNurseState extends State<HomeViewForNurse> {
  final MarketingMaterialController controller =
      Get.put(MarketingMaterialController());

  final GetNurseAppointment appointmentController =
      Get.put(GetNurseAppointment());

  final AppointmentInterestController _appointmentInterestController =
      Get.put(AppointmentInterestController());

  @override
  void initState() {
    super.initState();

    final today = DateTime.now();
    final formattedDate = "${today.year.toString().padLeft(4, '0')}-"
        "${today.month.toString().padLeft(2, '0')}-"
        "${today.day.toString().padLeft(2, '0')}";

    controller.getMaterial();
    appointmentController.getNurseAppointment(date: formattedDate);
  }

  Widget _buildShimmerItem() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(height: 150, color: Colors.white),
            SizedBox(height: 10),
            Container(height: 14, color: Colors.white),
            SizedBox(height: 8),
            Container(height: 12, width: 100, color: Colors.white),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBarForHome(),
        body: Padding(
          padding: EdgeInsets.all(6),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: RowWiseWidget(
                    title: 'Appointment',
                    subTitle: '',
                  ),
                ),
              ),

              Obx(() {
                if (appointmentController.isLoading.value) {
                  return SliverToBoxAdapter(
                    child: Center(child: CustomLoader()),
                  );
                }

                final appointments =
                    appointmentController.nurseData.value.data ?? [];

                if (appointments.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(
                        child: Column(
                      children: [
                        Image(
                          image: AssetImage(
                              "assets/images/no-date-calendar_78370-7221.avif"),
                          width: 120,
                        ),
                        CustomText(
                          text: "Sorry, no appointments found for now",
                        )
                      ],
                    )),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final appointment = appointments[index];
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: TodayAppointmentWidget(
                          onInterested: () => showInterestConfirmationDialog(
                            context: context,
                            onConfirmed: () async {
                              _appointmentInterestController
                                  .appointmentInterest(
                                appointmentId: appointment.id.toString(),
                              );

                              Get.back();
                            },
                          ),
                          patientName:
                              '${appointment.firstName ?? ''} ${appointment.lastName ?? ''}',
                          treatmentType: appointment.treatmentType ?? '',
                          timeAndLocation: appointment.zipCode ?? '',
                          date: appointment.date ?? DateTime.now(),
                          city: "City : ${appointment.cityRef?.name ?? 'n/a'}",
                        ),
                      );
                    },
                    childCount: appointments.length,
                  ),
                );
              }),

              /// 🔹 Marketing Material Title
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: RowWiseWidget(
                    title: 'Marketing Material',
                    subTitle: '',
                  ),
                ),
              ),

              /// 🔹 Marketing Material List
              Obx(() {
                if (controller.isLoading.value) {
                  return SliverToBoxAdapter(
                    child: Column(
                      children: List.generate(3, (_) => _buildShimmerItem()),
                    ),
                  );
                }

                final data = controller.cartData.value.data?.data ?? [];

                if (data.isEmpty) {
                  return SliverToBoxAdapter(
                    child:
                        NotFoundWidget(message: "No Marketing Material Found"),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = data[index];

                      return MarketingMaterialCard(
                        createdAt: item.createdAt,
                        desc: item.content ?? '',
                        tag: item.tags.isNotEmpty
                            ? item.tags.map((e) => '#$e').join(' ')
                            : '',
                        image: item.marketingMaterialDocument.isNotEmpty
                            ? item.marketingMaterialDocument[0].url ?? ''
                            : '',
                        onTap: () async {
                          final title = item.tags.isNotEmpty
                              ? item.tags.map((e) => '#$e').join(' ')
                              : 'Check this out';

                          String shareText = "$title\n\n${item.content ?? ''}";

                          if (item.marketingMaterialDocument.isNotEmpty) {
                            final imageUrl =
                                item.marketingMaterialDocument[0].url ?? '';
                            if (imageUrl.isNotEmpty) {
                              shareText += "\n\n$imageUrl";
                            }
                          }

                          await Share.share(shareText);
                        },
                      );
                    },
                    childCount: data.length,
                  ),
                );
              }),
            ],
          ),
        ));
  }
}
