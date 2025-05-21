// today_appointment_widget.dart
// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import 'package:shimmer/shimmer.dart';

class TodayAppointmentWidget extends StatefulWidget {
  final String patientName;
  final String treatmentType;
  final String timeAndLocation;
  final DateTime date;

  const TodayAppointmentWidget({
    super.key,
    required this.patientName,
    required this.treatmentType,
    required this.timeAndLocation,
    required this.date,
  });

  factory TodayAppointmentWidget.shimmer() {
    return TodayAppointmentWidget._shimmer();
  }

  TodayAppointmentWidget._shimmer()
      : patientName = '',
        treatmentType = '',
        timeAndLocation = '',
        date = DateTime.now(),
        super(key: UniqueKey());

  @override
  State<TodayAppointmentWidget> createState() => _TodayAppointmentWidgetState();
}

class _TodayAppointmentWidgetState extends State<TodayAppointmentWidget> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    if (widget.patientName.isEmpty) {
      Timer(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    } else {
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // Shimmer effect placeholder
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 24, width: 150, color: Colors.white),
              SizedBox(height: 8),
              Container(height: 18, width: 220, color: Colors.white),
              SizedBox(height: 16),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // After shimmer off, show real data
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF0071BC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: widget.patientName,
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          CustomText(
            text: 'Treatment Type: ${widget.treatmentType}',
            color: Colors.white,
            fontSize: 16.h,
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFF519ed1),
            ),
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  CustomText(
                    text:
                        '${_formatTime(widget.date)}, ${widget.timeAndLocation}',
                    color: Colors.white,
                    fontSize: 12.h,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime date) {
    final hour = date.hour > 12
        ? date.hour - 12
        : date.hour == 0
            ? 12
            : date.hour;
    final ampm = date.hour >= 12 ? 'PM' : 'AM';
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute $ampm';
  }
}
