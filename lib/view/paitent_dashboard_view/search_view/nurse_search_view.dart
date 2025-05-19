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
import 'package:restaurent_discount_app/uitilies/custom_toast.dart';
import 'package:restaurent_discount_app/view/bottom_navigation_view/bottom_navigation_bar_for_paitient.dart';
import 'package:restaurent_discount_app/view/paitent_dashboard_view/home_view/paitent_home_view.dart';
import 'package:restaurent_discount_app/view/paitent_dashboard_view/search_view/controller/all_nurse_controller.dart';

import 'nurse_card_widget/nurse_card_widget.dart';

class NurseSearchView extends StatefulWidget {
  const NurseSearchView({Key? key}) : super(key: key);

  @override
  State<NurseSearchView> createState() => _NurseSearchViewState();
}

class _NurseSearchViewState extends State<NurseSearchView> {
  final AllNurseController _allNurseController = Get.put(AllNurseController());
  final TextEditingController _searchController = TextEditingController();

  // Make sure this list is typed correctly, assuming your nurse model type is dynamic here:
  List<dynamic> _filteredNurses = [];

  @override
  void initState() {
    super.initState();
    _allNurseController.getNurse();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();

    if (query.isEmpty) {
      setState(() {
        _filteredNurses = _allNurseController.nurseData.value.data ?? [];
      });
    } else {
      setState(() {
        _filteredNurses = (_allNurseController.nurseData.value.data ?? [])
            .where(
                (nurse) => (nurse.fullname ?? "").toLowerCase().contains(query))
            .toList();
      });
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Nurse Search",
        leading: Container(),
      ),
      body: Padding(
        padding: AppPadding.bodyPadding,
        child: Column(
          children: [
            SizedBox(height: 20),
            TextField(
              controller: _searchController,
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

                // Use filtered list if search text is not empty, else full list
                final List<dynamic> displayList = _searchController.text.isEmpty
                    ? (_allNurseController.nurseData.value.data ?? [])
                    : _filteredNurses;

                if (displayList.isEmpty) {
                  return Center(
                      child: NotFoundWidget(message: "No Nurse Found"));
                }

                return ListView.builder(
                  itemCount: displayList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final nurse = displayList[index];

                    // Explicitly cast the specialty split list to List<String>
                    List<String> servicesList = [];
                    if (nurse.specialty != null && nurse.specialty is String) {
                      servicesList = (nurse.specialty as String)
                          .split(',')
                          .map((e) => e.trim())
                          .toList();
                    }

                    return NurseCardWidget(
                      nurseName: nurse.fullname ?? "N/A",
                      profileImageUrl: nurse.profilePicture ??
                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
                      services: servicesList,
                      availability: nurse.location.toString(),
                      onTap: () {
                        CustomSuccessAlertDialog.showCustomDialog(
                            title: "Great",
                            content:
                                "Thanks for selecting the nurse,please now fill the appointment",
                            onConfirm: () {
                              Get.offAll(() => HomeViewForPaitinet(
                                    nurseId: nurse.id,
                                  ));

                              CustomToast.showToast(
                                  "Now please fill up the below appointment form.",
                                  isError: false);
                            },
                            btnText: 'Appointment');
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
