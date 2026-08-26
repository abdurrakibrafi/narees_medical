// today_appointment_widget.dart
// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import 'package:restaurent_discount_app/common%20widget/custom_date_format.dart';

class TodayAppointmentWidget extends StatefulWidget {
  final String patientName;
  final String city;
  final String treatmentType;
  final String timeAndLocation;
  final DateTime date;

  final VoidCallback? onInterested;
  final VoidCallback? onNotInterested;

  final String patientPhone;
  final String patientEmail;
  final String patientImageUrl;

  const TodayAppointmentWidget({
    super.key,
    required this.patientName,
    required this.treatmentType,
    required this.timeAndLocation,
    required this.date,
    required this.city,
    this.onInterested,
    this.onNotInterested,
    this.patientPhone = '',
    this.patientEmail = '',
    this.patientImageUrl = '',
  });

  @override
  State<TodayAppointmentWidget> createState() =>
      _TodayAppointmentWidgetState();
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
      duration: const Duration(milliseconds: 450),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    if (widget.patientName.isEmpty) {
      Timer(const Duration(seconds: 2), () {
        if (!mounted) return;

        setState(() {
          _isLoading = false;
        });

        _animationController.forward();
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

  // ============================================================
  // MAIN CARD
  // ============================================================

  Widget _buildCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22.r),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF075D9B),
            Color(0xFF0785CA),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF075D9B).withOpacity(0.18),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22.r),
        child: Stack(
          children: [
            // ====================================================
            // DECORATION
            // ====================================================

            Positioned(
              top: -45.h,
              right: -35.w,
              child: Container(
                width: 135.w,
                height: 135.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.06),
                ),
              ),
            ),

            Positioned(
              bottom: -50.h,
              left: -40.w,
              child: Container(
                width: 120.w,
                height: 120.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.04),
                ),
              ),
            ),

            // ====================================================
            // CONTENT
            // ====================================================

            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPatientHeader(),

                  SizedBox(height: 15.h),

                  _buildAppointmentInfo(),

                  SizedBox(height: 16.h),

                  _buildButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // PATIENT HEADER
  // ============================================================

  Widget _buildPatientHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildProfileAvatar(),

        SizedBox(width: 12.w),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name
              Text(
                widget.patientName.isEmpty
                    ? "Unknown Patient"
                    : widget.patientName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),

              SizedBox(height: 6.h),

              // Treatment Badge
              if (widget.treatmentType.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 9.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(50.r),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.15),
                    ),
                  ),
                  child: Text(
                    widget.treatmentType,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.95),
                      fontSize: 10.5.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

              if (widget.patientEmail.isNotEmpty) ...[
                SizedBox(height: 7.h),
                _buildSmallInfo(
                  icon: Icons.email_outlined,
                  text: widget.patientEmail,
                ),
              ],

              if (widget.patientPhone.isNotEmpty) ...[
                SizedBox(height: 4.h),
                _buildSmallInfo(
                  icon: Icons.phone_outlined,
                  text: widget.patientPhone,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SMALL EMAIL / PHONE INFO
  // ============================================================

  Widget _buildSmallInfo({
    required IconData icon,
    required String text,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 13.sp,
          color: Colors.white.withOpacity(0.75),
        ),

        SizedBox(width: 5.w),

        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white.withOpacity(0.78),
              fontSize: 10.5.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // APPOINTMENT INFO BOX
  // ============================================================

  Widget _buildAppointmentInfo() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 13.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.11),
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.10),
        ),
      ),
      child: Column(
        children: [
          _buildInfoRow(
            icon: Icons.calendar_month_rounded,
            text: CustomDateFormatter.formatDateTime(
              widget.date.toString(),
            ),
          ),

          if (widget.city.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 9.h),
              child: Divider(
                height: 1,
                thickness: 0.7,
                color: Colors.white.withOpacity(0.14),
              ),
            ),
            _buildInfoRow(
              icon: Icons.location_on_outlined,
              text: widget.city,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String text,
  }) {
    return Row(
      children: [
        Container(
          width: 31.w,
          height: 31.w,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              icon,
              size: 16.sp,
              color: Colors.white,
            ),
          ),
        ),

        SizedBox(width: 10.w),

        Expanded(
          child: Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.5.sp,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // BUTTONS
  // ============================================================

  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            label: "Interested",
            icon: Icons.check_circle_outline_rounded,
            onTap: widget.onInterested,
            primary: true,
          ),
        ),

        SizedBox(width: 10.w),

        Expanded(
          child: _buildActionButton(
            label: "Not Interested",
            icon: Icons.close_rounded,
            onTap: widget.onNotInterested,
            primary: false,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required VoidCallback? onTap,
    required bool primary,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          height: 43.h,
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          decoration: BoxDecoration(
            color: primary
                ? Colors.white
                : Colors.white.withOpacity(0.10),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: primary
                  ? Colors.white
                  : Colors.white.withOpacity(0.25),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 17.sp,
                color: primary
                    ? Color(0xFF0676B9)
                    : Colors.white,
              ),

              SizedBox(width: 5.w),

              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: primary
                        ? Color(0xFF0676B9)
                        : Colors.white,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // PROFILE AVATAR
  // ============================================================

  Widget _buildProfileAvatar() {
    final bool hasImage =
        widget.patientImageUrl.trim().isNotEmpty;

    final String initials =
    _getInitials(widget.patientName);

    return Container(
      width: 58.r,
      height: 58.r,
      padding: EdgeInsets.all(2.r),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.18),
        border: Border.all(
          color: Colors.white.withOpacity(0.55),
          width: 1.5,
        ),
      ),
      child: ClipOval(
        child: hasImage
            ? Image.network(
          widget.patientImageUrl,
          width: 54.r,
          height: 54.r,
          fit: BoxFit.cover,
          loadingBuilder: (
              context,
              child,
              loadingProgress,
              ) {
            if (loadingProgress == null) {
              return child;
            }

            return Container(
              color: Colors.white.withOpacity(0.1),
              child: Center(
                child: SizedBox(
                  width: 18.r,
                  height: 18.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.8,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
          errorBuilder: (
              context,
              error,
              stackTrace,
              ) {
            return _buildInitialsAvatar(initials);
          },
        )
            : _buildInitialsAvatar(initials),
      ),
    );
  }

  Widget _buildInitialsAvatar(String initials) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.25),
            Colors.white.withOpacity(0.10),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  String _getInitials(String name) {
    final String cleanedName = name.trim();

    if (cleanedName.isEmpty) {
      return "?";
    }

    final List<String> parts = cleanedName
        .split(RegExp(r'\s+'))
        .where((element) => element.isNotEmpty)
        .toList();

    if (parts.isEmpty) {
      return "?";
    }

    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }

    return "${parts.first[0]}${parts.last[0]}"
        .toUpperCase();
  }

  // ============================================================
  // SHIMMER
  // ============================================================

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22.r),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 58.r,
                  height: 58.r,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),

                SizedBox(width: 12.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 15.h,
                        width: 130.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(5.r),
                        ),
                      ),

                      SizedBox(height: 8.h),

                      Container(
                        height: 10.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(5.r),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            Container(
              width: double.infinity,
              height: 85.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
              ),
            ),

            SizedBox(height: 15.h),

            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 43.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(12.r),
                    ),
                  ),
                ),

                SizedBox(width: 10.w),

                Expanded(
                  child: Container(
                    height: 43.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(12.r),
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
}