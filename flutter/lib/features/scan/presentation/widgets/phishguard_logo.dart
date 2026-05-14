import 'package:flutter/material.dart';

/// PhishGuard brand mark from bundled artwork.
class PhishGuardLogo extends StatelessWidget {
  const PhishGuardLogo({
    super.key,
    this.size = 96,
    this.fit = BoxFit.contain,
  });

  /// Asset path for reuse (tests, precache).
  static const String assetPath = 'assets/images/phishing.png';

  /// Square box side length; image scales with [fit].
  final double size;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'PhishGuard',
      child: SizedBox(
        width: size,
        height: size,
        child: Image.asset(
          assetPath,
          fit: fit,
          filterQuality: FilterQuality.high,
          gaplessPlayback: true,
          errorBuilder: (_, __, ___) => Icon(
            Icons.shield_outlined,
            size: size * 0.85,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
