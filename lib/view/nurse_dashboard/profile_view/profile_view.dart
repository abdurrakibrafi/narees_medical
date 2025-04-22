// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/payment_receipts_view.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/settings_view.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/supply_order_history.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/tranning_and_certification_view.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/widget/profile_option_widget.dart';

import 'change_password_view.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Profile"),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-photo/black-nurse-their-workspace_52683-100571.jpg?semt=ais_hybrid&w=740'),
                  ),
                ),
                SizedBox(height: 16),
                // Profile Name
                Center(
                  child: Text(
                    'Anna Sulaiya',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                ProfileOption(
                  icon: Icons.person_3_outlined,
                  title: 'Edit Profile',
                  onTap: () {},
                ),

                Divider(),

                // Training & Certification
                ProfileOption(
                  icon: Icons.school,
                  title: 'Training & Certification',
                  onTap: () {
                    Get.to(()=> TrainingAndCertificationPage());
                  },
                ),

                // Divider
                Divider(),

                ProfileOption(
                  icon: Icons.history,
                  title: 'Supply Order History',
                  onTap: () {
                    Get.to(() => SupplyOrderHistoryPage());
                  },
                ),

                // Divider
                Divider(),

                // Payment Receipts
                ProfileOption(
                  icon: Icons.receipt,
                  title: 'Payment Receipts',
                  onTap: () {
                    Get.to(() => PaymentReceiptsPage());
                  },
                ),

                // Divider
                Divider(),

                // Message
                ProfileOption(
                  icon: Icons.message,
                  title: 'Message',
                  onTap: () {},
                ),

                // Divider
                Divider(),

                // Change Password
                ProfileOption(
                  icon: Icons.lock,
                  title: 'Change Password',
                  onTap: () {
                    Get.to(() => ChangePasswordView());
                  },
                ),

                // Divider
                Divider(),

                // Settings
                ProfileOption(
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: () {
                    Get.to(() => SettingsView());
                  },
                ),

                // Divider
                Divider(),

                // Log Out
                ProfileOption(
                  icon: Icons.logout,
                  title: 'Log Out',
                  onTap: () {
                    // Implement Log Out functionality
                  },
                ),
              ],
            ),
          )),
    );
  }
}
