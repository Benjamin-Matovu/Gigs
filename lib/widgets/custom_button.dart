// ============================================================
// lib/widgets/custom_button.dart
// ATOMIC WIDGET: TummaButton
// Instead of coding every button manually across 5 screens,
// we create one reusable widget. Change it here, it updates
// everywhere — this is the "Atomic Widgets" strategy.
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_theme.dart';

enum TummaButtonStyle { primary, secondary, amber }

class TummaButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final TummaButtonStyle style;
  final IconData? icon;
  final bool fullWidth;
  final double height;

  const TummaButton({
    super.key,
    required this.label,
    required this.onTap,
    this.style = TummaButtonStyle.primary,
    this.icon,
    this.fullWidth = true,
    this.height = 54,
  });

  @override
  Widget build(BuildContext context) {
    // Determine colours based on the style variant
    final bg = style == TummaButtonStyle.amber
        ? TummaColors.amber
        : style == TummaButtonStyle.secondary
            ? TummaColors.white
            : TummaColors.teal;

    final fg = style == TummaButtonStyle.secondary
        ? TummaColors.textPrimary
        : TummaColors.white;

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          elevation: style == TummaButtonStyle.secondary ? 0 : 2,
          shadowColor: bg.withOpacity(0.3),
          side: style == TummaButtonStyle.secondary
              ? const BorderSide(color: TummaColors.cardBorder, width: 1.5)
              : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TummaTheme.buttonRadius),
          ),
        ),
        child: Row(
          mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: fg,
              ),
            ),
            if (icon != null) ...[
              const SizedBox(width: 8),
              Icon(icon, size: 18, color: fg),
            ],
          ],
        ),
      ),
    );
  }
}
