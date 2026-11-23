import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:restaurent_discount_app/common%20widget/chached_network_image.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';
import 'package:restaurent_discount_app/uitilies/custom_loader.dart';

import '../../paitent_dashboard_view/inventory_list_view/controller/inverntory_product_controller.dart';
import '../../paitent_dashboard_view/inventory_list_view/inventory_details_view.dart';
import '../../paitent_dashboard_view/inventory_list_view/model/inventory_product_model.dart';
import '../cart_view/cart_view.dart';
import '../profile_view/supply_order_history.dart';
import 'store_categories.dart';

/// Nurse store: products filtered by category and search, with a Reorder
/// entry point that opens past supply orders.
class StoreView extends StatefulWidget {
  const StoreView({super.key});

  @override
  State<StoreView> createState() => _StoreViewState();
}

class _StoreViewState extends State<StoreView> {
  final GetAllInverntoryController _controller =
      Get.put(GetAllInverntoryController());

  /// null = "All".
  StoreCategory? _category;
  String _query = '';
  final TextEditingController _searchCtrl = TextEditingController();

  static const _textDark = Color(0xFF1F2937);
  static const _textMuted = Color(0xFF6B7280);
  static final _money = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

  @override
  void initState() {
    super.initState();
    if (_controller.inventoryList.isEmpty) _controller.getInventory();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<Inventory> _filtered(List<Inventory> all) {
    final q = _query.trim().toLowerCase();
    return all.where((p) {
      if (_category != null && !_category!.matches(p)) return false;
      if (q.isEmpty) return true;
      return (p.name ?? '').toLowerCase().contains(q) ||
          (p.supplierName ?? '').toLowerCase().contains(q) ||
          p.tags.any((t) => t.toLowerCase().contains(q));
    }).toList();
  }

  void _openDetails(Inventory item) {
    Get.to(() => ViewInventoryPage(
          proName: item.name ?? 'Unknown Name',
          price: item.price ?? 0.0,
          images: item.productImages.map((image) => image.url).toList(),
          desc: item.description ?? 'No Description Available',
          supplierName: item.supplierName ?? 'Unknown Supplier',
          proId: item.id.toString(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Store',
        actions: [
          IconButton(
            tooltip: 'My Cart',
            icon: Icon(Icons.shopping_cart_outlined, color: AppColors.mainColor),
            onPressed: () => Get.to(() => CartPage()),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.mainColor,
        onRefresh: () => _controller.getInventory(),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: _searchField()),
            SliverToBoxAdapter(child: _reorderCard()),
            SliverToBoxAdapter(child: _categoryChips()),
            Obx(() {
              if (_controller.isLoading.value) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CustomLoader()),
                );
              }
              final products = _filtered(_controller.inventoryList);
              if (products.isEmpty) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: _emptyState(),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.68,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => _ProductCard(
                      item: products[i],
                      money: _money,
                      onTap: () => _openDetails(products[i]),
                    ),
                    childCount: products.length,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _searchField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: TextField(
        controller: _searchCtrl,
        onChanged: (v) => setState(() => _query = v),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Search products',
          prefixIcon: const Icon(Icons.search, color: _textMuted),
          filled: true,
          fillColor: const Color(0xFFF5F7FB),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: AppColors.mainColor),
          ),
        ),
      ),
    );
  }

  Widget _reorderCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Material(
        color: AppColors.bgColor,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () =>
              Get.to(() => const SupplyOrderHistoryPage(title: 'Reorder')),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.replay_rounded, color: AppColors.mainColor),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reorder supplies',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: _textDark,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Add a past order back to your cart in one tap',
                        style: TextStyle(fontSize: 12.5, color: _textMuted),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Reorder',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _categoryChips() {
    final chips = <Widget>[
      _chip(label: 'All', icon: Icons.grid_view_rounded, category: null),
      for (final c in storeCategories)
        _chip(label: c.label, icon: c.icon, category: c),
    ];
    return SizedBox(
      height: 52,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(16, 2, 16, 10),
        itemCount: chips.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) => chips[i],
      ),
    );
  }

  Widget _chip({
    required String label,
    required IconData icon,
    required StoreCategory? category,
  }) {
    final selected = _category == category;
    return ChoiceChip(
      selected: selected,
      onSelected: (_) => setState(() => _category = category),
      showCheckmark: false,
      avatar: Icon(icon,
          size: 18, color: selected ? Colors.white : AppColors.mainColor),
      label: Text(label),
      labelStyle: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: selected ? Colors.white : _textDark,
      ),
      selectedColor: AppColors.mainColor,
      backgroundColor: Colors.white,
      side: BorderSide(
        color: selected
            ? AppColors.mainColor
            : AppColors.mainColor.withOpacity(0.2),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  Widget _emptyState() {
    final filtering = _category != null || _query.trim().isNotEmpty;
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.storefront_outlined,
              size: 56, color: AppColors.mainColor.withOpacity(0.4)),
          const SizedBox(height: 12),
          Text(
            filtering
                ? 'No products in ${_category?.label ?? 'this search'} yet'
                : 'No products available right now',
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w700, color: _textDark),
          ),
          if (filtering) ...[
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => setState(() {
                _category = null;
                _query = '';
                _searchCtrl.clear();
              }),
              child: const Text('Show all products'),
            ),
          ],
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    required this.item,
    required this.money,
    required this.onTap,
  });

  final Inventory item;
  final NumberFormat money;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final inStock = item.stockStatus == 'IN_STOCK';
    final image =
        item.productImages.isNotEmpty ? item.productImages.first.url ?? '' : '';

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5EAF2)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CustomCachedImage(imageUrl: image),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: inStock
                              ? const Color(0xFFDCFCE7)
                              : const Color(0xFFFEE2E2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          inStock ? 'In stock' : 'Out of stock',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: inStock
                                ? const Color(0xFF15803D)
                                : const Color(0xFFDC2626),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name ?? 'Unknown',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13.5,
                        height: 1.25,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.price != null
                                ? money.format(item.price)
                                : 'N/A',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: AppColors.mainColor,
                            ),
                          ),
                        ),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.add_shopping_cart_rounded,
                              size: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
