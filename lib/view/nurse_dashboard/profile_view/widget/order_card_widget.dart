// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';
import '../model/supply_order_model_history.dart';

/// One supply order shown as a card with a header (order number, date,
/// status) and a table of items: Product | Qty | Price | Total.
class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  static const _textDark = Color(0xFF1F2937);
  static const _textBody = Color(0xFF374151);
  static const _textMuted = Color(0xFF6B7280);
  static const _border = Color(0xFFE5EAF2);
  static const _headerBg = Color(0xFFF3F7FD);

  static final _money = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

  ({Color fg, Color bg}) _statusColors(String status) {
    switch (status.toUpperCase()) {
      case 'APPROVED':
      case 'DELIVERED':
      case 'COMPLETED':
      case 'PAID':
        return (fg: const Color(0xFF15803D), bg: const Color(0xFFDCFCE7));
      case 'PENDING':
      case 'PROCESSING':
        return (fg: const Color(0xFFB45309), bg: const Color(0xFFFEF3C7));
      case 'CANCELLED':
      case 'CANCELED':
      case 'REJECTED':
      case 'FAILED':
        return (fg: const Color(0xFFDC2626), bg: const Color(0xFFFEE2E2));
      default:
        return (fg: _textMuted, bg: const Color(0xFFF3F4F6));
    }
  }

  String _titleCase(String s) => s.isEmpty
      ? s
      : s[0].toUpperCase() + s.substring(1).toLowerCase();

  String _shortId(String? id) {
    if (id == null || id.isEmpty) return 'N/A';
    return id.length > 8 ? id.substring(id.length - 8).toUpperCase() : id;
  }

  @override
  Widget build(BuildContext context) {
    final status = order.status ?? 'Unknown';
    final statusColors = _statusColors(status);
    final date = order.createdAt != null
        ? DateFormat('d MMM yyyy · h:mm a').format(order.createdAt!.toLocal())
        : 'N/A';

    final itemsTotal = order.orderItems.fold<double>(
        0, (sum, i) => sum + (i.product?.price ?? 0) * (i.quantity ?? 0));
    final totalQty =
        order.orderItems.fold<int>(0, (sum, i) => sum + (i.quantity ?? 0));
    final orderTotal = order.payment?.amount ?? itemsTotal;
    final paymentStatus = order.paymentStatus ?? order.payment?.status;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border),
        boxShadow: [
          BoxShadow(
            color: AppColors.mainColor.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.inventory_2_outlined,
                        size: 18, color: AppColors.mainColor),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order #${_shortId(order.id)}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: _textDark,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          date,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: _textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _Chip(
                    label: _titleCase(status),
                    fg: statusColors.fg,
                    bg: statusColors.bg,
                  ),
                ],
              ),
            ),

            // Items table
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _border),
              ),
              clipBehavior: Clip.antiAlias,
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(3.2),
                  1: FlexColumnWidth(1.1),
                  2: FlexColumnWidth(1.8),
                  3: FlexColumnWidth(1.9),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: const TableBorder(
                  horizontalInside: BorderSide(color: _border),
                ),
                children: [
                  TableRow(
                    decoration: const BoxDecoration(color: _headerBg),
                    children: [
                      _headerCell('Product'),
                      _headerCell('Qty', align: TextAlign.center),
                      _headerCell('Price', align: TextAlign.right),
                      _headerCell('Total', align: TextAlign.right),
                    ],
                  ),
                  if (order.orderItems.isEmpty)
                    TableRow(children: [
                      _cell('No items', color: _textMuted),
                      _cell(''),
                      _cell(''),
                      _cell(''),
                    ]),
                  ...order.orderItems.map((item) {
                    final price = item.product?.price ?? 0;
                    final qty = item.quantity ?? 0;
                    return TableRow(children: [
                      _cell(item.product?.name ?? 'Unknown',
                          weight: FontWeight.w600, color: _textDark),
                      _cell('$qty', align: TextAlign.center),
                      _cell(_money.format(price), align: TextAlign.right),
                      _cell(_money.format(price * qty),
                          align: TextAlign.right,
                          weight: FontWeight.w600,
                          color: _textDark),
                    ]);
                  }),
                  TableRow(
                    decoration: const BoxDecoration(color: _headerBg),
                    children: [
                      _cell('Total',
                          weight: FontWeight.w800, color: _textDark),
                      _cell('$totalQty',
                          align: TextAlign.center,
                          weight: FontWeight.w800,
                          color: _textDark),
                      _cell(''),
                      _cell(_money.format(orderTotal),
                          align: TextAlign.right,
                          weight: FontWeight.w800,
                          color: AppColors.mainColor),
                    ],
                  ),
                ],
              ),
            ),

            // Footer: payment status
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
              child: Row(
                children: [
                  const Icon(Icons.credit_card_rounded,
                      size: 16, color: _textMuted),
                  const SizedBox(width: 6),
                  const Text(
                    'Payment',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: _textMuted,
                    ),
                  ),
                  const Spacer(),
                  if (paymentStatus != null && paymentStatus.isNotEmpty)
                    _Chip(
                      label: _titleCase(paymentStatus),
                      fg: _statusColors(paymentStatus).fg,
                      bg: _statusColors(paymentStatus).bg,
                    )
                  else
                    const Text('—',
                        style: TextStyle(fontSize: 13, color: _textMuted)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerCell(String text, {TextAlign align = TextAlign.left}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      child: Text(
        text.toUpperCase(),
        textAlign: align,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
          color: _textMuted,
        ),
      ),
    );
  }

  Widget _cell(
    String text, {
    TextAlign align = TextAlign.left,
    FontWeight weight = FontWeight.w500,
    Color color = _textBody,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Text(
        text,
        textAlign: align,
        style: TextStyle(fontSize: 13, fontWeight: weight, color: color),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.fg, required this.bg});

  final String label;
  final Color fg;
  final Color bg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: fg,
        ),
      ),
    );
  }
}
