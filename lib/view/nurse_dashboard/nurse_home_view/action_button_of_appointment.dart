import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A reusable styled action button used inside the card.
class ActionButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final VoidCallback? onTap;

  const ActionButton({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    this.onTap,
  });

  @override
  State<ActionButton> createState() => ActionButtonState();
}

class ActionButtonState extends State<ActionButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap?.call();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: _pressed
                ? widget.backgroundColor.withOpacity(0.8)
                : widget.backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: widget.borderColor, width: 1.2),
            boxShadow: widget.backgroundColor == Colors.white
                ? [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: Offset(0, 3),
              )
            ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, color: widget.textColor, size: 16),
              SizedBox(width: 6),
              Text(
                widget.label,
                style: TextStyle(
                  color: widget.textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}