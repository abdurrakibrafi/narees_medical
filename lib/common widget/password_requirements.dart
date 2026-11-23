import 'package:flutter/material.dart';
import 'package:restaurent_discount_app/uitilies/password_policy.dart';

/// Live checklist shown under a password field. Each rule turns green with a
/// check mark as soon as the typed password satisfies it, and a strength bar
/// fills as rules are met (with a nudge toward the recommended 12+ chars).
class PasswordRequirements extends StatelessWidget {
  const PasswordRequirements({super.key, required this.controller});

  final TextEditingController controller;

  static const _met = Color(0xFF15803D);
  static const _unmet = Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        final password = value.text;
        final results =
            PasswordPolicy.rules.map((r) => r.test(password)).toList();
        final metCount = results.where((m) => m).length;
        final allMet = metCount == results.length;
        final long = password.length >= PasswordPolicy.recommendedLength;

        final (String strength, Color strengthColor) = password.isEmpty
            ? ('', _unmet)
            : !allMet
                ? (metCount <= 2 ? 'Weak' : 'Fair', metCount <= 2
                    ? const Color(0xFFDC2626)
                    : const Color(0xFFD97706))
                : long
                    ? ('Strong', _met)
                    : ('Good', const Color(0xFF2563EB));

        final progress = password.isEmpty
            ? 0.0
            : (metCount + (allMet && long ? 1 : 0)) / (results.length + 1);

        return Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.92),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE5EAF2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(end: progress),
                        duration: const Duration(milliseconds: 250),
                        builder: (_, v, __) => LinearProgressIndicator(
                          value: v,
                          minHeight: 5,
                          backgroundColor: const Color(0xFFE5E7EB),
                          valueColor: AlwaysStoppedAnimation(strengthColor),
                        ),
                      ),
                    ),
                  ),
                  if (strength.isNotEmpty) ...[
                    const SizedBox(width: 10),
                    Text(
                      strength,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: strengthColor,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 8),
              for (var i = 0; i < PasswordPolicy.rules.length; i++)
                _RuleRow(
                    label: PasswordPolicy.rules[i].label, met: results[i]),
              const SizedBox(height: 4),
              Text(
                long
                    ? '✓ ${PasswordPolicy.recommendedLength}+ characters — great'
                    : 'Tip: ${PasswordPolicy.recommendedLength}+ characters is recommended',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                  color: long ? _met : _unmet,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RuleRow extends StatelessWidget {
  const _RuleRow({required this.label, required this.met});

  final String label;
  final bool met;

  @override
  Widget build(BuildContext context) {
    final color =
        met ? PasswordRequirements._met : PasswordRequirements._unmet;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (c, a) => ScaleTransition(scale: a, child: c),
            child: Icon(
              met ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
              key: ValueKey(met),
              size: 16,
              color: color,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: met ? FontWeight.w600 : FontWeight.w500,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
