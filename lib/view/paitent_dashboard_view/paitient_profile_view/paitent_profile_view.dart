// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:restaurent_discount_app/common%20controller/custom%20alert%20dialog/custom_alert_dialog.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/settings_view.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/supply_order_history.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/widget/profile_option_widget.dart';
import 'package:restaurent_discount_app/view/paitent_dashboard_view/paitient_profile_view/track_medical_information_view.dart';

import '../../nurse_dashboard/profile_view/change_password_view.dart';
import '../../nurse_dashboard/profile_view/edit_profile.dart';
import '../auth_view/sign_in_view/sign_in_view.dart';

class PaitientProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(leading: Container(), title: "Profile"),
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
                  child: CustomText(
                    text: 'Anna Sulaiya',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),

                ProfileOption(
                  icon: Icons.person_3_outlined,
                  title: 'Edit Profile',
                  onTap: () {
                    Get.to(() => EditProfile());
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

                ProfileOption(
                  icon: Icons.medical_information_outlined,
                  title: 'Track Medical Information',
                  onTap: () {
                    Get.to(() => TrackMedicalInformationView());
                  },
                ),

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
                  color: Colors.red,
                  icon: Icons.logout,
                  title: 'Log Out',
                  onTap: () {
                    CustomAlertDialog.showCustomDialog(

                        title: "Logout",
                        content:
                            "If you want to logout your account click on yes",
                        cancelName: "No",
                        actionName: "Yes",
                        confirmText: "Yes",
                        onConfirm: () {
                          Get.offAll(() => SignInView());
                        });
                  },
                ),
              ],
            ),
          )),
    );
  }
}
