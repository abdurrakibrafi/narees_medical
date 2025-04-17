// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';

class HomeViewForNurse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                shape: BoxShape.circle,
                color: Colors.white, // Border color
              ),
              child: ClipOval(
                child: Image.network(
                  "https://media.istockphoto.com/id/1329569957/photo/happy-young-female-doctor-looking-at-camera.jpg?s=612x612&w=0&k=20&c=7Wq_Y2cl0T4op6Wg_3DFc-xtZfCqTTDvfaXkPGyrHDM=",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 8),
            CustomText(text: 'Hello Samantha 👋', fontSize: 15.h,fontWeight: FontWeight.bold,),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Supplies Button
              Container(
                margin: EdgeInsets.only(bottom: 16),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'ORDER SUPPLIES',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),

              // Appointment Section
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Appointment Today',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.person, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'John Doe',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Treatment Type: Hydration Therapy',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          '10:00 AM, March 6, 2025 / 2/A. Florida, USA',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Marketing Material Section
              SizedBox(height: 24),
              Text(
                'Marketing Material',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/marketing_image.jpg',
                        height: 180, width: double.infinity, fit: BoxFit.cover),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Revitalize your body with a premium IV hydration session! 💧\n\nFeeling tired or dehydrated? Our mobile IV therapy comes to you! Book with me today for a quick energy boost. #MobileIV #VitaMedics',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                      ),
                      child: Text(
                        '2 days ago',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
