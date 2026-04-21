// ============================================================
// lib/widgets/tumma_badge.dart
// ATOMIC WIDGET: TummaBadge
// Reusable pill badge for VERIFIED, PREMIUM, IN PROGRESS etc.
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_theme.dart';

class TummaBadge extends StatelessWidget {
  final String label;
  final bool isAmber;
  final bool isSuccess;

  const TummaBadge({
    super.key,
    required this.label,
    this.isAmber = false,
    this.isSuccess = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color bg = isSuccess
        ? TummaColors.successBg
        : isAmber
            ? TummaColors.amberBg
            : TummaColors.tealBg;

    final Color fg = isSuccess
        ? TummaColors.success
        : isAmber
            ? TummaColors.amber
            : TummaColors.teal;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: fg.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: fg,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
