import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:devolio_flutter/core/theme/app_colors.dart';
import 'package:devolio_flutter/core/theme/app_typography.dart';

class SectionTitle extends StatelessWidget {
  final String text;
  final String? subtitle;

  const SectionTitle(this.text, {super.key, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 24,
              height: 2,
              color: AppColors.accent,
              margin: const EdgeInsets.only(right: 10),
            ),
            Text(
              text.toUpperCase(),
              style: AppTypography.sectionLabel,
            ),
          ],
        ).animate().fadeIn(duration: 400.ms),
        const SizedBox(height: 14),
        Text(
          text,
          style: AppTypography.sectionHeading.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        )
            .animate()
            .fadeIn(delay: 100.ms, duration: 500.ms)
            .slideY(begin: 0.1, end: 0, delay: 100.ms, duration: 500.ms),
        if (subtitle != null) ...[
          const SizedBox(height: 12),
          Text(
            subtitle!,
            style: AppTypography.sectionSubtitle.copyWith(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.textSecondary
                  : AppColors.lightTextSecondary,
            ),
          ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
        ],
      ],
    );
  }
}
