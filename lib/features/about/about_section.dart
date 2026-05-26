import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:devolio_flutter/core/constants/app_constants.dart';
import 'package:devolio_flutter/core/theme/app_colors.dart';
import 'package:devolio_flutter/core/theme/app_typography.dart';
import 'package:devolio_flutter/core/utils/responsive.dart';
import 'package:devolio_flutter/shared/layout/app_container.dart';
import 'package:devolio_flutter/core/constants/portfolio_content.dart';
import 'package:devolio_flutter/shared/widgets/section_title.dart';

// ── Section ────────────────────────────────────────────────────────────────────

/// Merged About + Skills section.
///
/// Pass [skillsAnchorKey] to keep the navbar "Skills" link functional:
/// the key is placed on the tech-stack sub-column so scroll-to and
/// active-section detection still target the correct position.
class AboutSection extends StatelessWidget {
  final Key? skillsAnchorKey;
  const AboutSection({super.key, this.skillsAnchorKey});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      color: isDark ? AppColors.surface : AppColors.lightCard,
      child: AppContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(
              AppConstants.aboutHeading,
              subtitle: 'Background & technical stack.',
            ),
            const SizedBox(height: 56),
            isDesktop
                ? _DesktopLayout(isDark: isDark, skillsKey: skillsAnchorKey)
                : _MobileLayout(isDark: isDark, skillsKey: skillsAnchorKey),
          ],
        ),
      ),
    );
  }
}

// ── Desktop: side-by-side ──────────────────────────────────────────────────────

class _DesktopLayout extends StatelessWidget {
  final bool isDark;
  final Key? skillsKey;
  const _DesktopLayout({required this.isDark, this.skillsKey});

  @override
  Widget build(BuildContext context) {
    final dividerColor = isDark ? AppColors.border : AppColors.lightBorder;
    // IntrinsicHeight is incompatible with flutter_animate compositing layers,
    // so the divider is drawn as a right-border on the left column's container.
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left — bio / quote / facts
        Expanded(
          flex: 6,
          child: Container(
            padding: const EdgeInsets.only(right: 52),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(color: dividerColor),
              ),
            ),
            child: _AboutContent(isDark: isDark),
          ),
        ),
        // Right — tech stack
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(left: 52),
            child: _SkillsContent(isDark: isDark, anchorKey: skillsKey),
          ),
        ),
      ],
    );
  }
}

// ── Mobile: stacked ───────────────────────────────────────────────────────────

class _MobileLayout extends StatelessWidget {
  final bool isDark;
  final Key? skillsKey;
  const _MobileLayout({required this.isDark, this.skillsKey});

  @override
  Widget build(BuildContext context) {
    final divider = isDark ? AppColors.border : AppColors.lightBorder;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _AboutContent(isDark: isDark),
        const SizedBox(height: 48),
        Container(height: 1, color: divider),
        const SizedBox(height: 48),
        _SkillsContent(isDark: isDark, anchorKey: skillsKey),
      ],
    );
  }
}

// ── About content (bio + quote + quick-facts) ─────────────────────────────────

class _AboutContent extends StatelessWidget {
  final bool isDark;
  const _AboutContent({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final bodyColor = isDark
        ? AppColors.textPrimary
        : AppColors.lightTextPrimary;
    final muteColor = isDark
        ? AppColors.textSecondary
        : AppColors.lightTextSecondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bio
        Text(
          AppConstants.aboutBio1,
          style: AppTypography.bodyLg.copyWith(color: bodyColor),
        ).animate().fadeIn(delay: 200.ms, duration: 500.ms),
        const SizedBox(height: 20),
        Text(
          AppConstants.aboutBio2,
          style: AppTypography.bodyLg.copyWith(color: muteColor),
        ).animate().fadeIn(delay: 300.ms, duration: 500.ms),
        const SizedBox(height: 32),

        // Philosophy quote
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: const BoxDecoration(
            color: AppColors.accentDim,
            border: Border(left: BorderSide(color: AppColors.accent, width: 3)),
          ),
          child: Text(
            AppConstants.aboutApproach,
            style: AppTypography.quote,
          ),
        ).animate().fadeIn(delay: 400.ms, duration: 500.ms),
        const SizedBox(height: 36),

        // Quick facts
        _QuickFacts(isDark: isDark),
      ],
    );
  }
}

class _QuickFacts extends StatelessWidget {
  final bool isDark;
  const _QuickFacts({required this.isDark});

  static const _facts = <(IconData, String)>[
    (Icons.location_on_outlined, AppConstants.location),
    (Icons.work_outline_rounded, AppConstants.heroRole),
    (Icons.circle, AppConstants.availabilityStatus),
  ];

  @override
  Widget build(BuildContext context) {
    final color = isDark
        ? AppColors.textSecondary
        : AppColors.lightTextSecondary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _facts
          .map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Icon(
                    f.$1,
                    size: f.$1 == Icons.circle ? 7 : 15,
                    color: AppColors.accent,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    f.$2,
                    style: AppTypography.bodySm.copyWith(
                      fontWeight: FontWeight.w400,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    ).animate().fadeIn(delay: 500.ms, duration: 400.ms);
  }
}

// ── Tech-stack content ────────────────────────────────────────────────────────

class _SkillsContent extends StatelessWidget {
  final bool isDark;
  final Key? anchorKey;
  const _SkillsContent({required this.isDark, this.anchorKey});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: anchorKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: kTechStack
          .asMap()
          .entries
          .map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: _CategoryBlock(
                title: e.value.$1,
                skills: e.value.$2,
                isDark: isDark,
                delay: Duration(milliseconds: 150 + e.key * 75),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _CategoryBlock extends StatelessWidget {
  final String title;
  final List<String> skills;
  final bool isDark;
  final Duration delay;

  const _CategoryBlock({
    required this.title,
    required this.skills,
    required this.isDark,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category label — small-caps accent
        Text(
          title.toUpperCase(),
          style: AppTypography.categoryLabel,
        ).animate().fadeIn(delay: delay, duration: 350.ms),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skills
              .asMap()
              .entries
              .map(
                (e) => _SkillPill(
                  label: e.value,
                  isDark: isDark,
                  delay: delay + Duration(milliseconds: e.key * 22),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

// ── Skill pill (with hover) ───────────────────────────────────────────────────

class _SkillPill extends StatefulWidget {
  final String label;
  final bool isDark;
  final Duration delay;

  const _SkillPill({
    required this.label,
    required this.isDark,
    required this.delay,
  });

  @override
  State<_SkillPill> createState() => _SkillPillState();
}

class _SkillPillState extends State<_SkillPill> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final bg = widget.isDark
        ? (_hovered ? AppColors.cardHover : AppColors.card)
        : (_hovered ? AppColors.lightBorder : AppColors.lightSurface);
    final border = widget.isDark
        ? (_hovered
              ? AppColors.accent.withValues(alpha: 0.5)
              : AppColors.border)
        : (_hovered
              ? AppColors.accent.withValues(alpha: 0.5)
              : AppColors.lightBorder);
    final text = widget.isDark
        ? (_hovered ? AppColors.textPrimary : AppColors.textSecondary)
        : (_hovered
              ? AppColors.lightTextPrimary
              : AppColors.lightTextSecondary);

    return MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          cursor: SystemMouseCursors.basic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: border),
            ),
            child: Text(
              widget.label,
              style: AppTypography.skillPill.copyWith(color: text),
            ),
          ),
        )
        .animate()
        .fadeIn(delay: widget.delay, duration: 280.ms)
        .slideY(begin: 0.08, end: 0, delay: widget.delay, duration: 280.ms);
  }
}
