import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Pill shown under the nurse's name with the number of days until (or since)
/// their license expires. Colour shows urgency: green = valid, amber = 30 days
/// or less left, red = expired or expiring today, grey = no date on file.
class LicenseExpiryBadge extends StatelessWidget {
  const LicenseExpiryBadge({super.key, required this.expiryDate});

  final DateTime? expiryDate;

  static const _green = Color(0xFF15803D);
  static const _amber = Color(0xFFB45309);
  static const _red = Color(0xFFDC2626);
  static const _grey = Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
    final IconData icon;
    final Color color;
    final String title;
    String? subtitle;

    if (expiryDate == null) {
      icon = Icons.badge_outlined;
      color = _grey;
      title = 'License expiry not set';
    } else {
      final local = expiryDate!.toLocal();
      final today = DateUtils.dateOnly(DateTime.now());
      final expiry = DateUtils.dateOnly(local);
      final days = expiry.difference(today).inDays;
      final dateText = DateFormat('d MMM yyyy').format(local);

      if (days < 0) {
        final ago = -days;
        icon = Icons.error_outline_rounded;
        color = _red;
        title = 'License expired $ago ${ago == 1 ? 'day' : 'days'} ago';
        subtitle = 'Expired on $dateText';
      } else if (days == 0) {
        icon = Icons.error_outline_rounded;
        color = _red;
        title = 'License expires today';
        subtitle = dateText;
      } else if (days <= 30) {
        icon = Icons.warning_amber_rounded;
        color = _amber;
        title = 'License expires in $days ${days == 1 ? 'day' : 'days'}';
        subtitle = 'Renew before $dateText';
      } else {
        icon = Icons.verified_outlined;
        color = _green;
        title = '$days days until license expires';
        subtitle = 'Valid until $dateText';
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                      color: color.withOpacity(0.85),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
