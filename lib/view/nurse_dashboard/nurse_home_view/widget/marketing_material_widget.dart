// ignore_for_file: prefer_const_constructors, use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';

import '../../../../common widget/chached_network_image.dart';

class MarketingMaterialCard extends StatelessWidget {
  final String desc;
  final String tag;
  final String image;
  final DateTime? createdAt;

  const MarketingMaterialCard({
    Key? key,
    required this.desc,
    required this.tag,
    required this.image,
    this.createdAt,
  }) : super(key: key);

  String getTimeAgo(DateTime? date) {
    if (date == null) return '';
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 1) return '${difference.inDays} days ago';
    if (difference.inDays == 1) return '1 day ago';
    if (difference.inHours >= 1) return '${difference.inHours} hours ago';
    if (difference.inMinutes >= 1) return '${difference.inMinutes} minutes ago';
    return 'Just now';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomText(
                textAlign: TextAlign.start,
                text: desc,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomText(
                textAlign: TextAlign.start,
                text: tag.split(', ').map((t) => '#$t').join(' '),
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: AppColors.mainColor,
              ),
            ),
            // Image section with overlay
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(12)),
                  ),
                  child: ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(12)),
                      child: CustomCachedImage(
                        imageUrl: image,
                      )),
                ),
                Positioned(
                  bottom: 0,
                  left: 1,
                  right: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      color: Colors.black.withOpacity(0.4),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: CustomText(
                            text: getTimeAgo(createdAt),
                            fontWeight: FontWeight.bold,
                            fontSize: 14.h,
                            color: Colors.white,
                          ),
                        ),
                        // Share button
                        Container(
                          padding: EdgeInsets.all(10),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white),
                            child: Image.asset(
                              "assets/images/Vector.png",
                              width: 28,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
