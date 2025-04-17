// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';

class MarketingMaterialCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: 10),child: Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomText(
              textAlign: TextAlign.start,
              text:
              'Revitalize your body with a premium IV hydration session! 💧\nFeeling tired or dehydrated? Our mobile IV therapy comes to you! Book with me today for a quick energy boost.\n#MobileIV #VitaMedics"',
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.black87,
            ),
          ),

          // Image section with overlay
          Stack(
            children: [
              // Image section
              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(12)),
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRleWSzsHCA4WdEGSP6rjoBbdBo8wcJ9jkwWutmrFFCj2DgI0RFUnQ9QbQ558uy_wyjavc&usqp=CAU',
                    ),
                    fit: BoxFit.cover,
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
                      // Post time
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: CustomText(
                          text: '2 days ago',
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
    ));
  }
}
