// ignore_for_file: prefer_final_fields, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/nurse_home_view/nurse_home_view.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/profile_view/profile_view.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
    HomeViewForNurse(),
    HomeViewForNurse(),
    HomeViewForNurse(),
    HomeViewForNurse(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
          selectedLabelStyle: GoogleFonts.abhayaLibre(color: AppColors.mainColor,fontSize: 14.h),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          iconSize: 22,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon:
                  Image(image: AssetImage("assets/images/Home.png"), width: 23,),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory),
              label: 'Inventory',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.note),
              label: 'Notes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_add),
              label: 'Add User',
            ),
            BottomNavigationBarItem(
              icon: Image(
                  image: AssetImage("assets/images/profile-add.png"),
                  width: 23),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
