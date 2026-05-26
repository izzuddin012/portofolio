import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:devolio_flutter/core/constants/app_constants.dart';
import 'package:devolio_flutter/core/theme/app_colors.dart';
import 'package:devolio_flutter/core/theme/app_typography.dart';
import 'package:devolio_flutter/core/utils/responsive.dart';

class AppFooter extends StatelessWidget {
  final void Function(String) onNav;
  const AppFooter({super.key, required this.onNav});

  static const _links = [
    ('home', 'Home'),
    ('about', 'About'),
    ('skills', 'Skills'),
    ('projects', 'Projects'),
    ('experience', 'Experience'),
    ('contact', 'Contact'),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      color: isDark ? AppColors.surface : AppColors.lightCard,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 24,
        vertical: 40,
      ),
      child: Column(
        children: [
          Container(
            height: 1,
            color: isDark ? AppColors.border : AppColors.lightBorder,
            margin: const EdgeInsets.only(bottom: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '© ${DateTime.now().year} ${AppConstants.name}',
                style: AppTypography.footerText,
              ),
              Text(
                AppConstants.footerBuilt,
                style: AppTypography.footerText,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterBrand extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppConstants.firstName,
          style: AppTypography.footerBrand.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 6),
        Text(AppConstants.heroRole, style: AppTypography.footerBrandRole),
        const SizedBox(height: 4),
        Text(AppConstants.location, style: AppTypography.footerBrandLocation),
        const SizedBox(height: 16),
        const Row(
          children: [
            _FooterSocial(label: 'GitHub', url: AppConstants.githubUrl),
            SizedBox(width: 14),
            _FooterSocial(label: 'LinkedIn', url: AppConstants.linkedinUrl),
          ],
        ),
      ],
    );
  }
}

class _FooterSocial extends StatefulWidget {
  final String label;
  final String url;
  const _FooterSocial({required this.label, required this.url});

  @override
  State<_FooterSocial> createState() => _FooterSocialState();
}

class _FooterSocialState extends State<_FooterSocial> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: AppTypography.footerNavLink.copyWith(
            color: _hovered ? AppColors.accent : AppColors.textMuted,
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}

class _FooterLinks extends StatelessWidget {
  final List<(String, String)> links;
  final void Function(String) onNav;

  const _FooterLinks({required this.links, required this.onNav});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 12,
      children: links
          .map(
            (l) => GestureDetector(
              onTap: () => onNav(l.$1),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Text(
                  l.$2,
                  style: AppTypography.footerNavLink,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
