import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final List<Map<String, String>> foodItems = [
  {
    'foodImage': 'assets/images/dosha.jpg',
    'foodName': 'Masala Dosa',
    'review': '4.5'
  },
  {
    'foodImage': 'assets/images/burger.jpeg',
    'foodName': 'Burger Tikka',
    'review': '4.7'
  },
  {
    'foodImage': 'assets/images/biryani.jpg',
    'foodName': 'Biryani',
    'review': '4.6'
  },
];


class EmailValidator {
  static bool isValid(String email) {
    final RegExp regex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      caseSensitive: false,
      multiLine: false,
    );
    return regex.hasMatch(email);
  }
}

class AppPadding {
  static EdgeInsets bodyPadding = EdgeInsets.fromLTRB(13.h, 0, 13.h, 0);
}


final List<Map<String, String>> restaurantData = [
  {
    'image': 'assets/images/resturent.jpg',
    'name': 'Blue Anchor',
    'distance': '1.5 km',
    'location': 'City Center',
  },
  {
    'image': 'assets/images/resturent1.jpg',
    'name': 'Take It Cheesy',
    'distance': '2.2 km',
    'location': 'Suburb Area',
  },
  {
    'image': 'assets/images/resturent2.jpg',
    'name': 'Lettuce Eat Bistro',
    'distance': '3.0 km',
    'location': 'Downtown',
  },
  {
    'image': 'assets/images/resturent.jpg',
    'name': 'Fauna Kitchen',
    'distance': '1.5 km',
    'location': 'City Center',
  },
];

