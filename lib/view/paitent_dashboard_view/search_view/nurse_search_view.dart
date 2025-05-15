// NurseSearchView.dart
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_success_alert_dialog.dart';
import 'package:restaurent_discount_app/common%20widget/not_found_widget.dart';
import 'package:restaurent_discount_app/uitilies/constant.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';
import 'package:restaurent_discount_app/uitilies/custom_loader.dart';
import 'package:restaurent_discount_app/view/paitent_dashboard_view/search_view/controller/all_nurse_controller.dart';

import 'nurse_card_widget/nurse_card_widget.dart';

class NurseSearchView extends StatefulWidget {
  NurseSearchView({Key? key}) : super(key: key);

  @override
  State<NurseSearchView> createState() => _NurseSearchViewState();
}

class _NurseSearchViewState extends State<NurseSearchView> {
  final AllNurseController _allNurseController = Get.put(AllNurseController());
  List filteredNurses = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ever(_allNurseController.nurseData, (_) {
      if (_allNurseController.nurseData.value.data != null) {
        filteredNurses = List.from(_allNurseController.nurseData.value.data!);
        setState(() {});
      }
    });
  }

  void _filterNurses(String query) {
    final allNurses = _allNurseController.nurseData.value.data ?? [];
    if (query.isEmpty) {
      filteredNurses = List.from(allNurses);
    } else {
      filteredNurses = allNurses.where((nurse) {
        final name = (nurse.fullname ?? '').toLowerCase();
        return name.contains(query.toLowerCase());
      }).toList();
    }
    setState(() {});
  }

  List<String> _parseSpecialty(dynamic specialty) {
    if (specialty == null) return [];
    if (specialty is String) {
      return specialty.split(',').map((e) => e.trim()).toList();
    } else if (specialty is List) {
      return specialty.map((e) => e.toString()).toList();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Search",
        leading: Container(),
      ),
      body: Padding(
        padding: AppPadding.bodyPadding,
        child: Column(
          children: [
            SizedBox(height: 20),
            TextField(
              controller: searchController,
              onChanged: _filterNurses,
              decoration: InputDecoration(
                hintText: 'Search here....',
                hintStyle: GoogleFonts.abhayaLibre(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: AppColors.mainColor),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
                suffixIcon: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.mainColor),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.h),
            Expanded(
              child: Obx(() {
                if (_allNurseController.isLoading.value) {
                  return Center(child: CustomLoader());
                }

                if (filteredNurses.isEmpty) {
                  return Center(
                      child: NotFoundWidget(message: "No Nurse Found"));
                }

                return ListView.builder(
                  itemCount: filteredNurses.length,
                  itemBuilder: (BuildContext context, int index) {
                    final nurse = filteredNurses[index];
                    return NurseCardWidget(
                      nurseName: nurse.fullname ?? "N/A",
                      profileImageUrl: nurse.profilePicture ??
                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                      services: _parseSpecialty(nurse.specialty),
                      availability: nurse.location.toString(),
                      onTap: () {
                        CustomSuccessAlertDialog.showCustomDialog(
                            title: "Success",
                            content:
                                "You have successfully selected nurse. We will let you know when the nurse approve your request.",
                            onConfirm: () {});
                      },
                      email: nurse.email.toString(),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
