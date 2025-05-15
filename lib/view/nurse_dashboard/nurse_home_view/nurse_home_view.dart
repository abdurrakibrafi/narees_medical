// home_view_for_nurse.dart
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/not_found_widget.dart';
import 'package:restaurent_discount_app/uitilies/constant.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/nurse_home_view/widget/app_bar_widget_of_nurse.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/nurse_home_view/widget/marketing_material_widget.dart';
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

  @override
  void initState() {
    super.initState();
    controller.getMaterial(); // Reload data each time this widget is created
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
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF0071BC),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "John Date",
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    text: 'Treatment Type: Hydration Therapy',
                    color: Colors.white,
                    fontSize: 16.h,
                  ),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF519ed1),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time,
                          ),
                          SizedBox(width: 8),
                          CustomText(
                            text: '10:00 AM, March 6, 2025 / 2/A. Florida, USA',
                            color: Colors.black,
                            fontSize: 12.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
