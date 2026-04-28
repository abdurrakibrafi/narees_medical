// today_appointment_widget.dart
// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../action_button_of_appointment.dart';

class TodayAppointmentWidget extends StatefulWidget {
  final String patientName;
  final String treatmentType;
  final String timeAndLocation;
  final DateTime date;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

  const TodayAppointmentWidget({
    super.key,
    required this.patientName,
    required this.treatmentType,
    required this.timeAndLocation,
    required this.date,
    this.onAccept,
    this.onReject,
  });

  factory TodayAppointmentWidget.shimmer() {
    return TodayAppointmentWidget._shimmer();
  }

  TodayAppointmentWidget._shimmer()
      : patientName = '',
        treatmentType = '',
        timeAndLocation = '',
        date = DateTime.now(),
        onAccept = null,
        onReject = null,
        super(key: UniqueKey());

  @override
  State<TodayAppointmentWidget> createState() => _TodayAppointmentWidgetState();
}

class _TodayAppointmentWidgetState extends State<TodayAppointmentWidget>
    with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    if (widget.patientName.isEmpty) {
      Timer(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          _animationController.forward();
        }
      });
    } else {
      _isLoading = false;
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildShimmer();
    }

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: _buildCard(),
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 16, width: 130, color: Colors.white),
                    SizedBox(height: 6),
                    Container(height: 12, width: 90, color: Colors.white),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF005DA0), Color(0xFF0085D4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Decorative circle top-right
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.07),
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: -10,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: avatar + name/treatment
                Row(
                  children: [
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: widget.patientName,
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(height: 2),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.18),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: CustomText(
                                  text: widget.treatmentType,
                                  color: Colors.white.withOpacity(0.95),
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white.withOpacity(0.12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.access_time_rounded,
                          color: Colors.white, size: 16),
                      SizedBox(width: 8),
                      CustomText(
                        text:
                            '${_formatTime(widget.date)}  •  ${widget.timeAndLocation}',
                        color: Colors.white,
                        fontSize: 11.sp,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 14),

                // Accept / Reject buttons
                Row(
                  children: [
                    Expanded(
                      child: ActionButton(
                        label: 'Reject',
                        icon: Icons.close_rounded,
                        backgroundColor: Colors.white.withOpacity(0.15),
                        borderColor: Colors.white.withOpacity(0.3),
                        textColor: Colors.white,
                        onTap: widget.onReject,
                      ),
                    ),
                    SizedBox(width: 10),
                    // Accept button
                    Expanded(
                      child: ActionButton(
                        label: 'Accept',
                        icon: Icons.check_rounded,
                        backgroundColor: Colors.white,
                        borderColor: Colors.transparent,
                        textColor: Color(0xFF0071BC),
                        onTap: widget.onAccept,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
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
