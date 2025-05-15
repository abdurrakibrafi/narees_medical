// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_button_widget.dart';
import 'package:restaurent_discount_app/uitilies/constant.dart';
import 'package:restaurent_discount_app/uitilies/custom_loader.dart';
import 'package:restaurent_discount_app/uitilies/custom_toast.dart';
import '../../../common widget/custom_text_filed.dart';
import 'controller/change_password_controller.dart';

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({super.key});

  final TextEditingController oldPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  final ChangePasswordController controller =
      Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(title: "Change Password"),
        body: Padding(
          padding: AppPadding.bodyPadding,
          child: Column(
            children: [
              SizedBox(height: 35.h),
              CustomTextField(
                controller: oldPassController,
                fillColor: Color(0xFFE4E4E4),
                borderColor: Colors.transparent,
                hintText: "Enter current password",
                showObscure: false,
              ),
              SizedBox(height: 15.h),
              CustomTextField(
                controller: newPassController,
                fillColor: Color(0xFFE4E4E4),
                borderColor: Colors.transparent,
                hintText: "Enter new password",
                showObscure: false,
              ),
              SizedBox(height: 15.h),
              CustomTextField(
                controller: confirmPassController,
                fillColor: Color(0xFFE4E4E4),
                borderColor: Colors.transparent,
                hintText: "Enter confirm password",
                showObscure: false,
              ),
              SizedBox(height: 25.h),
              Obx(() {
                return controller.isLoading.value == true
                    ? CustomLoader()
                    : CustomButtonWidget(
                        gradient: LinearGradient(
                            colors: [Color(0xFF0071BC), Color(0xFF003456)],
                            begin: Alignment.topLeft,
                            end: Alignment.topRight),
                        btnText: "Update Password",
                        onTap: () {
                          if (oldPassController.text.isEmpty) {
                            CustomToast.showToast(
                                "Please enter current password",
                                isError: true);
                            return;
                          }
                          if (newPassController.text.isEmpty) {
                            CustomToast.showToast("Please enter new password",
                                isError: true);
                            return;
                          }
                          if (confirmPassController.text.isEmpty) {
                            CustomToast.showToast(
                                "Please enter confirm password",
                                isError: true);
                            return;
                          }
                          if (newPassController.text !=
                              confirmPassController.text) {
                            CustomToast.showToast(
                                'New password and confirm password do not match',
                                isError: true);
                            return;
                          }

                          controller.changePassword(
                              oldPass: oldPassController.text,
                              newPass: newPassController.text);
                        },
                        iconWant: false);
              })
            ],
          ),
        ));
  }
}
