// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/common%20controller/custom%20alert%20dialog/custom_alert_dialog.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/settings_view.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/supply_order_history.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/widget/profile_option_widget.dart';
import 'package:restaurent_discount_app/view/paitent_dashboard_view/paitient_profile_view/track_medical_information_view.dart';

import '../../../common widget/chached_network_image.dart';
import '../../../uitilies/custom_loader.dart';
import '../../nurse_dashboard/profile_view/change_password_view.dart';
import '../../nurse_dashboard/profile_view/controller/get_profile_controller.dart';
import '../../nurse_dashboard/profile_view/edit_profile.dart';
import '../auth_view/sign_in_view/sign_in_view.dart';

class PaitientProfileView extends StatefulWidget {
  @override
  State<PaitientProfileView> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<PaitientProfileView> {
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
                  Get.to(() => EditProfile(
                        spacilizaion: false,
                        docs: false,
                      ));
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
                icon: Icons.medical_information_outlined,
                title: 'Track Medical Information',
                onTap: () {
                  Get.to(() => TrackMedicalInformationView());
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
                color: Colors.red,
                icon: Icons.logout,
                title: 'Log Out',
                onTap: () {
                  CustomAlertDialog.showCustomDialog(
                    title: "Logout",
                    content: "If you want to logout your account click on yes",
                    cancelName: "No",
                    actionName: "Yes",
                    confirmText: "Yes",
                    onConfirm: () {
                      Get.offAll(() => SignInView());
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
