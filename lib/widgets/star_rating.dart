// ============================================================
// lib/widgets/star_rating.dart
// ATOMIC WIDGET: StarRating
// Reusable rating display used on both Home and Pro Profile.
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_theme.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double size;
  final bool showNumber;

  const StarRating({
    super.key,
    required this.rating,
    this.size = 14,
    this.showNumber = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_rounded, color: TummaColors.amber, size: size + 2),
        const SizedBox(width: 3),
        if (showNumber)
          Text(
            rating.toStringAsFixed(1),
            style: GoogleFonts.inter(
              fontSize: size,
              fontWeight: FontWeight.w700,
              color: TummaColors.textPrimary,
            ),
          ),
      ],
    );
  }
}
