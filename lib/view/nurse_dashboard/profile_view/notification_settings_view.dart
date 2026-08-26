// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';

class NotificationSettingsView extends StatefulWidget {
  const NotificationSettingsView({super.key});

  @override
  State<NotificationSettingsView> createState() =>
      _NotificationSettingsViewState();
}

class _NotificationSettingsViewState extends State<NotificationSettingsView> {
  // নোটিফিকেশন স্ট্যাটাস সেভ করার জন্য ভেরিয়েবল
  bool _isNotificationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Notification Settings"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Stay connected with your patients. Turn on notifications so you don’t miss new messages, appointment updates, or important VitaMedics alerts.",
              style: TextStyle(
                fontFamily: 'Sanchez',
                fontSize: 16,
                color: Colors.grey,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: SwitchListTile(
                title: const Text(
                  "Push Notifications",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Sanchez',
                  ),
                ),
                subtitle: Text(
                  style: TextStyle(
                    fontFamily: 'Sanchez',
                  ),
                  _isNotificationEnabled ? "Enabled" : "Disabled",
                ),
                value: _isNotificationEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _isNotificationEnabled = value;
                  });
                  // এখানে আপনি SharedPreferences বা API কল করতে পারেন ডাটা সেভ করার জন্য
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
