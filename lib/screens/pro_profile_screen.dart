// ============================================================
// lib/screens/pro_profile_screen.dart
// SCREEN 3: Pro Profile
// Hero animation: the worker avatar flies from the ProCard
// on the Home screen to this screen's header — a premium UX
// transition that Flutter handles automatically when both
// Hero widgets share the same tag ('avatar_${worker.id}').
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/custom_button.dart';
import '../widgets/star_rating.dart';
import '../widgets/tumma_badge.dart';
import 'job_details_screen.dart';

class ProProfileScreen extends StatelessWidget {
  final ProWorker worker;
  const ProProfileScreen({super.key, required this.worker});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TummaColors.bgLight,
      body: CustomScrollView(
        slivers: [

          // ── COLLAPSING HEADER ────────────────────────────
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: TummaColors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [TummaColors.teal, TummaColors.tealLight],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  // ── Hero widget: matches tag in ProCard
                  // Flutter sees two Hero widgets with the same tag
                  // and animates the transition between them.
                  child: Hero(
                    tag: 'avatar_${worker.id}',
                    child: Container(
                      width: 88, height: 88,
                      decoration: BoxDecoration(
                        color: Color(worker.color),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20, offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(worker.initials,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                          )),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ── PROFILE CONTENT ──────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [

                  // Name + rating
                  Text(worker.name,
                    style: GoogleFonts.inter(
                      fontSize: 24, fontWeight: FontWeight.w800,
                      color: TummaColors.textPrimary, letterSpacing: -0.5,
                    )),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StarRating(rating: worker.rating, size: 16),
                      const SizedBox(width: 12),
                      TummaBadge(
                        label: worker.badge,
                        isAmber: worker.badge == 'PREMIUM',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // ── Stats row ──────────────────────────────
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: TummaColors.white,
                      borderRadius: BorderRadius.circular(TummaTheme.cardRadius),
                      border: Border.all(color: TummaColors.cardBorder),
                    ),
                    child: Row(
                      children: [
                        _StatItem(
                          value: worker.communityVouches.toString(),
                          label: 'Community\nVouches',
                        ),
                        Container(width: 1, height: 40, color: TummaColors.cardBorder),
                        _StatItem(
                          value: worker.jobsCompleted.toString(),
                          label: 'Jobs\nCompleted',
                        ),
                        Container(width: 1, height: 40, color: TummaColors.cardBorder),
                        _StatItem(
                          value: worker.rating.toString(),
                          label: 'Star\nRating',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Rate card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [TummaColors.teal, TummaColors.tealLight],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(TummaTheme.cardRadius),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.payments_rounded,
                            color: Colors.white, size: 22),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Standard Rate',
                              style: GoogleFonts.inter(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 12,
                              )),
                            Text('${worker.ratePerHour} / hr',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 20, fontWeight: FontWeight.w800,
                              )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // About
                  _SectionCard(
                    title: 'About Me',
                    icon: Icons.person_outline_rounded,
                    child: Text(worker.about,
                      style: GoogleFonts.inter(
                        color: TummaColors.textSecondary,
                        fontSize: 14, height: 1.6,
                      )),
                  ),
                  const SizedBox(height: 16),

                  // Services offered
                  _SectionCard(
                    title: 'Services Offered',
                    icon: Icons.build_outlined,
                    child: Column(
                      children: worker.services.map((s) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 36, height: 36,
                              decoration: BoxDecoration(
                                color: TummaColors.tealBg,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.check_rounded,
                                  color: TummaColors.teal, size: 18),
                            ),
                            const SizedBox(width: 12),
                            Text(s, style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              color: TummaColors.textPrimary,
                            )),
                          ],
                        ),
                      )).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Identity verified badge
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: TummaColors.successBg,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: TummaColors.success.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.verified_rounded,
                            color: TummaColors.success, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Identity Verified — Background checked and ID verified by Tumma',
                            style: GoogleFonts.inter(
                              fontSize: 12, color: TummaColors.success,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Book Now CTA
                  TummaButton(
                    label: 'Book Now',
                    icon: Icons.arrow_forward_rounded,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => JobDetailsScreen(worker: worker),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value, label;
  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      children: [
        Text(value, style: GoogleFonts.inter(
          fontSize: 22, fontWeight: FontWeight.w800,
          color: TummaColors.textPrimary,
        )),
        const SizedBox(height: 4),
        Text(label, textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 11, color: TummaColors.textSecondary, height: 1.3,
          )),
      ],
    ),
  );
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  const _SectionCard({required this.title, required this.icon, required this.child});

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: TummaColors.white,
      borderRadius: BorderRadius.circular(TummaTheme.cardRadius),
      border: Border.all(color: TummaColors.cardBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Icon(icon, color: TummaColors.teal, size: 18),
          const SizedBox(width: 8),
          Text(title, style: GoogleFonts.inter(
            fontWeight: FontWeight.w700, fontSize: 15,
            color: TummaColors.textPrimary,
          )),
        ]),
        const SizedBox(height: 14),
        child,
      ],
    ),
  );
}
