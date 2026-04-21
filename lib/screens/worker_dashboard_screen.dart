// ============================================================
// lib/screens/worker_dashboard_screen.dart
// SCREEN 5: Worker Dashboard
// Uses Stack + Positioned to overlay the "Nearby Jobs" card
// on top of the map illustration — a common mobile UX pattern
// for surfacing priority info over background visuals.
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/tumma_badge.dart';

class WorkerDashboardScreen extends StatelessWidget {
  const WorkerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = MockData.dashboardData;
    final schedule = data['schedule'] as List;

    return Scaffold(
      backgroundColor: TummaColors.bgLight,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              // ── HEADER ──────────────────────────────────────
              Container(
                color: TummaColors.white,
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                child: Row(
                  children: [
                    const Icon(Icons.location_on_rounded,
                        color: TummaColors.teal, size: 18),
                    const SizedBox(width: 4),
                    Text('Kampala', style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700, fontSize: 15,
                      color: TummaColors.textPrimary,
                    )),
                    const Spacer(),
                    const Icon(Icons.notifications_outlined,
                        color: TummaColors.textSecondary, size: 22),
                    const SizedBox(width: 12),
                    Container(
                      width: 36, height: 36,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: TummaColors.tealBg,
                      ),
                      child: Center(
                        child: Text(data['initials'] as String,
                          style: GoogleFonts.inter(
                            color: TummaColors.teal,
                            fontWeight: FontWeight.w700,
                          )),
                      ),
                    ),
                  ],
                ),
              ),

              // ── MAP + NEARBY JOBS using Stack + Positioned ──
              // Stack: layers widgets on top of each other
              // Positioned: places the card at exact coordinates
              // within the Stack — bottom: 16, left: 16
              Padding(
                padding: const EdgeInsets.all(20),
                child: Stack(
                  children: [
                    // Map illustration background
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(TummaTheme.cardRadius),
                        gradient: LinearGradient(
                          colors: [
                            TummaColors.teal.withOpacity(0.8),
                            TummaColors.tealLight.withOpacity(0.6),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Stack(
                        children: [
                          // Grid pattern to simulate map
                          CustomPaint(
                            size: const Size(double.infinity, 200),
                            painter: _MapGridPainter(),
                          ),
                          // Map pin icons scattered across the map
                          ..._mapPins.map((pin) => Positioned(
                            left: pin[0], top: pin[1],
                            child: Icon(Icons.location_pin,
                                color: Colors.white.withOpacity(0.9),
                                size: pin[2]),
                          )),
                          // Current location dot
                          const Positioned(
                            right: 16, bottom: 16,
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.my_location_rounded,
                                  color: TummaColors.teal, size: 18),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ── Positioned card OVERLAID on the map
                    Positioned(
                      bottom: 16, left: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 16, offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('NEARBY JOBS', style: GoogleFonts.inter(
                              fontSize: 9, fontWeight: FontWeight.w700,
                              color: TummaColors.textSecondary,
                              letterSpacing: 1,
                            )),
                            Text('${data['nearbyJobs']} Tasks Available',
                              style: GoogleFonts.inter(
                                fontSize: 15, fontWeight: FontWeight.w800,
                                color: TummaColors.textPrimary,
                              )),
                            Text('Within 5km of your location',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                color: TummaColors.textSecondary,
                              )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── VERIFIED PRO PROGRESS ────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [TummaColors.teal, TummaColors.tealLight],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(TummaTheme.cardRadius),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Complete your profile',
                            style: GoogleFonts.inter(
                              color: Colors.white, fontWeight: FontWeight.w700,
                              fontSize: 15,
                            )),
                          const Icon(Icons.verified_rounded,
                              color: TummaColors.amber, size: 22),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text("Unlock 'Verified Pro' to get 3x more requests",
                        style: GoogleFonts.inter(
                          color: Colors.white.withOpacity(0.8), fontSize: 12,
                        )),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('PROGRESS: 75%', style: GoogleFonts.inter(
                            color: Colors.white, fontSize: 11,
                            fontWeight: FontWeight.w600, letterSpacing: 0.5,
                          )),
                          Text('1 STEP LEFT', style: GoogleFonts.inter(
                            color: TummaColors.amber, fontSize: 11,
                            fontWeight: FontWeight.w700,
                          )),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: LinearProgressIndicator(
                          value: data['profileProgress'] as double,
                          backgroundColor: Colors.white.withOpacity(0.2),
                          valueColor: const AlwaysStoppedAnimation(
                              TummaColors.amber),
                          minHeight: 8,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text('Upload ID Verification',
                            style: GoogleFonts.inter(
                              color: TummaColors.teal,
                              fontWeight: FontWeight.w700, fontSize: 13,
                            )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // ── EARNINGS + ACTIVE JOBS ────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(child: _MetricCard(
                      label: 'WEEKLY TOTAL',
                      value: data['weeklyEarnings'] as String,
                      sub: data['earningsGrowth'] as String,
                      subColor: TummaColors.success,
                      subIcon: Icons.trending_up_rounded,
                    )),
                    const SizedBox(width: 12),
                    Expanded(child: _MetricCard(
                      label: 'ACTIVE JOBS',
                      value: '${data['activeTasks']} Tasks',
                      sub: 'Next due: ${data['nextTask']}',
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // ── SCHEDULE ─────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your Schedule', style: GoogleFonts.inter(
                      fontSize: 17, fontWeight: FontWeight.w700,
                      color: TummaColors.textPrimary,
                    )),
                    const SizedBox(height: 12),

                    // ListView would be used here in a larger list
                    // For 2 items we use Column directly
                    ...schedule.map((job) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _ScheduleCard(job: job as Map<String, dynamic>),
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // ── PERFORMANCE ──────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: TummaColors.white,
                    borderRadius: BorderRadius.circular(TummaTheme.cardRadius),
                    border: Border.all(color: TummaColors.cardBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Performance Overview', style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700, fontSize: 15,
                            color: TummaColors.textPrimary,
                          )),
                          const Icon(Icons.bar_chart_rounded,
                              color: TummaColors.teal, size: 20),
                        ],
                      ),
                      const SizedBox(height: 14),
                      _PerfRow(
                        icon: Icons.star_rounded,
                        color: TummaColors.amber,
                        label: '${data['rating']} Rating',
                        sub: data['ratingRank'] as String,
                      ),
                      const Divider(height: 20),
                      const _PerfRow(
                        icon: Icons.account_balance_wallet_rounded,
                        color: TummaColors.teal,
                        label: 'Payouts',
                        sub: 'Next: Monday, Apr 28',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Map pin positions [left, top, size]
  static const _mapPins = [
    [60.0, 30.0, 28.0],
    [160.0, 50.0, 22.0],
    [260.0, 20.0, 26.0],
    [100.0, 100.0, 20.0],
    [220.0, 110.0, 24.0],
  ];
}

// ── Map grid painter (purely decorative)
class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }
  @override
  bool shouldRepaint(_) => false;
}

class _MetricCard extends StatelessWidget {
  final String label, value, sub;
  final Color subColor;
  final IconData? subIcon;
  const _MetricCard({
    required this.label, required this.value, required this.sub,
    this.subColor = TummaColors.textSecondary, this.subIcon,
  });
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: TummaColors.white,
      borderRadius: BorderRadius.circular(TummaTheme.cardRadius),
      border: Border.all(color: TummaColors.cardBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(
          fontSize: 10, fontWeight: FontWeight.w700,
          color: TummaColors.textSecondary, letterSpacing: 1,
        )),
        const SizedBox(height: 6),
        Text(value, style: GoogleFonts.inter(
          fontSize: 17, fontWeight: FontWeight.w800,
          color: TummaColors.textPrimary,
        )),
        const SizedBox(height: 4),
        Row(children: [
          if (subIcon != null) Icon(subIcon, color: subColor, size: 13),
          if (subIcon != null) const SizedBox(width: 3),
          Flexible(child: Text(sub, style: GoogleFonts.inter(
            fontSize: 11, color: subColor, fontWeight: FontWeight.w600,
          ))),
        ]),
      ],
    ),
  );
}

class _ScheduleCard extends StatelessWidget {
  final Map<String, dynamic> job;
  const _ScheduleCard({required this.job});
  @override
  Widget build(BuildContext context) {
    final isActive = job['status'] == 'IN PROGRESS';
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: TummaColors.white,
        borderRadius: BorderRadius.circular(TummaTheme.cardRadius),
        border: Border.all(color: TummaColors.cardBorder),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TummaBadge(
                  label: job['status'] as String,
                  isSuccess: isActive,
                  isAmber: !isActive,
                ),
                const SizedBox(height: 8),
                Text(job['title'] as String, style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700, fontSize: 15,
                  color: TummaColors.textPrimary,
                )),
                const SizedBox(height: 4),
                Row(children: [
                  const Icon(Icons.location_on_outlined,
                      size: 13, color: TummaColors.textSecondary),
                  const SizedBox(width: 3),
                  Text(job['location'] as String, style: GoogleFonts.inter(
                    fontSize: 12, color: TummaColors.textSecondary,
                  )),
                ]),
                const SizedBox(height: 4),
                Row(children: [
                  const Icon(Icons.access_time_rounded,
                      size: 13, color: TummaColors.textSecondary),
                  const SizedBox(width: 3),
                  Text(job['time'] as String, style: GoogleFonts.inter(
                    fontSize: 12, color: TummaColors.textSecondary,
                  )),
                ]),
              ],
            ),
          ),
          Text(job['amount'] as String, style: GoogleFonts.inter(
            fontWeight: FontWeight.w800, fontSize: 15,
            color: TummaColors.teal,
          )),
        ],
      ),
    );
  }
}

class _PerfRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label, sub;
  const _PerfRow({
    required this.icon, required this.color,
    required this.label, required this.sub,
  });
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        width: 38, height: 38,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: GoogleFonts.inter(
              fontWeight: FontWeight.w600, fontSize: 14,
              color: TummaColors.textPrimary,
            )),
            Text(sub, style: GoogleFonts.inter(
              fontSize: 12, color: TummaColors.textSecondary,
            )),
          ],
        ),
      ),
      const Icon(Icons.chevron_right_rounded,
          color: TummaColors.textSecondary),
    ],
  );
}
