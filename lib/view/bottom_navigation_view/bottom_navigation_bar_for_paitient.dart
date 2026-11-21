// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'package:flutter/material.dart';
import 'app_bottom_nav_bar.dart';
import '../paitent_dashboard_view/appointment_of_patient_view/appointment_of_view.dart';
import '../paitent_dashboard_view/home_view/paitent_home_view.dart';
import '../paitent_dashboard_view/inventory_list_view/inventory_list_view.dart';
import '../paitent_dashboard_view/nusrse_application_list/nurse_application_list.dart';
import '../paitent_dashboard_view/paitient_profile_view/paitent_profile_view.dart';
import '../paitent_dashboard_view/search_view/nurse_search_view.dart';

class BottomNavigationBarForPaitient extends StatefulWidget {
  const BottomNavigationBarForPaitient({super.key});

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigationBarForPaitient> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
    HomeViewForPaitinet(),
    NurseRequestView(),
    AppoinmentViewOfPatient(),
    // NurseSearchView(),
    PaitientProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          AppNavItem(label: 'Home', asset: 'assets/images/Home.png'),
          AppNavItem(label: 'Requests', asset: 'assets/images/layer.png'),
          AppNavItem(label: 'Appointment', asset: 'assets/images/stickynote.png'),
          AppNavItem(label: 'Profile', asset: 'assets/images/profile-add.png'),
        ],
      ),
    );
  }
}
