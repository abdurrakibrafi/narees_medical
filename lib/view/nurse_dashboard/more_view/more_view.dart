import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';

import '../cart_view/cart_view.dart';
import '../profile_view/profile_view.dart';
import '../profile_view/supply_order_history.dart';
import '../store_view/store_view.dart';

/// "More" tab of the nurse dashboard: entry points that don't fit in the
/// bottom bar (Profile, Store, Reorder, Cart).
class MoreView extends StatelessWidget {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <_MoreItem>[
      _MoreItem(
        icon: Icons.person_outline_rounded,
        title: 'Profile',
        subtitle: 'Your details, documents, settings and log out',
        onTap: () => Get.to(() => ProfilePage(showBack: true)),
      ),
      _MoreItem(
        icon: Icons.storefront_outlined,
        title: 'Store',
        subtitle: 'Medications, supplies, scrubs and merchandise',
        onTap: () => Get.to(() => const StoreView()),
      ),
      _MoreItem(
        icon: Icons.replay_rounded,
        title: 'Reorder',
        subtitle: 'Add a past supply order back to your cart',
        onTap: () =>
            Get.to(() => const SupplyOrderHistoryPage(title: 'Reorder')),
      ),
      _MoreItem(
        icon: Icons.shopping_cart_outlined,
        title: 'My Cart',
        subtitle: 'Review items and check out',
        onTap: () => Get.to(() => CartPage()),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(leading: Container(), title: 'More'),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, i) => _MoreTile(item: items[i]),
      ),
    );
  }
}

class _MoreItem {
  const _MoreItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
}

class _MoreTile extends StatelessWidget {
  const _MoreTile({required this.item});

  final _MoreItem item;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5EAF2)),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.bgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(item.icon, color: AppColors.mainColor),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.subtitle,
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: Color(0xFF9CA3AF)),
            ],
          ),
        ),
      ),
    );
  }
}
