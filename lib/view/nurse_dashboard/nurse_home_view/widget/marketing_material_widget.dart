// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:restaurent_discount_app/uitilies/app_colors.dart';

import '../../../../common widget/chached_network_image.dart';

/// Card for one piece of marketing material: optional cover image, tag chips,
/// readable HTML body with "Read more", and a share action.
class MarketingMaterialCard extends StatefulWidget {
  final String desc;
  final List<String> tags;
  final String image;
  final VoidCallback onTap;
  final DateTime? createdAt;

  const MarketingMaterialCard({
    Key? key,
    required this.desc,
    required this.tags,
    required this.image,
    this.createdAt,
    required this.onTap,
  }) : super(key: key);

  @override
  State<MarketingMaterialCard> createState() => _MarketingMaterialCardState();
}

class _MarketingMaterialCardState extends State<MarketingMaterialCard> {
  static const Color _textDark = Color(0xFF1F2937);
  static const Color _textBody = Color(0xFF4B5563);
  static const Color _textMuted = Color(0xFF6B7280);
  static const double _collapsedHeight = 96;

  bool _isExpanded = false;

  String _timeAgo(DateTime? date) {
    if (date == null) return '';
    final diff = DateTime.now().difference(date);
    if (diff.inDays >= 30) return '${(diff.inDays / 30).floor()}mo ago';
    if (diff.inDays >= 7) return '${(diff.inDays / 7).floor()}w ago';
    if (diff.inDays >= 1) return '${diff.inDays}d ago';
    if (diff.inHours >= 1) return '${diff.inHours}h ago';
    if (diff.inMinutes >= 1) return '${diff.inMinutes}m ago';
    return 'Just now';
  }

  Map<String, Style> get _htmlStyle => {
        'body': Style(
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
          color: _textBody,
          fontSize: FontSize(14),
          lineHeight: const LineHeight(1.5),
        ),
        'p': Style(
          margin: Margins.only(bottom: 8),
          color: _textBody,
          fontSize: FontSize(14),
        ),
        'strong': Style(color: _textDark, fontWeight: FontWeight.w700),
        'b': Style(color: _textDark, fontWeight: FontWeight.w700),
        'h1': Style(
            color: _textDark,
            fontSize: FontSize(19),
            fontWeight: FontWeight.w700,
            margin: Margins.only(top: 4, bottom: 6)),
        'h2': Style(
            color: _textDark,
            fontSize: FontSize(17),
            fontWeight: FontWeight.w700,
            margin: Margins.only(top: 4, bottom: 6)),
        'h3': Style(
            color: _textDark,
            fontSize: FontSize(16),
            fontWeight: FontWeight.w700,
            margin: Margins.only(top: 4, bottom: 6)),
        'a': Style(color: AppColors.mainColor),
        'li': Style(color: _textBody, fontSize: FontSize(14)),
      };

  @override
  Widget build(BuildContext context) {
    final hasImage = widget.image.trim().isNotEmpty;
    final tags =
        widget.tags.map((t) => t.trim()).where((t) => t.isNotEmpty).toList();
    final timeAgo = _timeAgo(widget.createdAt);

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 6, 12, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE8EEF7)),
        boxShadow: [
          BoxShadow(
            color: AppColors.mainColor.withOpacity(0.07),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasImage)
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: CustomCachedImage(imageUrl: widget.image),
                  ),
                  if (timeAgo.isNotEmpty)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: _Pill(
                        icon: Icons.schedule_rounded,
                        label: timeAgo,
                        background: Colors.black.withOpacity(0.55),
                        foreground: Colors.white,
                      ),
                    ),
                ],
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header: badge + time (time moves onto the image when there is one)
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.campaign_rounded,
                            size: 18, color: AppColors.mainColor),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Marketing Update',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: _textDark,
                          ),
                        ),
                      ),
                      if (!hasImage && timeAgo.isNotEmpty)
                        Text(
                          timeAgo,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: _textMuted,
                          ),
                        ),
                    ],
                  ),
                  if (tags.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: tags
                          .map((t) => _Pill(
                                label: '#$t',
                                background: AppColors.bgColor,
                                foreground: AppColors.mainColor,
                              ))
                          .toList(),
                    ),
                  ],
                  const SizedBox(height: 10),

                  // Body: clipped with a fade when collapsed
                  AnimatedSize(
                    duration: const Duration(milliseconds: 280),
                    curve: Curves.easeOutCubic,
                    alignment: Alignment.topCenter,
                    child: _isExpanded
                        ? Html(data: widget.desc, style: _htmlStyle)
                        : ConstrainedBox(
                            constraints: const BoxConstraints(
                                maxHeight: _collapsedHeight),
                            child: ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.black, Colors.transparent],
                                stops: [0.6, 1.0],
                              ).createShader(bounds),
                              blendMode: BlendMode.dstIn,
                              child: SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
                                child: Html(
                                    data: widget.desc, style: _htmlStyle),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),

            // Footer actions
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 2, 12, 10),
              child: Row(
                children: [
                  TextButton.icon(
                    onPressed: () => setState(() => _isExpanded = !_isExpanded),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.mainColor,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                    ),
                    icon: AnimatedRotation(
                      turns: _isExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 250),
                      child: const Icon(Icons.keyboard_arrow_down_rounded,
                          size: 20),
                    ),
                    label: Text(
                      _isExpanded ? 'Show less' : 'Read more',
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const Spacer(),
                  Material(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(22),
                    child: InkWell(
                      onTap: widget.onTap,
                      borderRadius: BorderRadius.circular(22),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.share_rounded,
                                size: 16, color: Colors.white),
                            SizedBox(width: 6),
                            Text(
                              'Share',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({
    required this.label,
    required this.background,
    required this.foreground,
    this.icon,
  });

  final String label;
  final Color background;
  final Color foreground;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: foreground),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: foreground,
            ),
          ),
        ],
      ),
    );
  }
}
