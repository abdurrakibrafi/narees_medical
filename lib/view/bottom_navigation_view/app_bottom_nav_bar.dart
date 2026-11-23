import 'package:flutter/material.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';

/// One tab in [AppBottomNavBar]. Provide either an image [asset] or an [icon].
class AppNavItem {
  const AppNavItem({required this.label, this.asset, this.icon})
      : assert(asset != null || icon != null);

  final String label;
  final String? asset;
  final IconData? icon;
}

/// Floating, rounded bottom navigation bar shared by the nurse and patient
/// dashboards. The selected tab gets a tinted pill behind its icon and a bold
/// label in the brand colour; unselected labels use a dark grey that stays
/// readable on white.
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  final List<AppNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  static const Color _inactive = Color(0xFF5F6B7A);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.only(bottom: 10),
      child: Container(
        margin: const EdgeInsets.fromLTRB(14, 0, 14, 0),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(color: AppColors.mainColor.withOpacity(0.08)),
          boxShadow: [
            BoxShadow(
              color: AppColors.mainColor.withOpacity(0.12),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: List.generate(items.length, (i) {
            return Expanded(
              child: _NavTile(
                item: items[i],
                selected: i == currentIndex,
                onTap: () => onTap(i),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final AppNavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color =
        selected ? AppColors.mainColor : AppBottomNavBar._inactive;

    final Widget iconWidget = item.asset != null
        ? Image.asset(item.asset!, width: 22, height: 22, color: color)
        : Icon(item.icon, size: 23, color: color);

    return Semantics(
      button: true,
      selected: selected,
      label: item.label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        splashColor: AppColors.mainColor.withOpacity(0.08),
        highlightColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                width: selected ? 54 : 40,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.mainColor.withOpacity(0.12)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: iconWidget,
              ),
              const SizedBox(height: 4),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.2,
                    letterSpacing: 0.1,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                    color: color,
                  ),
                  child: Text(
                    item.label,
                    maxLines: 1,
                    textScaler: TextScaler.noScaling,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
