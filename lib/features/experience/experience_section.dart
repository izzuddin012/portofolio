import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:devolio_flutter/core/constants/app_constants.dart';
import 'package:devolio_flutter/core/theme/app_colors.dart';
import 'package:devolio_flutter/core/theme/app_typography.dart';
import 'package:devolio_flutter/shared/layout/app_container.dart';
import 'package:devolio_flutter/shared/widgets/section_title.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            AppConstants.experienceHeading,
            subtitle: 'Where I\'ve worked and what I\'ve built.',
          ),
          const SizedBox(height: 52),
          ...experiences.asMap().entries.map(
                (e) => _ExperienceItem(
                  exp: e.value,
                  index: e.key,
                  isLast: e.key == experiences.length - 1,
                ),
              ),
        ],
      ),
    );
  }
}

class _ExperienceItem extends StatelessWidget {
  final Experience exp;
  final int index;
  final bool isLast;

  const _ExperienceItem({
    required this.exp,
    required this.index,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final e = exp;

    return Stack(
      children: [
        // ── Content (drives the Stack height) ──────────────────────────
        Padding(
          padding: EdgeInsets.only(left: 44, bottom: isLast ? 0 : 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                e.role,
                style: AppTypography.expRole.copyWith(
                  color: isDark
                      ? AppColors.textPrimary
                      : AppColors.lightTextPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(e.company, style: AppTypography.expCompany),
                  if (e.location != null)
                    Text(
                      '  ·  ${e.location}',
                      style: AppTypography.expLocation.copyWith(
                        color: isDark
                            ? AppColors.textSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 6),
              _DateBadge(dateRange: e.dateRange),
              const SizedBox(height: 20),
              ...e.achievements.map(
                (a) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        margin: const EdgeInsets.only(top: 7, right: 12),
                        decoration: const BoxDecoration(
                          color: AppColors.accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          a,
                          style: AppTypography.expAchievement.copyWith(
                            color: isDark
                                ? AppColors.textSecondary
                                : AppColors.lightTextSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // ── Timeline dot ───────────────────────────────────────────────
        Positioned(
          left: 5,
          top: 4,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.4),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
        ),

        // ── Timeline connecting line ────────────────────────────────────
        if (!isLast)
          Positioned(
            left: 9,
            top: 18,
            bottom: 0,
            child: Container(
              width: 1,
              color: isDark ? AppColors.border : AppColors.lightBorder,
            ),
          ),
      ],
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 150 * index),
          duration: 500.ms,
        )
        .slideX(
          begin: -0.04,
          end: 0,
          delay: Duration(milliseconds: 150 * index),
          duration: 500.ms,
        );
  }
}

class _DateBadge extends StatelessWidget {
  final String dateRange;
  const _DateBadge({required this.dateRange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.accentDim,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: AppColors.accent.withValues(alpha: 0.2),
        ),
      ),
      child: Text(
        dateRange,
        style: AppTypography.dateBadge,
      ),
    );
  }
}
