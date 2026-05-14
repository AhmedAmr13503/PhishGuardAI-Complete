import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class VerdictCard extends StatelessWidget {
  final String verdict;

  const VerdictCard({super.key, required this.verdict});

  Color _getVerdictColor() {
    switch (verdict.toUpperCase()) {
      case 'SAFE':
        return const Color(0xFF16A34A);
      case 'SUSPICIOUS':
        return Colors.orange.shade800;
      case 'PHISHING':
      case 'DANGEROUS':
        return const Color(0xFFDC2626);
      default:
        return Colors.blueGrey.shade600;
    }
  }

  IconData _getVerdictIcon() {
    switch (verdict.toUpperCase()) {
      case 'SAFE':
        return Icons.verified_rounded;
      case 'SUSPICIOUS':
        return Icons.warning_amber_rounded;
      case 'PHISHING':
      case 'DANGEROUS':
        return Icons.gpp_bad_rounded;
      default:
        return Icons.help_outline_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final color = _getVerdictColor();

    return Card(
      elevation: 2,
      shadowColor: color.withOpacity(0.25),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppShapes.radiusLg),
        side: BorderSide(color: color.withOpacity(0.35)),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppShapes.radiusLg),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.14),
              colorScheme.surface,
            ],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color.withOpacity(0.45), width: 2),
                color: color.withOpacity(0.08),
              ),
              child: Icon(
                _getVerdictIcon(),
                size: 40,
                color: color,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Verdict',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    verdict.toUpperCase(),
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: color,
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _statusLine(verdict),
                    style: theme.textTheme.bodySmall?.copyWith(
                      height: 1.35,
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

  String _statusLine(String v) {
    switch (v.toUpperCase()) {
      case 'SAFE':
        return 'This URL looks consistent with safe browsing patterns.';
      case 'SUSPICIOUS':
        return 'Exercise caution — some signals warrant a closer look.';
      case 'PHISHING':
      case 'DANGEROUS':
        return 'High-risk indicators detected. Avoid entering credentials.';
      default:
        return 'Result could not be classified into a standard category.';
    }
  }
}
