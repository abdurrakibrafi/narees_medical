// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/common%20widget/not_found_widget.dart';
import 'package:restaurent_discount_app/uitilies/custom_loader.dart';
import '../nurse_home_view/controller/delete_all_notification_controller.dart';
import '../nurse_home_view/controller/notification_controller.dart';
import '../nurse_home_view/model/notification_model.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final GetNotificationController _notificationController =
      Get.put(GetNotificationController());

  final DeleteNotificationController _deleteNotificationController =
      Get.put(DeleteNotificationController());

  @override
  void initState() {
    super.initState();
    _notificationController.getNotify();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Notification", actions: [
        IconButton(
          icon: Icon(
            Icons.delete_outline,
            color: Colors.red,
            size: 30,
          ),
          onPressed: () {
            _deleteNotificationController.deleteNotification();
          },
        ),
        SizedBox(width: 10),
      ]),
      body: Obx(() {
        if (_notificationController.isLoading.value) {
          return Center(child: CustomLoader());
        }

        final notifications =
            _notificationController.nurseData.value.data?.data ?? [];

        if (notifications.isEmpty) {
          return Center(
              child: NotFoundWidget(message: "No notifications available."));
        }

        return ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return NotificationCard(notification: notification);
          },
        );
      }),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final NotificationData notification;

  const NotificationCard({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
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
                  Text(
                    notification.title ?? '',
                    style: TextStyle(
                      fontSize: 14.h,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Text(
                    notification.createdAt != null
                        ? _formatDateTime(notification.createdAt!)
                        : '',
                    style: TextStyle(
                      fontSize: 14.h,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    // Format the date to your desired string, e.g. "May 19, 2025 14:35"
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
  }
}
