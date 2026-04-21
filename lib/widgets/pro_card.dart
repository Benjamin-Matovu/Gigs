// ============================================================
// lib/widgets/pro_card.dart
// ATOMIC WIDGET: ProCard
// Used inside ListView.builder on the Home screen.
// The Hero widget wraps the avatar so it animates smoothly
// when the user taps through to the Pro Profile screen.
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_theme.dart';
import '../data/mock_data.dart';
import 'star_rating.dart';
import 'tumma_badge.dart';

class ProCard extends StatelessWidget {
  final ProWorker worker;
  final VoidCallback onTap;

  const ProCard({super.key, required this.worker, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: TummaColors.white,
          borderRadius: BorderRadius.circular(TummaTheme.cardRadius),
          border: Border.all(color: TummaColors.cardBorder),
        ),
        child: Row(
          children: [
            // ── Hero animation wraps the avatar
            // When we navigate to ProProfile, Flutter animates
            // this avatar flying to its new position on that screen.
            Hero(
              tag: 'avatar_${worker.id}',
              child: Container(
                width: 54, height: 54,
                decoration: BoxDecoration(
                  color: Color(worker.color),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    worker.initials,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Worker info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(worker.name,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: TummaColors.textPrimary,
                    )),
                  const SizedBox(height: 2),
                  Text('${worker.role} • ${worker.experience}',
                    style: GoogleFonts.inter(
                      fontSize: 12, color: TummaColors.textSecondary,
                    )),
                  const SizedBox(height: 8),
                  Row(children: [
                    TummaBadge(
                      label: worker.badge,
                      isAmber: worker.badge == 'PREMIUM',
                    ),
                    const SizedBox(width: 8),
                    Text('${worker.jobsCompleted}+ Projects',
                      style: GoogleFonts.inter(
                        fontSize: 11, color: TummaColors.textSecondary,
                      )),
                  ]),
                ],
              ),
            ),

            // Rating
            StarRating(rating: worker.rating),
          ],
        ),
      ),
    );
  }
}
