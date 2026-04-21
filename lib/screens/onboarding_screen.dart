// ============================================================
// lib/screens/onboarding_screen.dart
// SCREEN 1: Onboarding
// Uses Stack to overlay the chip badge on top of the
// illustration area. PageView handles the 3 swipeable pages.
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../core/app_theme.dart';
import '../widgets/custom_button.dart';
import 'main_shell.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;

  static const _pages = [
    _Page(
      icon: Icons.handyman_rounded,
      title: 'Find trusted help\nnear you.',
      subtitle: 'Connect with verified local workers for any task — plumbing, cleaning, moving and more.',
      chip: 'Verified Professionals',
      chipIcon: Icons.verified_rounded,
      isAmber: false,
    ),
    _Page(
      icon: Icons.verified_user_rounded,
      title: 'Every worker\nvouched & verified.',
      subtitle: 'Community vouching, national ID checks, and real ratings from real Kampala residents.',
      chip: 'Community Vouched',
      chipIcon: Icons.people_rounded,
      isAmber: false,
    ),
    _Page(
      icon: Icons.lock_rounded,
      title: 'Pay safely.\nEvery time.',
      subtitle: 'Funds held in escrow until you approve the work. Powered by Airtel Money & MTN.',
      chip: 'Escrow Protected',
      chipIcon: Icons.shield_rounded,
      isAmber: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TummaColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button — only shows on pages 0 and 1
            Align(
              alignment: Alignment.topRight,
              child: _page < 2
                  ? TextButton(
                      onPressed: _goHome,
                      child: Text('Skip',
                        style: GoogleFonts.inter(color: TummaColors.textSecondary)),
                    )
                  : const SizedBox(height: 48),
            ),

            // ── Swipeable page content
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (i) => setState(() => _page = i),
                itemCount: _pages.length,
                itemBuilder: (_, i) => _PageContent(page: _pages[i]),
              ),
            ),

            // ── Bottom controls: dots + buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: Column(
                children: [
                  // Animated dot indicator
                  SmoothPageIndicator(
                    controller: _controller,
                    count: _pages.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: TummaColors.teal,
                      dotColor: TummaColors.teal.withOpacity(0.2),
                      dotHeight: 6, dotWidth: 6,
                      expansionFactor: 4,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Primary CTA — changes label on last page
                  TummaButton(
                    label: _page < 2 ? 'Next' : 'Get Started',
                    icon: _page < 2 ? Icons.arrow_forward_rounded : null,
                    // "Get Started" links to the Home screen
                    onTap: () => _page < 2
                        ? _controller.nextPage(
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeInOut)
                        : _goHome(),
                  ),

                  if (_page == 2) ...[
                    const SizedBox(height: 10),
                    TummaButton(
                      label: 'Sign In',
                      style: TummaButtonStyle.secondary,
                      onTap: _goHome,
                    ),
                  ],

                  const SizedBox(height: 14),
                  Text(
                    'By continuing, you agree to our Terms & Privacy Policy.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 11, color: TummaColors.textSecondary,
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

  void _goHome() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const MainShell(),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }
}

// ── Data class for each onboarding page
class _Page {
  final IconData icon;
  final String title, subtitle, chip;
  final IconData chipIcon;
  final bool isAmber;
  const _Page({
    required this.icon, required this.title, required this.subtitle,
    required this.chip, required this.chipIcon, required this.isAmber,
  });
}

// ── Single page visual content
class _PageContent extends StatelessWidget {
  final _Page page;
  const _PageContent({required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 16),

          // ── Illustration card using Stack to overlay the chip
          // Stack: lets us layer the chip ON TOP of the gradient card
          Expanded(
            flex: 5,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background gradient card
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: page.isAmber
                          ? [TummaColors.amberBg, const Color(0xFFFFF3E0)]
                          : [TummaColors.tealBg, const Color(0xFFE0F7FA)],
                    ),
                    borderRadius: BorderRadius.circular(TummaTheme.cardRadius),
                  ),
                ),

                // Decorative background circles (purely visual)
                Positioned(
                  top: -20, right: -20,
                  child: Container(
                    width: 130, height: 130,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (page.isAmber ? TummaColors.amber : TummaColors.teal)
                          .withOpacity(0.07),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -30, left: -10,
                  child: Container(
                    width: 170, height: 170,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (page.isAmber ? TummaColors.amber : TummaColors.teal)
                          .withOpacity(0.05),
                    ),
                  ),
                ),

                // Centre icon with shadow
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 104, height: 104,
                      decoration: BoxDecoration(
                        color: page.isAmber ? TummaColors.amber : TummaColors.teal,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: (page.isAmber ? TummaColors.amber : TummaColors.teal)
                                .withOpacity(0.35),
                            blurRadius: 32,
                            offset: const Offset(0, 14),
                          ),
                        ],
                      ),
                      child: Icon(page.icon, color: Colors.white, size: 50),
                    ),
                    const SizedBox(height: 24),

                    // ── Positioned chip OVERLAID via Stack
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 16, offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(page.chipIcon, size: 16,
                            color: page.isAmber ? TummaColors.amber : TummaColors.teal),
                          const SizedBox(width: 6),
                          Text(page.chip,
                            style: GoogleFonts.inter(
                              fontSize: 13, fontWeight: FontWeight.w600,
                              color: TummaColors.textPrimary,
                            )),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // Text content
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(page.title,
                  style: GoogleFonts.inter(
                    fontSize: 28, fontWeight: FontWeight.w800,
                    color: TummaColors.textPrimary,
                    letterSpacing: -0.5, height: 1.15,
                  )),
                const SizedBox(height: 10),
                Text(page.subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 15, color: TummaColors.textSecondary, height: 1.6,
                  )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
