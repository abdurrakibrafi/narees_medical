// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/nurse_home_view/widget/app_bar_widget_of_nurse.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/nurse_home_view/widget/marketing_material_widget.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/nurse_home_view/widget/today_appointment_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

import '../appointment_view/controller/get_nurse_appoitment_controller.dart';
import 'controller/marketing_material_controller.dart';
import '../../../common widget/row_wise_widget.dart';
import '../../../common widget/not_found_widget.dart';

class HomeViewForNurse extends StatefulWidget {
  @override
  State<HomeViewForNurse> createState() => _HomeViewForNurseState();
}

class _HomeViewForNurseState extends State<HomeViewForNurse> {
  final MarketingMaterialController controller =
      Get.put(MarketingMaterialController());

  final GetNurseAppointment appointmentController =
      Get.put(GetNurseAppointment());

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
      body: CustomScrollView(
        slivers: [
          /// 🔹 Appointment Section
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: RowWiseWidget(
                title: 'Appointment',
                subTitle: 'See All',
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: TodayAppointmentWidget(
                    patientName: "Demo Patient",
                    treatmentType: "Treatment",
                    timeAndLocation: "Location",
                    date: DateTime.now(),
                  ),
                );
              },
              childCount: 5,
            ),
          ),

          /// 🔹 Marketing Material Title
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: RowWiseWidget(
                title: 'Marketing Material',
                subTitle: 'See All',
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
                child: NotFoundWidget(message: "No Marketing Material Found"),
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
    );
  }
}
