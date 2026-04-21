// ============================================================
// lib/screens/main_shell.dart
// NAVIGATION SHELL — BottomNavigationBar that toggles between
// the 4 main views. This is the "Declarative Navigation"
// approach: the shell decides which screen to show based on
// the selected index, not imperative push/pop calls.
// ============================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_theme.dart';
import 'client_home_screen.dart';
import 'worker_dashboard_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  // The four main views mapped to bottom nav tabs
  static const _screens = [
    ClientHomeScreen(),       // Home — client browsing
    _PlaceholderScreen(label: 'Jobs',     icon: Icons.work_outline_rounded),
    _PlaceholderScreen(label: 'Messages', icon: Icons.chat_bubble_outline_rounded),
    WorkerDashboardScreen(),  // Profile tab shows Worker Dashboard for demo
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack keeps all screens alive in memory so state
      // is preserved when the user switches tabs
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),

      // ── BottomNavigationBar ──────────────────────────────
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: TummaColors.cardBorder)),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (i) => setState(() => _selectedIndex = i),
          type: BottomNavigationBarType.fixed,
          backgroundColor: TummaColors.white,
          selectedItemColor: TummaColors.teal,
          unselectedItemColor: TummaColors.textSecondary,
          selectedLabelStyle: GoogleFonts.inter(
            fontSize: 11, fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: GoogleFonts.inter(fontSize: 11),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work_outline_rounded),
              activeIcon: Icon(Icons.work_rounded),
              label: 'Jobs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline_rounded),
              activeIcon: Icon(Icons.chat_bubble_rounded),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              activeIcon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder for tabs not yet built — shows a clean empty state
class _PlaceholderScreen extends StatelessWidget {
  final String label;
  final IconData icon;
  const _PlaceholderScreen({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TummaColors.bgLight,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: TummaColors.teal.withOpacity(0.3)),
            const SizedBox(height: 12),
            Text('$label coming soon',
              style: GoogleFonts.inter(
                color: TummaColors.textSecondary,
                fontSize: 15,
              )),
          ],
        ),
      ),
    );
  }
}
