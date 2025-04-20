// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';

class NotificationPage extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'title':
          'Dear Aria, Your Order is Confirmed by Admin. Once it will available, you can track your delivery status.',
      'time': 'Fri, 12:30pm',
      'url': '',
    },
    {
      'title':
          'Dear Aria, Your Order is Confirmed by Admin. Once it will available, you can track your delivery status.',
      'time': 'Fri, 12:30pm',
      'url': '',
    },
    {
      'title': 'Dear Aria, Track your supply order: "https://www.usps.com/"',
      'time': 'Fri, 12:30pm',
      'url': 'https://www.usps.com/',
    },
    {
      'title': 'Dear Aria, Track your supply order: "https://www.usps.com/"',
      'time': 'Fri, 12:30pm',
      'url': 'https://www.usps.com/',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Notification"),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return NotificationCard(notification: notification);
        },
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final Map<String, String> notification;

  const NotificationCard({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              Icons.notifications,
              color: Colors.blue,
              size: 30,
            ),
            SizedBox(width: 12),
            // Notification Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    textAlign: TextAlign.start,
                    text: notification['title']!,
                    fontSize: 14.h,
                    fontWeight: FontWeight.w500,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  CustomText(
                    text: notification['time']!,
                    fontSize: 14.h,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
            if (notification['url'] != null && notification['url']!.isNotEmpty)
              IconButton(
                icon: Icon(Icons.open_in_new, color: Colors.blue),
                onPressed: () {
                  // Open the URL in browser
                  print("Opening URL: ${notification['url']}");
                  // You can use url_launcher to open the URL
                },
              ),
          ],
        ),
      ),
    );
  }
}
