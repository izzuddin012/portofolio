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
              color: isSelected ? Colors.white : AppColors.textSecondary,
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
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
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
                _Thumbnail(category: p.category, tint: tint, hovered: _hovered),
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
                        style: AppTypography.cardDesc,
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
        )
        .animate()
        .fadeIn(delay: widget.delay, duration: 400.ms)
        .slideY(begin: 0.08, end: 0, delay: widget.delay, duration: 400.ms);
  }
}

class _Thumbnail extends StatelessWidget {
  final ProjectCategory category;
  final Color tint;
  final bool hovered;

  const _Thumbnail({
    required this.category,
    required this.tint,
    required this.hovered,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
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
          _icon(category),
          size: 36,
          color: tint.withValues(alpha: hovered ? 0.9 : 0.6),
        ),
      ),
    );
  }

  IconData _icon(ProjectCategory cat) {
    switch (cat) {
      case ProjectCategory.mobile:
        return Icons.phone_iphone_rounded;
      case ProjectCategory.web:
        return Icons.language_rounded;
      case ProjectCategory.backend:
        return Icons.storage_rounded;
      case ProjectCategory.all:
        return Icons.apps_rounded;
    }
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
          child: Icon(icon, size: 16, color: AppColors.textSecondary),
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
        style: AppTypography.techTag,
      ),
    );
  }
}
