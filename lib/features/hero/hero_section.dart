import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:devolio_flutter/core/constants/app_constants.dart';
import 'package:devolio_flutter/core/theme/app_colors.dart';
import 'package:devolio_flutter/core/theme/app_typography.dart';
import 'package:devolio_flutter/core/utils/responsive.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onViewWork;
  final VoidCallback? onViewContact;
  const HeroSection({super.key, this.onViewWork, this.onViewContact});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;
    final isDesktop = Responsive.isDesktop(context);

    // Stats bar is ~110px; hero content fills the rest of the viewport height.
    const double statsBarHeight = 110;

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Main hero content ──────────────────────────────
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: h - statsBarHeight),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1100),
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 48 : 24,
                  vertical: isDesktop ? 0 : 40,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _HeroHeading(isDesktop: isDesktop),
                    SizedBox(height: isDesktop ? 24 : 18),
                    _Tagline(isDesktop: isDesktop),
                    SizedBox(height: isDesktop ? 44 : 32),
                    _CtaRow(
                      onViewWork: onViewWork,
                      onViewContact: onViewContact,
                      isDesktop: isDesktop,
                    ),
                    SizedBox(height: isDesktop ? 64 : 48),
                    _ScrollIndicator(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroHeading extends StatelessWidget {
  final bool isDesktop;
  const _HeroHeading({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Name
        Text(
              AppConstants.firstName,
              textAlign: TextAlign.center,
              style: AppTypography.heroName(isDesktop).copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            )
            .animate()
            .fadeIn(delay: 150.ms, duration: 600.ms)
            .slideY(begin: 0.15, end: 0, delay: 150.ms, duration: 600.ms),
        const SizedBox(height: 6),
        // Role line with accent "="
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '= ',
              style: AppTypography.heroRoleAccent(isDesktop),
            ),
            Text(
              AppConstants.heroRole,
              textAlign: TextAlign.center,
              style: AppTypography.heroRoleText(isDesktop).copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
        ).animate().fadeIn(delay: 300.ms, duration: 600.ms),
      ],
    );
  }
}

class _Tagline extends StatelessWidget {
  final bool isDesktop;
  const _Tagline({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppConstants.heroTagline,
      textAlign: TextAlign.center,
      style: AppTypography.heroTagline(isDesktop),
    ).animate().fadeIn(delay: 450.ms, duration: 600.ms);
  }
}

class _CtaRow extends StatelessWidget {
  final VoidCallback? onViewWork;
  final VoidCallback? onViewContact;
  final bool isDesktop;
  const _CtaRow({this.onViewWork, this.onViewContact, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final ctaButtons = [
      _CtaButton(
        label: AppConstants.ctaViewWork,
        filled: true,
        onTap: onViewWork,
      ),
      _CtaButton(
        label: AppConstants.ctaGithub,
        filled: false,
        onTap: () async {
          final uri = Uri.parse(AppConstants.githubUrl);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
      ),
      _CtaButton(
        label: AppConstants.ctaDownloadCv,
        filled: false,
        onTap: () async {
          final uri = Uri.parse(AppConstants.cvUrl);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
      ),
      _CtaButton(
        label: AppConstants.ctaContact,
        filled: false,
        onTap: onViewContact, // handled externally via scroll
      ),
    ];

    return Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 12,
          children: ctaButtons,
        )
        .animate()
        .fadeIn(delay: 600.ms, duration: 500.ms)
        .slideY(begin: 0.1, end: 0, delay: 600.ms, duration: 500.ms);
  }
}

class _CtaButton extends StatefulWidget {
  final String label;
  final bool filled;
  final VoidCallback? onTap;

  const _CtaButton({required this.label, required this.filled, this.onTap});

  @override
  State<_CtaButton> createState() => _CtaButtonState();
}

class _CtaButtonState extends State<_CtaButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color bg, fg, borderColor;
    if (widget.filled) {
      bg = _hovered ? AppColors.accentLight : AppColors.accent;
      fg = isDark ? AppColors.bg : Colors.white;
      borderColor = bg;
    } else {
      bg = _hovered ? AppColors.accentDim : Colors.transparent;
      fg = _hovered
          ? AppColors.accent
          : (isDark ? AppColors.textSecondary : AppColors.lightTextSecondary);
      borderColor = _hovered ? AppColors.accent : AppColors.border;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          decoration: BoxDecoration(
            color: bg,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            widget.label,
            style: AppTypography.ctaLabel.copyWith(color: fg),
          ),
        ),
      ),
    );
  }
}

class _ScrollIndicator extends StatefulWidget {
  @override
  State<_ScrollIndicator> createState() => _ScrollIndicatorState();
}

class _ScrollIndicatorState extends State<_ScrollIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _bounce;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _bounce = Tween<double>(
      begin: 0,
      end: 6,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _bounce,
      builder: (context, _) => Transform.translate(
        offset: Offset(0, _bounce.value),
        child: Column(
          children: [
            Text(
              'Scroll',
              style: AppTypography.scrollIndicator,
            ),
            const SizedBox(height: 6),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.textMuted,
              size: 18,
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 1000.ms, duration: 600.ms);
  }
}
