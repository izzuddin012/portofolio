import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:devolio_flutter/core/constants/app_constants.dart';
import 'package:devolio_flutter/core/theme/app_colors.dart';
import 'package:devolio_flutter/core/theme/app_typography.dart';
import 'package:devolio_flutter/core/utils/responsive.dart';
import 'package:devolio_flutter/providers.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Nav items: (sectionId, label)
// ─────────────────────────────────────────────────────────────────────────────
const _kNavItems = <(String, String)>[
  ('home',       AppConstants.navHome),
  ('about',      AppConstants.navAbout),
  ('projects',   AppConstants.navProjects),
  ('experience', AppConstants.navExperience),
  ('contact',    AppConstants.navContact),
];

// ─────────────────────────────────────────────────────────────────────────────
// AppNavbar
// ─────────────────────────────────────────────────────────────────────────────
class AppNavbar extends ConsumerStatefulWidget {
  final String activeSection;
  final void Function(String section) onMenuTap;

  const AppNavbar({
    super.key,
    required this.activeSection,
    required this.onMenuTap,
  });

  @override
  ConsumerState<AppNavbar> createState() => _AppNavbarState();
}

class _AppNavbarState extends ConsumerState<AppNavbar> {
  bool _mobileMenuOpen = false;

  void _toggleMobileMenu() =>
      setState(() => _mobileMenuOpen = !_mobileMenuOpen);

  void _handleNavTap(String section) {
    setState(() => _mobileMenuOpen = false);
    widget.onMenuTap(section);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeModeProvider) == ThemeMode.dark;
    final isDesktop = Responsive.isDesktop(context);

    final bg = isDark
        ? AppColors.bg.withValues(alpha: 0.97)
        : AppColors.lightBg.withValues(alpha: 0.97);
    final borderColor =
        isDark ? AppColors.border : AppColors.lightBorder;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Main bar ────────────────────────────────────────────────────────
        Container(
          color: bg,
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 48 : 20,
            vertical: 16,
          ),
          child: Row(
            children: [
              // Logo
              _Logo(onTap: () => _handleNavTap('home'), isDark: isDark),
              const Spacer(),
              if (isDesktop) ...[
                // Desktop nav links
                for (final item in _kNavItems)
                  _NavLink(
                    label: item.$2,
                    isActive: widget.activeSection == item.$1,
                    isDark: isDark,
                    onTap: () => _handleNavTap(item.$1),
                  ),
                const SizedBox(width: 16),
                _GithubBtn(isDark: isDark),
                const SizedBox(width: 8),
                _ThemeBtn(isDark: isDark),
              ] else ...[
                _ThemeBtn(isDark: isDark),
                const SizedBox(width: 4),
                // Hamburger
                IconButton(
                  onPressed: _toggleMobileMenu,
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      _mobileMenuOpen ? Icons.close : Icons.menu,
                      key: ValueKey(_mobileMenuOpen),
                      color: isDark
                          ? AppColors.textSecondary
                          : AppColors.lightTextSecondary,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        // Bottom border
        Container(height: 1, color: borderColor),
        // ── Mobile dropdown ──────────────────────────────────────────────────
        if (!isDesktop)
          ClipRect(
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 240),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              heightFactor: _mobileMenuOpen ? 1.0 : 0.0,
              child: _MobileDrawer(
                items: _kNavItems,
                active: widget.activeSection,
                isDark: isDark,
                onTap: _handleNavTap,
              ),
            ),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Logo
// ─────────────────────────────────────────────────────────────────────────────
class _Logo extends StatefulWidget {
  final VoidCallback onTap;
  final bool isDark;
  const _Logo({required this.onTap, required this.isDark});

  @override
  State<_Logo> createState() => _LogoState();
}

class _LogoState extends State<_Logo> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: AppTypography.navLogo.copyWith(
            color: _hovered
                ? AppColors.accent
                : (widget.isDark
                    ? AppColors.textPrimary
                    : AppColors.lightTextPrimary),
          ),
          child: const Text(AppConstants.firstName),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Desktop nav link
// ─────────────────────────────────────────────────────────────────────────────
class _NavLink extends StatefulWidget {
  final String label;
  final bool isActive;
  final bool isDark;
  final VoidCallback onTap;

  const _NavLink({
    required this.label,
    required this.isActive,
    required this.isDark,
    required this.onTap,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.isActive || _hovered;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            style: (widget.isActive
                    ? AppTypography.navLinkActive
                    : AppTypography.navLink)
                .copyWith(
              color: active
                  ? AppColors.accent
                  : (widget.isDark
                      ? AppColors.textSecondary
                      : AppColors.lightTextSecondary),
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// GitHub button
// ─────────────────────────────────────────────────────────────────────────────
class _GithubBtn extends StatefulWidget {
  final bool isDark;
  const _GithubBtn({required this.isDark});

  @override
  State<_GithubBtn> createState() => _GithubBtnState();
}

class _GithubBtnState extends State<_GithubBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async {
          final uri = Uri.parse(AppConstants.githubUrl);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.accentDim : Colors.transparent,
            border: Border.all(
              color: _hovered ? AppColors.accent : AppColors.border,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'GitHub',
            style: AppTypography.navGithubBtn.copyWith(
              color: _hovered
                  ? AppColors.accent
                  : (widget.isDark
                      ? AppColors.textSecondary
                      : AppColors.lightTextSecondary),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Theme toggle
// ─────────────────────────────────────────────────────────────────────────────
class _ThemeBtn extends ConsumerWidget {
  final bool isDark;
  const _ThemeBtn({required this.isDark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () => ref.read(themeModeProvider.notifier).state =
          isDark ? ThemeMode.light : ThemeMode.dark,
      icon: Icon(
        isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
        size: 18,
        color:
            isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
      ),
      tooltip: isDark ? 'Light mode' : 'Dark mode',
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Mobile dropdown menu
// ─────────────────────────────────────────────────────────────────────────────
class _MobileDrawer extends StatelessWidget {
  final List<(String, String)> items;
  final String active;
  final bool isDark;
  final void Function(String) onTap;

  const _MobileDrawer({
    required this.items,
    required this.active,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isDark ? AppColors.card : AppColors.lightSurface;
    final borderColor = isDark ? AppColors.border : AppColors.lightBorder;

    return Container(
      color: bg,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final item in items) ...[
            InkWell(
              onTap: () => onTap(item.$1),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: borderColor, width: 0.5),
                  ),
                ),
                child: Text(
                  item.$2,
                  style: (active == item.$1
                          ? AppTypography.mobileNavItemActive
                          : AppTypography.mobileNavItem)
                      .copyWith(
                    color: active == item.$1
                        ? AppColors.accent
                        : (isDark
                            ? AppColors.textPrimary
                            : AppColors.lightTextPrimary),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
