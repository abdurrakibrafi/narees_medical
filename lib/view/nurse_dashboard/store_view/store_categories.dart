import 'package:flutter/material.dart';

import '../../paitent_dashboard_view/inventory_list_view/model/inventory_product_model.dart';

/// A store category. The product API has no category field yet, so a product
/// belongs to a category when one of [keywords] appears as a whole word in its
/// tags or name.
class StoreCategory {
  const StoreCategory({
    required this.label,
    required this.icon,
    required this.keywords,
  });

  final String label;
  final IconData icon;
  final List<String> keywords;

  bool matches(Inventory product) {
    final haystack =
        [...product.tags, product.name ?? ''].join(' ').toLowerCase();
    return keywords.any(
      (k) => RegExp(r'\b' + RegExp.escape(k)).hasMatch(haystack),
    );
  }
}

const List<StoreCategory> storeCategories = [
  StoreCategory(
    label: 'Medications',
    icon: Icons.medication_outlined,
    keywords: ['medication', 'medicine', 'drug', 'vitamin', 'tablet', 'capsule'],
  ),
  StoreCategory(
    label: 'Clinical supplies',
    icon: Icons.medical_services_outlined,
    keywords: ['clinical', 'glove', 'gauze', 'bandage', 'mask', 'swab', 'supplies'],
  ),
  StoreCategory(
    label: 'IV/injection supplies',
    icon: Icons.vaccines_outlined,
    keywords: ['iv', 'injection', 'syringe', 'needle', 'catheter', 'infusion', 'saline'],
  ),
  StoreCategory(
    label: 'Merchandise',
    icon: Icons.shopping_bag_outlined,
    keywords: ['merch', 'merchandise', 'mug', 'tote', 'cap', 'sticker'],
  ),
  StoreCategory(
    label: 'Scrubs',
    icon: Icons.checkroom_outlined,
    keywords: ['scrub'],
  ),
  StoreCategory(
    label: 'Embroidered/customized scrubs',
    icon: Icons.design_services_outlined,
    keywords: ['embroider', 'customized', 'customised', 'custom'],
  ),
];
