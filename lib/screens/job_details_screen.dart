// ============================================================
// lib/screens/job_details_screen.dart
// SCREEN 4: Job Details / Escrow Payment
// Demonstrates the escrow payment flow — the core trust
// mechanism of the Tumma platform.
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_theme.dart';
import '../data/mock_data.dart';
import '../widgets/custom_button.dart';
import '../widgets/tumma_badge.dart';
import '../widgets/star_rating.dart';

class JobDetailsScreen extends StatefulWidget {
  final ProWorker worker;
  const JobDetailsScreen({super.key, required this.worker});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  bool _beforeUploaded = false;
  bool _processing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TummaColors.bgLight,
      appBar: AppBar(
        backgroundColor: TummaColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Job Details'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text('Tumma', style: GoogleFonts.inter(
                fontWeight: FontWeight.w800, fontSize: 16,
                color: TummaColors.teal,
              )),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── JOB CARD ─────────────────────────────────────
            _Card(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TummaBadge(label: 'ACTIVE REQUEST'),
                const SizedBox(height: 12),
                Text('House Cleaning', style: GoogleFonts.inter(
                  fontSize: 24, fontWeight: FontWeight.w800,
                  color: TummaColors.textPrimary, letterSpacing: -0.5,
                )),
                const SizedBox(height: 6),
                Text('Full apartment sanitation and deep\norganisation in Kololo, Kampala.',
                  style: GoogleFonts.inter(
                    fontSize: 14, color: TummaColors.textSecondary, height: 1.5,
                  )),
                const SizedBox(height: 14),
                Row(children: [
                  const Icon(Icons.calendar_today_rounded,
                      color: TummaColors.teal, size: 15),
                  const SizedBox(width: 8),
                  Text('Today, Apr 28 • 10:00 AM',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600, fontSize: 13,
                      color: TummaColors.textPrimary,
                    )),
                ]),
              ],
            )),
            const SizedBox(height: 14),

            // ── WORKER SUMMARY ────────────────────────────────
            _Card(child: Row(
              children: [
                Container(
                  width: 48, height: 48,
                  decoration: BoxDecoration(
                    color: Color(widget.worker.color),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(widget.worker.initials,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w700, fontSize: 15,
                      )),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.worker.name, style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700, fontSize: 15,
                        color: TummaColors.textPrimary,
                      )),
                      Text('${widget.worker.role} • ${widget.worker.jobsCompleted}+ jobs',
                        style: GoogleFonts.inter(
                          fontSize: 12, color: TummaColors.textSecondary,
                        )),
                    ],
                  ),
                ),
                Column(children: [
                  StarRating(rating: widget.worker.rating),
                  const SizedBox(height: 4),
                  TummaBadge(
                    label: widget.worker.badge,
                    isAmber: widget.worker.badge == 'PREMIUM',
                  ),
                ]),
              ],
            )),
            const SizedBox(height: 14),

            // ── ESCROW BANNER ─────────────────────────────────
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
                  Container(
                    width: 42, height: 42,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.shield_rounded,
                        color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ESCROW PROTECTED', style: GoogleFonts.inter(
                          color: Colors.white, fontWeight: FontWeight.w700,
                          fontSize: 12, letterSpacing: 0.5,
                        )),
                        const SizedBox(height: 2),
                        Text('Funds held securely until job is marked complete',
                          style: GoogleFonts.inter(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 12, height: 1.4,
                          )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // ── JOB DOCUMENTATION ─────────────────────────────
            _Card(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Job Documentation', style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700, fontSize: 15,
                      color: TummaColors.textPrimary,
                    )),
                    Text('Built for Trust', style: GoogleFonts.inter(
                      fontSize: 12, color: TummaColors.teal,
                      fontWeight: FontWeight.w600,
                    )),
                  ],
                ),
                const SizedBox(height: 14),
                Row(children: [
                  // Tap to "upload" before photo
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _beforeUploaded = true),
                      child: _PhotoBox(
                        label: 'Before Photo',
                        sub: _beforeUploaded ? 'Uploaded ✓' : 'Tap to upload',
                        icon: _beforeUploaded
                            ? Icons.check_circle_rounded
                            : Icons.add_a_photo_rounded,
                        color: _beforeUploaded
                            ? TummaColors.success
                            : TummaColors.teal,
                        uploaded: _beforeUploaded,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _PhotoBox(
                      label: 'After Photo',
                      sub: 'Unlock at completion',
                      icon: Icons.lock_rounded,
                      color: TummaColors.textSecondary,
                      locked: true,
                    ),
                  ),
                ]),
              ],
            )),
            const SizedBox(height: 14),

            // ── PAYMENT BREAKDOWN ─────────────────────────────
            _Card(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Payment Breakdown', style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700, fontSize: 15,
                  color: TummaColors.textPrimary,
                )),
                const SizedBox(height: 16),
                _PayRow(label: 'Service Fee (Cleaning)', amount: 'UGX 120,000'),
                const Divider(height: 20),
                _PayRow(label: 'Escrow Security', amount: 'UGX 5,000', hasInfo: true),
                const Divider(height: 20),
                _PayRow(label: 'VAT (18%)', amount: 'UGX 22,500'),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: TummaColors.bgLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total to Escrow', style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700, fontSize: 15,
                        color: TummaColors.textPrimary,
                      )),
                      Text('UGX 147,500', style: GoogleFonts.inter(
                        fontWeight: FontWeight.w800, fontSize: 18,
                        color: TummaColors.teal,
                      )),
                    ],
                  ),
                ),
              ],
            )),
            const SizedBox(height: 14),

            // Trust note
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: TummaColors.amberBg,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: TummaColors.amber.withOpacity(0.2)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline_rounded,
                      color: TummaColors.amber, size: 16),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Payment held in Tumma Escrow. Released after you approve completion photos or within 48 hours if no dispute is raised.',
                      style: GoogleFonts.inter(
                        fontSize: 12, color: TummaColors.amber, height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // PAY BUTTON
            TummaButton(
              label: _processing ? 'Processing...' : 'Pay into Escrow',
              style: TummaButtonStyle.amber,
              icon: _processing ? null : Icons.lock_rounded,
              onTap: _processing ? () {} : () => _confirmPayment(context),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text('SECURE VIA AIRTEL & MTN MOBILE MONEY',
                style: GoogleFonts.inter(
                  fontSize: 10, color: TummaColors.textSecondary,
                  letterSpacing: 0.8, fontWeight: FontWeight.w600,
                )),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _confirmPayment(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.all(28),
        decoration: const BoxDecoration(
          color: TummaColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4,
              decoration: BoxDecoration(
                color: TummaColors.cardBorder,
                borderRadius: BorderRadius.circular(2),
              )),
            const SizedBox(height: 24),
            Container(
              width: 64, height: 64,
              decoration: const BoxDecoration(
                color: TummaColors.tealBg, shape: BoxShape.circle,
              ),
              child: const Icon(Icons.shield_rounded,
                  color: TummaColors.teal, size: 30),
            ),
            const SizedBox(height: 16),
            Text('Confirm Escrow Payment', style: GoogleFonts.inter(
              fontWeight: FontWeight.w800, fontSize: 20,
              color: TummaColors.textPrimary,
            )),
            const SizedBox(height: 8),
            Text(
              'UGX 147,500 will be held securely until\n${widget.worker.name} completes the job.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: TummaColors.textSecondary, fontSize: 14, height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            Row(children: [
              Expanded(child: TummaButton(
                label: 'Cancel',
                style: TummaButtonStyle.secondary,
                onTap: () => Navigator.pop(context),
              )),
              const SizedBox(width: 12),
              Expanded(child: TummaButton(
                label: 'Confirm',
                style: TummaButtonStyle.amber,
                onTap: () {
                  Navigator.pop(context);
                  _showSuccess(context);
                },
              )),
            ]),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  void _showSuccess(BuildContext context) {
    setState(() => _processing = true);
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72, height: 72,
                  decoration: const BoxDecoration(
                    color: TummaColors.successBg, shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check_circle_rounded,
                      color: TummaColors.success, size: 40),
                ),
                const SizedBox(height: 20),
                Text('Booking Confirmed!', style: GoogleFonts.inter(
                  fontWeight: FontWeight.w800, fontSize: 20,
                  color: TummaColors.textPrimary,
                )),
                const SizedBox(height: 8),
                Text(
                  'UGX 147,500 safely held in escrow.\n${widget.worker.name} has been notified.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: TummaColors.textSecondary,
                    fontSize: 13, height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                TummaButton(
                  label: 'Done',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    setState(() => _processing = false);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: TummaColors.white,
      borderRadius: BorderRadius.circular(TummaTheme.cardRadius),
      border: Border.all(color: TummaColors.cardBorder),
    ),
    child: child,
  );
}

class _PayRow extends StatelessWidget {
  final String label, amount;
  final bool hasInfo;
  const _PayRow({required this.label, required this.amount, this.hasInfo = false});
  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(children: [
        Text(label, style: GoogleFonts.inter(
          color: TummaColors.textSecondary, fontSize: 14,
        )),
        if (hasInfo) ...[
          const SizedBox(width: 4),
          const Icon(Icons.info_outline_rounded,
              color: TummaColors.textSecondary, size: 13),
        ],
      ]),
      Text(amount, style: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        color: TummaColors.textPrimary, fontSize: 14,
      )),
    ],
  );
}

class _PhotoBox extends StatelessWidget {
  final String label, sub;
  final IconData icon;
  final Color color;
  final bool uploaded, locked;
  const _PhotoBox({
    required this.label, required this.sub,
    required this.icon, required this.color,
    this.uploaded = false, this.locked = false,
  });
  @override
  Widget build(BuildContext context) => Container(
    height: 108,
    decoration: BoxDecoration(
      color: uploaded ? TummaColors.successBg : TummaColors.bgLight,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: uploaded
            ? TummaColors.success.withOpacity(0.3)
            : TummaColors.cardBorder,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(label, style: GoogleFonts.inter(
          fontWeight: FontWeight.w600, fontSize: 12,
          color: TummaColors.textPrimary,
        )),
        Text(sub, style: GoogleFonts.inter(
          fontSize: 11, color: TummaColors.textSecondary,
        )),
      ],
    ),
  );
}
