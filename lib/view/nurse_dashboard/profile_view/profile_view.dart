// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/common%20widget/chached_network_image.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/uitilies/custom_loader.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/controller/get_profile_controller.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/payment_receipts_view.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/settings_view.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/supply_order_history.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/tranning_and_certification_view.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/widget/profile_option_widget.dart';
import '../../../common controller/custom alert dialog/custom_alert_dialog.dart';
import '../../paitent_dashboard_view/auth_view/sign_in_view/sign_in_view.dart';
import '../message_view/message_view_of_nurse.dart';
import 'change_password_view.dart';
import 'edit_profile.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileGetController _profileGetController;

  @override
  void initState() {
    super.initState();
    _profileGetController = Get.put(ProfileGetController());
    _profileGetController.getProfile();
  }

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
                Obx(() {
                  return _profileGetController.isLoading.value
                      ? CustomLoader()
                      : Column(
                          children: [
                            ClipOval(
                              child: CustomCachedImage(
                                height: 140.0,
                                width: 140.0,
                                imageUrl: _profileGetController
                                        .profile.value.data?.profilePicture
                                        .toString() ??
                                    "",
                              ),
                            ),
                            SizedBox(height: 16),
                            // Profile Name
                            Center(
                              child: CustomText(
                                text: _profileGetController
                                        .profile.value.data?.fullname
                                        .toString() ??
                                    "n/a",
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                }),
                SizedBox(height: 20),
                ProfileOption(
                  icon: Icons.person_3_outlined,
                  title: 'Edit Profile',
                  onTap: () {
                    Get.to(() => EditProfile());
                  },
                ),
                Divider(),
                ProfileOption(
                  icon: Icons.school,
                  title: 'Training & Certification',
                  onTap: () {
                    Get.to(() => TrainingAndCertificationPage());
                  },
                ),
                Divider(),
                ProfileOption(
                  icon: Icons.history,
                  title: 'Supply Order History',
                  onTap: () {
                    Get.to(() => SupplyOrderHistoryPage());
                  },
                ),
                Divider(),
                ProfileOption(
                  icon: Icons.receipt,
                  title: 'Payment Receipts',
                  onTap: () {
                    Get.to(() => PaymentReceiptsPage());
                  },
                ),
                Divider(),
                ProfileOption(
                  icon: Icons.message,
                  title: 'Message',
                  onTap: () {
                    Get.to(() => ChatScreen());
                  },
                ),
                Divider(),
                ProfileOption(
                  icon: Icons.lock,
                  title: 'Change Password',
                  onTap: () {
                    Get.to(() => ChangePasswordView());
                  },
                ),
                Divider(),
                ProfileOption(
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: () {
                    Get.to(() => SettingsView());
                  },
                ),
                Divider(),
                ProfileOption(
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
