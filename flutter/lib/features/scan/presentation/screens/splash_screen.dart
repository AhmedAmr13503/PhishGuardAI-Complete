import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../widgets/phishguard_logo.dart';
import 'home_screen.dart';

/// Branded splash: navy background, white logo and title; then opens [HomeScreen].
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const Duration displayDuration = Duration(milliseconds: 1800);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _goHome());
  }

  Future<void> _goHome() async {
    await Future<void>.delayed(SplashScreen.displayDuration);
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const PhishGuardLogo(size: 170),
              const SizedBox(height: 28),
              Text(
                'PhishGuard',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
