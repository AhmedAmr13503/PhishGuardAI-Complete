import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class ConfidenceBar extends StatelessWidget {
  final double confidence;

  const ConfidenceBar({super.key, required this.confidence});

  Color _getConfidenceColor() {
    if (confidence >= 0.8) {
      return Colors.green.shade600;
    } else if (confidence >= 0.5) {
      return Colors.orange.shade700;
    } else {
      return Colors.red.shade600;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final targetColor = _getConfidenceColor();
    final track = Colors.white.withOpacity(0.22);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.insights_rounded, size: 20, color: Colors.white.withOpacity(0.95)),
            const SizedBox(width: 8),
            Text(
              'Confidence',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: confidence.clamp(0.0, 1.0)),
          duration: const Duration(milliseconds: 950),
          curve: Curves.easeOutCubic,
          builder: (context, animatedValue, _) {
            return Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppShapes.radiusXs),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final w = constraints.maxWidth * animatedValue;
                        return Stack(
                          clipBehavior: Clip.hardEdge,
                          alignment: Alignment.centerLeft,
                          children: [
                            Container(height: 12, width: constraints.maxWidth, color: track),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 120),
                              curve: Curves.easeOut,
                              width: w,
                              height: 12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppShapes.radiusXs),
                                gradient: LinearGradient(
                                  colors: [
                                    targetColor.withOpacity(0.75),
                                    targetColor,
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: targetColor.withOpacity(0.35),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Text(
                  '${(animatedValue * 100).toStringAsFixed(1)}%',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: targetColor,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
