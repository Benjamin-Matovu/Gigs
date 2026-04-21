// ============================================================
// lib/main.dart
// ENTRY POINT — Wires the Global Theme to the app and sets
// the OnboardingScreen as the first screen the user sees.
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/app_theme.dart';
import 'screens/onboarding_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Lock to portrait — this is a mobile-first app
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // Make the status bar transparent so content bleeds under it
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const TummaApp());
}

class TummaApp extends StatelessWidget {
  const TummaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tumma',
      debugShowCheckedModeBanner: false,
      // ── Global Theme Provider
      // TummaTheme.theme is defined in lib/core/app_theme.dart.
      // Every widget in the entire app inherits these styles.
      // Change the colours once there — the whole app updates.
      theme: TummaTheme.theme,
      home: const OnboardingScreen(),
    );
  }
}
