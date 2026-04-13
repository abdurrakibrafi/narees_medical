// ignore_for_file: prefer_const_constructors, use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/html_view.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';

import '../../../../common widget/chached_network_image.dart';

class MarketingMaterialCard extends StatefulWidget {
  final String desc;
  final String tag;
  final String image;
  final VoidCallback onTap;
  final DateTime? createdAt;

  const MarketingMaterialCard({
    Key? key,
    required this.desc,
    required this.tag,
    required this.image,
    this.createdAt,
    required this.onTap,
  }) : super(key: key);

  @override
  State<MarketingMaterialCard> createState() => _MarketingMaterialCardState();
}

class _MarketingMaterialCardState extends State<MarketingMaterialCard> {
  bool _isExpanded = false;

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
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 32, // adjust padding
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HTML View with See More / See Less
                // HTML View with See More / See Less
                AnimatedCrossFade(
                  firstChild: SizedBox(
                    height: 80,
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.transparent],
                          stops: [0.5, 1.0],
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.dstIn,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: HTMLView(htmlData: widget.desc),
                      ),
                    ),
                  ),
                  secondChild: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: HTMLView(htmlData: widget.desc),
                  ),
                  crossFadeState: _isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: Duration(milliseconds: 300),
                ),

                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 4),
                    child: CustomText(
                      text: _isExpanded ? 'See Less' : 'See More',
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),

                // Tags
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomText(
                    textAlign: TextAlign.start,
                    text: widget.tag.split(', ').map((t) => '#$t').join(' '),
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
                          imageUrl: widget.image,
                        ),
                      ),
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
                                text: getTimeAgo(widget.createdAt),
                                fontWeight: FontWeight.bold,
                                fontSize: 14.h,
                                color: Colors.white,
                              ),
                            ),
                            GestureDetector(
                              onTap: widget.onTap,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.white,
                                  ),
                                  child: Image.asset(
                                    "assets/images/Vector.png",
                                    width: 28,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
