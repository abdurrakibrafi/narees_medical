// ignore_for_file: prefer_final_fields, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'app_bottom_nav_bar.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/nurse_home_view/nurse_home_view.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/more_view/more_view.dart';

import '../nurse_dashboard/appointment_view/appointment_view.dart';
import '../nurse_dashboard/patient_charting_view/patient_charting_view.dart';
import '../paitent_dashboard_view/inventory_list_view/inventory_list_view.dart';

class DashboardForNurse extends StatefulWidget {
  @override
  _DashboardForNurseState createState() => _DashboardForNurseState();
}

class _DashboardForNurseState extends State<DashboardForNurse> {
  int _selectedIndex = 0;

  late final List<Widget> _pages = [
    HomeViewForNurse(onOpenAppointments: () => _onItemTapped(2)),
    InventoryList(),
    AppoinmentView(),
    PatientChartingView(),
    MoreView(),
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
      body: _pages[_selectedIndex],
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          AppNavItem(label: 'Home', asset: 'assets/images/Home.png'),
          AppNavItem(label: 'Inventory', asset: 'assets/images/layer.png'),
          AppNavItem(label: 'Appointment', asset: 'assets/images/stickynote.png'),
          AppNavItem(label: 'Patient', asset: 'assets/images/profile-add.png'),
          AppNavItem(label: 'More', icon: Icons.more_horiz_rounded),
        ],
      ),
    );
  }
}
