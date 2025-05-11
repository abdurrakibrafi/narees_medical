// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/inventory_list_view/inventory_list_view.dart';
import '../paitent_dashboard_view/appointment_of_patient_view/appointment_of_view.dart';
import '../paitent_dashboard_view/home_view/paitent_home_view.dart';
import '../paitent_dashboard_view/paitient_profile_view/paitent_profile_view.dart';
import '../paitent_dashboard_view/search_view/nurse_search_view.dart';

class BottomNavigationBarForPaitient extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigationBarForPaitient> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
    HomeViewForPaitinet(),
    InventoryList(),
    AppoinmentViewOfPatient(),
    NurseSearchView(),
    PaitientProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildImageIcon(String assetPath, bool isSelected) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        isSelected ? AppColors.mainColor : Colors.black.withOpacity(0.4),
        BlendMode.srcIn,
      ),
      child: Image.asset(
        assetPath,
        width: 23,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(45),
        child: BottomNavigationBar(
          selectedItemColor: AppColors.mainColor,
          unselectedLabelStyle: GoogleFonts.abhayaLibre(fontSize: 12.h),
          backgroundColor: Colors.white,
          selectedLabelStyle: GoogleFonts.abhayaLibre(
              color: AppColors.mainColor, fontSize: 14.h),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          iconSize: 22,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: _buildImageIcon(
                  "assets/images/Home.png", _selectedIndex == 0),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _buildImageIcon(
                  "assets/images/layer.png", _selectedIndex == 1),
              label: 'Inventory',
            ),
            BottomNavigationBarItem(
              icon: _buildImageIcon(
                  "assets/images/stickynote.png", _selectedIndex == 2),
              label: 'Appointment',
            ),
            BottomNavigationBarItem(
              icon: _buildImageIcon(
                  "assets/images/search.png", _selectedIndex == 3),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: _buildImageIcon(
                  "assets/images/profile-add.png", _selectedIndex == 4),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
