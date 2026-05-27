import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:devolio_flutter/core/constants/app_constants.dart';
import 'package:devolio_flutter/core/theme/app_colors.dart';
import 'package:devolio_flutter/core/theme/app_typography.dart';
import 'package:devolio_flutter/core/utils/responsive.dart';
import 'package:devolio_flutter/shared/layout/app_container.dart';
import 'package:devolio_flutter/shared/widgets/section_title.dart';

final _filterProvider = StateProvider<ProjectCategory>(
  (ref) => ProjectCategory.all,
);

class ProjectsSection extends ConsumerWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(_filterProvider);
    final filtered = selected == ProjectCategory.all
        ? projects
        : projects.where((p) => p.category == selected).toList();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      color: isDark ? AppColors.surface : AppColors.lightCard,
      child: AppContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Expanded(
                  child: SectionTitle(
                    AppConstants.projectsHeading,
                    subtitle: 'Things I\'ve built and shipped.',
                  ),
                ),
                if (isDesktop) _FilterBar(selected: selected, ref: ref),
              ],
            ),
            if (!isDesktop) ...[
              const SizedBox(height: 24),
              _FilterBar(selected: selected, ref: ref),
            ],
            const SizedBox(height: 48),
            isDesktop
                ? _DesktopGrid(projects: filtered)
                : _MobileList(projects: filtered),
          ],
        ),
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  final ProjectCategory selected;
  final WidgetRef ref;
  const _FilterBar({required this.selected, required this.ref});

  static const _filters = [
    (ProjectCategory.all, 'All'),
    (ProjectCategory.mobile, 'Mobile'),
    (ProjectCategory.web, 'Web'),
    (ProjectCategory.backend, 'Backend'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _filters
            .map(
              (f) => Padding(
                padding: const EdgeInsets.only(left: 8),
                child: _Chip(
                  label: f.$2,
                  isSelected: selected == f.$1,
                  onTap: () => ref.read(_filterProvider.notifier).state = f.$1,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  const _Chip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.accent : Colors.transparent,
            border: Border.all(
              color: isSelected
                  ? AppColors.accent
                  : (isDark ? AppColors.border : AppColors.lightBorder),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: AppTypography.filterChip.copyWith(
              color: isSelected
                  ? Colors.white
                  : (isDark
                      ? AppColors.textSecondary
                      : AppColors.lightTextSecondary),
            ),
          ),
        ),
      ),
    );
  }
}

class _DesktopGrid extends StatelessWidget {
  final List<Project> projects;
  const _DesktopGrid({required this.projects});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    final cols = w > 1200 ? 3 : 2;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cols,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        mainAxisExtent: 440,
      ),
      itemCount: projects.length,
      itemBuilder: (_, i) => ProjectCard(
        project: projects[i],
        delay: Duration(milliseconds: i * 70),
      ),
    );
  }
}

class _MobileList extends StatelessWidget {
  final List<Project> projects;
  const _MobileList({required this.projects});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: projects
          .asMap()
          .entries
          .map(
            (e) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ProjectCard(
                project: e.value,
                delay: Duration(milliseconds: e.key * 70),
              ),
            ),
          )
          .toList(),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final Project project;
  final Duration delay;
  const ProjectCard({
    super.key,
    required this.project,
    this.delay = Duration.zero,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;

  // Cycle through accent-derived colors for thumbnail tint
  static const _tints = [
    AppColors.accent,
    AppColors.warm,
    AppColors.tintSlate,
    AppColors.tintTaupe,
    AppColors.accentLight,
    AppColors.tintOlive,
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final p = widget.project;
    final tint = _tints[projects.indexOf(p) % _tints.length];

    return MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(
            onTap: () => _openDetail(context, tint),
            child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: isDark ? AppColors.card : AppColors.lightSurface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _hovered
                    ? AppColors.accent.withValues(alpha: 0.5)
                    : (isDark ? AppColors.border : AppColors.lightBorder),
              ),
              boxShadow: _hovered
                  ? [
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.08),
                        blurRadius: 24,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Thumbnail
                _Thumbnail(
                  category: p.category,
                  tint: tint,
                  hovered: _hovered,
                  imageUrl: p.images.isNotEmpty ? p.images.first : null,
                ),
                // Content
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              p.title,
                              style: AppTypography.cardTitle.copyWith(
                                color: isDark
                                    ? AppColors.textPrimary
                                    : AppColors.lightTextPrimary,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (p.appStoreUrl != null)
                                _IconLink(
                                  icon: Icons.apple_rounded,
                                  url: p.appStoreUrl!,
                                  tooltip: 'App Store',
                                ),
                              if (p.playStoreUrl != null)
                                _IconLink(
                                  icon: Icons.android_rounded,
                                  url: p.playStoreUrl!,
                                  tooltip: 'Play Store',
                                ),
                              if (p.githubUrl != null)
                                _IconLink(
                                  icon: Icons.code_rounded,
                                  url: p.githubUrl!,
                                  tooltip: 'Source code',
                                ),
                              if (p.demoUrl != null)
                                _IconLink(
                                  icon: Icons.open_in_new_rounded,
                                  url: p.demoUrl!,
                                  tooltip: 'Live demo',
                                ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        p.description,
                        style: AppTypography.cardDesc.copyWith(
                          color: isDark
                              ? AppColors.textSecondary
                              : AppColors.lightTextSecondary,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: p.techStack
                            .map((t) => _TechTag(label: t))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        )
        .animate()
        .fadeIn(delay: widget.delay, duration: 400.ms)
        .slideY(begin: 0.08, end: 0, delay: widget.delay, duration: 400.ms);
  }

  void _openDetail(BuildContext context, Color tint) {
    showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Close',
      barrierColor: Colors.black.withValues(alpha: 0.65),
      transitionDuration: const Duration(milliseconds: 280),
      pageBuilder: (ctx, _, __) =>
          _ProjectDetailSheet(project: widget.project, tint: tint),
      transitionBuilder: (ctx, anim, _, child) => FadeTransition(
        opacity: anim,
        child: ScaleTransition(
          scale: Tween(begin: 0.94, end: 1.0).animate(
            CurvedAnimation(parent: anim, curve: Curves.easeOutCubic),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  final ProjectCategory category;
  final Color tint;
  final bool hovered;
  final String? imageUrl;

  const _Thumbnail({
    required this.category,
    required this.tint,
    required this.hovered,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final tintBox = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 200,
      decoration: BoxDecoration(
        color: hovered
            ? tint.withValues(alpha: 0.2)
            : tint.withValues(alpha: 0.12),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Center(
        child: Icon(
          _projectCatIcon(category),
          size: 36,
          color: tint.withValues(alpha: hovered ? 0.9 : 0.6),
        ),
      ),
    );

    if (imageUrl == null) return tintBox;

    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        child: Image.network(
          imageUrl!,
          fit: BoxFit.cover,
          loadingBuilder: (_, child, progress) =>
              progress == null ? child : tintBox,
          errorBuilder: (_, __, ___) => tintBox,
        ),
      ),
    );
  }
}

class _IconLink extends StatelessWidget {
  final IconData icon;
  final String url;
  final String tooltip;
  const _IconLink({
    required this.icon,
    required this.url,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Builder(builder: (context) {
            final isDark = Theme.of(context).brightness == Brightness.dark;
            return Icon(
              icon,
              size: 16,
              color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
            );
          }),
        ),
      ),
    );
  }
}

class _TechTag extends StatelessWidget {
  final String label;
  const _TechTag({required this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surface : AppColors.lightCard,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isDark ? AppColors.border : AppColors.lightBorder,
        ),
      ),
      child: Text(
        label,
        style: AppTypography.techTag.copyWith(
          color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
        ),
      ),
    );
  }
}

// ── Shared category helpers ────────────────────────────────────────────────────

String _projectCatLabel(ProjectCategory c) => switch (c) {
      ProjectCategory.mobile  => 'MOBILE',
      ProjectCategory.web     => 'WEB',
      ProjectCategory.backend => 'BACKEND',
      ProjectCategory.all     => 'PROJECT',
    };

IconData _projectCatIcon(ProjectCategory c) => switch (c) {
      ProjectCategory.mobile  => Icons.phone_iphone_rounded,
      ProjectCategory.web     => Icons.language_rounded,
      ProjectCategory.backend => Icons.storage_rounded,
      ProjectCategory.all     => Icons.apps_rounded,
    };

// ── Project detail modal ───────────────────────────────────────────────────────

class _ProjectDetailSheet extends StatelessWidget {
  final Project project;
  final Color tint;
  const _ProjectDetailSheet({required this.project, required this.tint});

  @override
  Widget build(BuildContext context) {
    final isDark   = Theme.of(context).brightness == Brightness.dark;
    final screenH  = MediaQuery.sizeOf(context).height;
    final bg       = isDark ? AppColors.card       : AppColors.lightSurface;
    final divColor = isDark ? AppColors.border      : AppColors.lightBorder;
    final onSurface = isDark ? AppColors.textPrimary : AppColors.lightTextPrimary;
    final secondary = isDark ? AppColors.textSecondary : AppColors.lightTextSecondary;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 680, maxHeight: screenH * 0.88),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            color: bg,
            child: Stack(
              children: [
                // ── Scrollable content ─────────────────────────────────────
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Gallery header (images carousel or tint-icon fallback)
                    _GalleryHeader(
                      images: project.images,
                      tint: tint,
                      category: project.category,
                      borderColor: divColor,
                    ),
                    // Body
                    Flexible(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(32, 28, 32, 36),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Category badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppColors.accentDim,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: AppColors.accent.withValues(alpha: 0.3),
                                ),
                              ),
                              child: Text(
                                _projectCatLabel(project.category),
                                style: AppTypography.categoryLabel,
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Title
                            Text(
                              project.title,
                              style: AppTypography.successTitle.copyWith(
                                color: onSurface,
                              ),
                            ),
                            const SizedBox(height: 18),

                            // Description
                            Text(
                              project.description,
                              style: AppTypography.bodyMd.copyWith(
                                color: secondary,
                              ),
                            ),

                            // My Contribution
                            if (project.contribution.isNotEmpty) ...[
                              const SizedBox(height: 28),
                              _Divider(color: divColor),
                              const SizedBox(height: 24),
                              Text(
                                'MY CONTRIBUTION',
                                style: AppTypography.categoryLabel,
                              ),
                              const SizedBox(height: 16),
                              ...project.contribution.map(
                                (item) => Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 5,
                                        height: 5,
                                        margin: const EdgeInsets.only(
                                            top: 7, right: 12),
                                        decoration: const BoxDecoration(
                                          color: AppColors.accent,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          item,
                                          style: AppTypography.bodyMd
                                              .copyWith(color: secondary),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],

                            // Tech Stack
                            const SizedBox(height: 28),
                            _Divider(color: divColor),
                            const SizedBox(height: 24),
                            Text(
                              'TECH STACK',
                              style: AppTypography.categoryLabel,
                            ),
                            const SizedBox(height: 14),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: project.techStack.map((t) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? AppColors.surface
                                        : AppColors.lightCard,
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: divColor),
                                  ),
                                  child: Text(
                                    t,
                                    style: AppTypography.skillPill
                                        .copyWith(color: secondary),
                                  ),
                                );
                              }).toList(),
                            ),

                            // Action buttons (store / github / demo)
                            if (project.appStoreUrl != null ||
                                project.playStoreUrl != null ||
                                project.githubUrl != null ||
                                project.demoUrl != null) ...[
                              const SizedBox(height: 28),
                              Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: [
                                  if (project.appStoreUrl != null)
                                    _DetailActionBtn(
                                      label: 'APP STORE',
                                      icon: Icons.apple_rounded,
                                      url: project.appStoreUrl!,
                                      filled: true,
                                    ),
                                  if (project.playStoreUrl != null)
                                    _DetailActionBtn(
                                      label: 'PLAY STORE',
                                      icon: Icons.android_rounded,
                                      url: project.playStoreUrl!,
                                      filled: true,
                                    ),
                                  if (project.githubUrl != null)
                                    _DetailActionBtn(
                                      label: 'VIEW SOURCE',
                                      icon: Icons.code_rounded,
                                      url: project.githubUrl!,
                                    ),
                                  if (project.demoUrl != null)
                                    _DetailActionBtn(
                                      label: 'LIVE DEMO',
                                      icon: Icons.open_in_new_rounded,
                                      url: project.demoUrl!,
                                      filled: true,
                                    ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // ── Close button ───────────────────────────────────────────
                const Positioned(
                  top: 12,
                  right: 12,
                  child: _DetailCloseBtn(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  final Color color;
  const _Divider({required this.color});

  @override
  Widget build(BuildContext context) =>
      Container(height: 1, color: color);
}

// ── Close button ──────────────────────────────────────────────────────────────

class _DetailCloseBtn extends StatefulWidget {
  const _DetailCloseBtn();

  @override
  State<_DetailCloseBtn> createState() => _DetailCloseBtnState();
}

class _DetailCloseBtnState extends State<_DetailCloseBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: _hovered
                ? (isDark ? AppColors.cardHover : AppColors.lightBorder)
                : Colors.black.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.close_rounded,
            size: 16,
            color: isDark ? AppColors.textPrimary : AppColors.lightTextPrimary,
          ),
        ),
      ),
    );
  }
}

// ── Action button (View Source / Live Demo) ───────────────────────────────────

class _DetailActionBtn extends StatefulWidget {
  final String label;
  final IconData icon;
  final String url;
  final bool filled;
  const _DetailActionBtn({
    required this.label,
    required this.icon,
    required this.url,
    this.filled = false,
  });

  @override
  State<_DetailActionBtn> createState() => _DetailActionBtnState();
}

class _DetailActionBtnState extends State<_DetailActionBtn> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color bg, fg, border;
    if (widget.filled) {
      bg     = _hovered ? AppColors.accentLight : AppColors.accent;
      fg     = Colors.white;
      border = bg;
    } else {
      bg     = _hovered ? AppColors.accentDim : Colors.transparent;
      fg     = _hovered
          ? AppColors.accent
          : (isDark ? AppColors.textSecondary : AppColors.lightTextSecondary);
      border = _hovered
          ? AppColors.accent
          : (isDark ? AppColors.border : AppColors.lightBorder);
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 14, color: fg),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: AppTypography.ctaLabel.copyWith(color: fg),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Gallery header ─────────────────────────────────────────────────────────────
//  Shows a PageView carousel when images are provided; falls back to the tint
//  icon header otherwise.  Lives at the top of _ProjectDetailSheet.

class _GalleryHeader extends StatefulWidget {
  final List<String> images;
  final Color tint;
  final ProjectCategory category;
  final Color borderColor;

  const _GalleryHeader({
    required this.images,
    required this.tint,
    required this.category,
    required this.borderColor,
  });

  @override
  State<_GalleryHeader> createState() => _GalleryHeaderState();
}

class _GalleryHeaderState extends State<_GalleryHeader> {
  late final PageController _ctrl;
  int _current = 0;
  bool _arrowsVisible = false;

  @override
  void initState() {
    super.initState();
    _ctrl = PageController();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ── Tint-icon fallback (no images) ────────────────────────────────────
    if (widget.images.isEmpty) {
      return Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.tint.withValues(alpha: 0.15),
          border: Border(bottom: BorderSide(color: widget.borderColor)),
        ),
        child: Center(
          child: Icon(
            _projectCatIcon(widget.category),
            size: 52,
            color: widget.tint.withValues(alpha: 0.65),
          ),
        ),
      );
    }

    // ── Image carousel ────────────────────────────────────────────────────
    return MouseRegion(
      onEnter: (_) => setState(() => _arrowsVisible = true),
      onExit: (_) => setState(() => _arrowsVisible = false),
      child: Container(
        height: 280,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: widget.borderColor)),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ── Swipeable images ──────────────────────────────────────────
            PageView.builder(
              controller: _ctrl,
              itemCount: widget.images.length,
              onPageChanged: (i) => setState(() => _current = i),
              itemBuilder: (ctx, i) => GestureDetector(
                onTap: () => _openLightbox(ctx, i),
                child: Image.network(
                  widget.images[i],
                  fit: BoxFit.cover,
                  loadingBuilder: (_, child, progress) => progress == null
                      ? child
                      : Container(
                          color: widget.tint.withValues(alpha: 0.12),
                          child: const Center(
                            child: SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 1.5,
                                color: AppColors.accent,
                              ),
                            ),
                          ),
                        ),
                  errorBuilder: (_, __, ___) => Container(
                    color: widget.tint.withValues(alpha: 0.12),
                    child: Center(
                      child: Icon(
                        _projectCatIcon(widget.category),
                        size: 48,
                        color: widget.tint.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // ── "Tap to expand" hint ─────────────────────────────────────
            Positioned(
              bottom: widget.images.length > 1 ? 38 : 10,
              right: 12,
              child: AnimatedOpacity(
                opacity: _arrowsVisible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 150),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Tap to expand',
                    style: AppTypography.contactMetaLabel
                        .copyWith(color: Colors.white, letterSpacing: 0.3),
                  ),
                ),
              ),
            ),

            // ── Page dots ─────────────────────────────────────────────────
            if (widget.images.length > 1)
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: _PageDots(
                  count: widget.images.length,
                  current: _current,
                ),
              ),

            // ── Prev / Next arrows ────────────────────────────────────────
            if (widget.images.length > 1) ...[
              Positioned(
                left: 12,
                top: 0,
                bottom: 0,
                child: Center(
                  child: AnimatedOpacity(
                    opacity: (_arrowsVisible && _current > 0) ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 150),
                    child: _GalleryArrow(
                      left: true,
                      onTap: () => _ctrl.previousPage(
                        duration: const Duration(milliseconds: 280),
                        curve: Curves.easeInOut,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 12,
                top: 0,
                bottom: 0,
                child: Center(
                  child: AnimatedOpacity(
                    opacity: (_arrowsVisible &&
                            _current < widget.images.length - 1)
                        ? 1.0
                        : 0.0,
                    duration: const Duration(milliseconds: 150),
                    child: _GalleryArrow(
                      left: false,
                      onTap: () => _ctrl.nextPage(
                        duration: const Duration(milliseconds: 280),
                        curve: Curves.easeInOut,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _openLightbox(BuildContext context, int startIndex) {
    showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Close lightbox',
      barrierColor: Colors.black.withValues(alpha: 0.92),
      transitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (ctx, _, __) => _LightboxDialog(
        images: widget.images,
        initialIndex: startIndex,
      ),
      transitionBuilder: (ctx, anim, _, child) =>
          FadeTransition(opacity: anim, child: child),
    );
  }
}

// ── Page dots indicator ────────────────────────────────────────────────────────

class _PageDots extends StatelessWidget {
  final int count;
  final int current;
  const _PageDots({required this.count, required this.current});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: active ? 18.0 : 6.0,
          height: 6,
          decoration: BoxDecoration(
            color: active
                ? Colors.white
                : Colors.white.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}

// ── Gallery prev / next arrow ──────────────────────────────────────────────────

class _GalleryArrow extends StatefulWidget {
  final bool left;
  final VoidCallback onTap;
  const _GalleryArrow({required this.left, required this.onTap});

  @override
  State<_GalleryArrow> createState() => _GalleryArrowState();
}

class _GalleryArrowState extends State<_GalleryArrow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: _hovered
                ? Colors.black.withValues(alpha: 0.75)
                : Colors.black.withValues(alpha: 0.45),
            shape: BoxShape.circle,
          ),
          child: Icon(
            widget.left
                ? Icons.chevron_left_rounded
                : Icons.chevron_right_rounded,
            color: Colors.white,
            size: 22,
          ),
        ),
      ),
    );
  }
}

// ── Full-screen image lightbox ─────────────────────────────────────────────────

class _LightboxDialog extends StatefulWidget {
  final List<String> images;
  final int initialIndex;
  const _LightboxDialog({required this.images, required this.initialIndex});

  @override
  State<_LightboxDialog> createState() => _LightboxDialogState();
}

class _LightboxDialogState extends State<_LightboxDialog> {
  late final PageController _ctrl;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _current = widget.initialIndex;
    _ctrl = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // ── Swipeable full-res images ─────────────────────────────────
          PageView.builder(
            controller: _ctrl,
            itemCount: widget.images.length,
            onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (ctx, i) => InteractiveViewer(
              minScale: 1.0,
              maxScale: 4.0,
              child: Center(
                child: Image.network(
                  widget.images[i],
                  fit: BoxFit.contain,
                  loadingBuilder: (_, child, progress) => progress == null
                      ? child
                      : const Center(
                          child: SizedBox(
                            width: 28,
                            height: 28,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.accent,
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),

          // ── Close ─────────────────────────────────────────────────────
          const Positioned(
            top: 16,
            right: 16,
            child: _DetailCloseBtn(),
          ),

          // ── Image counter  e.g. "2 / 5" ──────────────────────────────
          if (widget.images.length > 1)
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${_current + 1} / ${widget.images.length}',
                    style: AppTypography.contactMetaLabel
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),

          // ── Prev / Next arrows ────────────────────────────────────────
          if (widget.images.length > 1) ...[
            if (_current > 0)
              Positioned(
                left: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: _GalleryArrow(
                    left: true,
                    onTap: () => _ctrl.previousPage(
                      duration: const Duration(milliseconds: 280),
                      curve: Curves.easeInOut,
                    ),
                  ),
                ),
              ),
            if (_current < widget.images.length - 1)
              Positioned(
                right: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: _GalleryArrow(
                    left: false,
                    onTap: () => _ctrl.nextPage(
                      duration: const Duration(milliseconds: 280),
                      curve: Curves.easeInOut,
                    ),
                  ),
                ),
              ),
          ],

          // ── Dots ──────────────────────────────────────────────────────
          if (widget.images.length > 1)
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: _PageDots(
                count: widget.images.length,
                current: _current,
              ),
            ),
        ],
      ),
    );
  }
}
