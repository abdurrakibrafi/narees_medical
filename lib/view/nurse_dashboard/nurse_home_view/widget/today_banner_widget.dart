import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';

/// Tappable "Today" banner at the top of the nurse home screen. Shows today's
/// date and how many appointments are scheduled, and opens the appointment
/// page when tapped.
class TodayBanner extends StatelessWidget {
  const TodayBanner({
    super.key,
    required this.onTap,
    required this.appointmentCount,
    this.isLoading = false,
  });

  final VoidCallback onTap;
  final int appointmentCount;
  final bool isLoading;

  String get _countLabel {
    if (isLoading) return 'Loading your schedule…';
    if (appointmentCount == 0) return 'No appointments today';
    if (appointmentCount == 1) return '1 appointment today';
    return '$appointmentCount appointments today';
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      child: Material(
        color: AppColors.bgColor,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          splashColor: AppColors.mainColor.withOpacity(0.1),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.mainColor.withOpacity(0.15)),
            ),
            child: Row(
              children: [
                // Calendar-style date block
                Container(
                  width: 58,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.mainColor.withOpacity(0.12),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: AppColors.mainColor,
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        alignment: Alignment.center,
                        child: Text(
                          DateFormat('MMM').format(now).toUpperCase(),
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          '${now.day}',
                          style: const TextStyle(
                            fontSize: 24,
                            height: 1.1,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 14),

                // Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's Schedule",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                          color: AppColors.mainColor,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        DateFormat('EEEE, d MMMM').format(now),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            width: 7,
                            height: 7,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: appointmentCount > 0
                                  ? const Color(0xFF16A34A)
                                  : const Color(0xFF9CA3AF),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              _countLabel,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF4B5563),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // Arrow
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_forward_rounded,
                      size: 20, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
