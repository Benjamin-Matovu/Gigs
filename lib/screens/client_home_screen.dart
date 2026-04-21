// ============================================================
// lib/screens/client_home_screen.dart
// SCREEN 2: Client Home
// Uses CustomScrollView with Slivers for smooth performance.
// ListView.builder renders the ProCards efficiently —
// only building widgets that are visible on screen.
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/pro_card.dart';
import 'pro_profile_screen.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});
  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  int _selectedCat = -1;

  // Icon map — maps our stored icon codepoints to real Icons
  static const _catIcons = [
    Icons.cleaning_services_rounded,
    Icons.local_shipping_rounded,
    Icons.print_rounded,
    Icons.handyman_rounded,
    Icons.directions_run_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TummaColors.bgLight,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [

            // ── STICKY APP BAR ──────────────────────────────
            SliverToBoxAdapter(
              child: Container(
                color: TummaColors.white,
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                child: Column(
                  children: [
                    // Location + avatar row
                    Row(
                      children: [
                        const Icon(Icons.location_on_rounded,
                            color: TummaColors.teal, size: 18),
                        const SizedBox(width: 4),
                        Text('Kampala',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700, fontSize: 15,
                            color: TummaColors.textPrimary,
                          )),
                        const Icon(Icons.expand_more_rounded,
                            color: TummaColors.textSecondary, size: 18),
                        const Spacer(),
                        Container(
                          width: 38, height: 38,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: TummaColors.tealBg,
                          ),
                          child: const Icon(Icons.person_rounded,
                              color: TummaColors.teal, size: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Search bar
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: TummaColors.bgLight,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: TummaColors.cardBorder),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 14),
                          const Icon(Icons.search_rounded,
                              color: TummaColors.textSecondary, size: 20),
                          const SizedBox(width: 10),
                          Text('What service do you need?',
                            style: GoogleFonts.inter(
                              color: TummaColors.textSecondary, fontSize: 14,
                            )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── PROMO BANNER ────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Container(
                  height: 108,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [TummaColors.teal, TummaColors.tealLight],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(TummaTheme.cardRadius),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('New to Tumma?',
                              style: GoogleFonts.inter(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 12,
                              )),
                            const SizedBox(height: 4),
                            Text('First booking guaranteed',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 17, fontWeight: FontWeight.w700,
                              )),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TummaColors.amber,
                          foregroundColor: TummaColors.dark,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text('Book Now',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700, fontSize: 13,
                          )),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── CATEGORIES HEADING ──────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Categories',
                      style: GoogleFonts.inter(
                        fontSize: 17, fontWeight: FontWeight.w700,
                        color: TummaColors.textPrimary,
                      )),
                    Text('See all',
                      style: GoogleFonts.inter(
                        fontSize: 13, color: TummaColors.teal,
                        fontWeight: FontWeight.w600,
                      )),
                  ],
                ),
              ),
            ),

            // ── CATEGORIES GRID ─────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: MockData.categories.length,
                  itemBuilder: (_, i) {
                    final cat = MockData.categories[i];
                    final selected = _selectedCat == i;
                    final color = Color(cat['color'] as int);
                    return GestureDetector(
                      onTap: () => setState(() => _selectedCat = i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: selected ? color : TummaColors.white,
                          borderRadius: BorderRadius.circular(TummaTheme.cardRadius),
                          border: Border.all(
                            color: selected ? color : TummaColors.cardBorder,
                          ),
                          boxShadow: selected
                              ? [BoxShadow(
                                  color: color.withOpacity(0.3),
                                  blurRadius: 12, offset: const Offset(0, 4))]
                              : [],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 44, height: 44,
                              decoration: BoxDecoration(
                                color: selected
                                    ? Colors.white.withOpacity(0.2)
                                    : color.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(_catIcons[i],
                                  color: selected ? Colors.white : color,
                                  size: 22),
                            ),
                            const SizedBox(height: 8),
                            Text(cat['label'] as String,
                              style: GoogleFonts.inter(
                                fontSize: 12, fontWeight: FontWeight.w600,
                                color: selected
                                    ? Colors.white
                                    : TummaColors.textPrimary,
                              )),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // ── FEATURED PROS HEADING ───────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Featured Pros',
                      style: GoogleFonts.inter(
                        fontSize: 17, fontWeight: FontWeight.w700,
                        color: TummaColors.textPrimary,
                      )),
                    Text('Expert picks',
                      style: GoogleFonts.inter(
                        fontSize: 13, color: TummaColors.teal,
                        fontWeight: FontWeight.w600,
                      )),
                  ],
                ),
              ),
            ),

            // ── WORKERS LIST via ListView.builder ───────────
            // ListView.builder is efficient: it only renders
            // the items currently visible on screen, not all of them.
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, i) => ProCard(
                    worker: MockData.workers[i],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProProfileScreen(
                          worker: MockData.workers[i],
                        ),
                      ),
                    ),
                  ),
                  childCount: MockData.workers.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
