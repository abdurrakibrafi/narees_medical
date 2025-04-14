import 'package:flutter/material.dart';

import '../../../common widget/custom text/custom_text_widget.dart';

class ModuleDescriptionWidget extends StatelessWidget {
  const ModuleDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'Importance of Hand Hygiene',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 8),
          CustomText(
            textAlign: TextAlign.start,
            text:
            'This module emphasizes the critical importance of hand hygiene...',
            fontSize: 16,
          ),
          SizedBox(height: 16),
          CustomText(text: 'When to Perform Hand Hygiene:',
            fontWeight: FontWeight.bold,fontSize: 16,),
          SizedBox(height: 6),
          _BulletList(text: 'Before handling IV equipment...'),
          _BulletList(text: 'Before and after touching the insertion site...'),
          _BulletList(text: 'After touching any surfaces...'),
          _BulletList(text: 'After removing gloves...'),
          SizedBox(height: 16),
          Text('Techniques for Hand Hygiene:',
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          _BulletList(text: 'Handwashing with soap...'),
          _BulletList(text: 'Using alcohol-based hand sanitizers...'),
          _BulletList(text: 'Scrubbing under fingernails...'),
          SizedBox(height: 12),

        ],
      ),
    );
  }
}


class _BulletList extends StatelessWidget {
  final String text;
  const _BulletList({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("• ", style: TextStyle(fontSize: 16)),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
      ],
    );
  }
}