// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Change Password"),
    );
  }
}
