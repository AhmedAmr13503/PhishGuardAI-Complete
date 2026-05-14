import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../data/scan_model.dart';
import '../widgets/confidence_bar.dart';
import '../widgets/glass_panel.dart';
import '../widgets/phishguard_logo.dart';
import '../widgets/risk_badge.dart';
import '../widgets/verdict_card.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.scanResult});

  final ScanModel scanResult;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const PhishGuardLogo(size: 40),
            const SizedBox(width: 8),
            Text(
              'Scan Result',
              style: theme.appBarTheme.titleTextStyle ??
                  theme.textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            VerdictCard(verdict: scanResult.verdict),
            const SizedBox(height: 16),
            GlassPanel(child: ConfidenceBar(confidence: scanResult.confidence)),
            const SizedBox(height: 14),
            GlassPanel(
              child: SizedBox(
                width: double.infinity,
                child: RiskBadge(riskLevel: scanResult.riskLevel),
              ),
            ),
            const SizedBox(height: 22),
            GlassPanel(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionTitle(
                    icon: Icons.link_rounded,
                    label: 'Scanned URL',
                    theme: theme,
                  ),
                  const SizedBox(height: 10),
                  SelectableText(
                    scanResult.url,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            GlassPanel(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionTitle(
                    icon: Icons.memory_rounded,
                    label: 'Engine',
                    theme: theme,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    scanResult.engine.isEmpty ? '—' : scanResult.engine,
                    style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Signals',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            if (scanResult.signals.isEmpty)
              GlassPanel(
                child: Row(
                  children: [
                    Icon(Icons.info_outline_rounded, color: Colors.white.withOpacity(0.75)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'No signals reported',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.88),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
              ...scanResult.signals.map(
                (signal) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GlassPanel(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.flag_rounded, color: Colors.white.withOpacity(0.9), size: 22),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            signal,
                            style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 14),
            GlassPanel(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionTitle(
                    icon: Icons.schedule_rounded,
                    label: 'Scan details',
                    theme: theme,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Scanned: ${scanResult.scannedAt.toLocal()}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withOpacity(0.88),
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
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.icon,
    required this.label,
    required this.theme,
  });

  final IconData icon;
  final String label;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final c = Colors.white.withOpacity(0.92);
    return Row(
      children: [
        Icon(icon, size: 20, color: c),
        const SizedBox(width: 8),
        Text(
          label,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
