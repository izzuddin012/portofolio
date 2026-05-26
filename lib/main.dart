import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:devolio_flutter/core/constants/app_constants.dart';
import 'package:devolio_flutter/core/theme/app_theme.dart';
import 'package:devolio_flutter/features/hero/hero_section.dart';
import 'package:devolio_flutter/features/about/about_section.dart';
import 'package:devolio_flutter/features/projects/project_section.dart';
import 'package:devolio_flutter/features/experience/experience_section.dart';
import 'package:devolio_flutter/features/contact/contact_section.dart';
import 'package:devolio_flutter/shared/widgets/app_navbar.dart';
import 'package:devolio_flutter/shared/widgets/footer.dart';
import 'package:devolio_flutter/providers.dart';

void main() {
  runApp(const ProviderScope(child: DevolioApp()));
}

class DevolioApp extends ConsumerWidget {
  const DevolioApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp(
      title: AppConstants.name,
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _scroll = ScrollController();

  // Key on the Column inside SingleChildScrollView —
  // its coordinate space == the full scroll-content space.
  final _contentKey = GlobalKey();

  final _heroKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _contactKey = GlobalKey();

  String _active = 'home';

  Map<String, GlobalKey> get _sectionKeys => {
    'home': _heroKey,
    'about': _aboutKey,
    'projects': _projectsKey,
    'experience': _experienceKey,
    'contact': _contactKey,
  };

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  // ── Active-section tracker ────────────────────────────────────────────────
  void _onScroll() {
    final viewH = MediaQuery.sizeOf(context).height;
    for (final entry in _sectionKeys.entries) {
      final ctx = entry.value.currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) continue;
      // dy is relative to the screen (viewport), perfect for visibility checks.
      final dy = box.localToGlobal(Offset.zero).dy;
      if (dy >= -80 && dy < viewH * 0.45) {
        if (_active != entry.key) setState(() => _active = entry.key);
        break;
      }
    }
  }

  // ── Scroll navigation ─────────────────────────────────────────────────────
  void scrollTo(String section) {
    final key = _sectionKeys[section];
    if (key == null) return;
    final sectionCtx = key.currentContext;
    if (sectionCtx == null) return;
    final sectionBox = sectionCtx.findRenderObject() as RenderBox?;
    if (sectionBox == null) return;

    // The Column with _contentKey is the direct child of SingleChildScrollView.
    // Its own coordinate space starts at (0,0) at the very top of the scroll
    // content — so localToGlobal(ancestor: contentBox).dy is exactly the
    // absolute scroll offset we need, no matter where the viewport currently is.
    final contentBox =
        _contentKey.currentContext?.findRenderObject() as RenderBox?;
    if (contentBox == null) return;

    final target = sectionBox
        .localToGlobal(Offset.zero, ancestor: contentBox)
        .dy
        .clamp(0.0, _scroll.position.maxScrollExtent);

    _scroll.animateTo(
      target,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Fixed navbar above the scroll area.
          AppNavbar(activeSection: _active, onMenuTap: scrollTo),
          // Scrollable content — SingleChildScrollView ensures every section
          // is laid out eagerly so coordinate transforms always work.
          Expanded(
            child: SingleChildScrollView(
              controller: _scroll,
              child: Column(
                key: _contentKey,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  KeyedSubtree(
                    key: _heroKey,
                    child: HeroSection(
                      onViewWork: () => scrollTo('projects'),
                      onViewContact: () => scrollTo('contact'),
                    ),
                  ),
                  KeyedSubtree(key: _aboutKey, child: const AboutSection()),
                  KeyedSubtree(
                    key: _projectsKey,
                    child: const ProjectsSection(),
                  ),
                  KeyedSubtree(
                    key: _experienceKey,
                    child: const ExperienceSection(),
                  ),
                  KeyedSubtree(key: _contactKey, child: const ContactSection()),
                  AppFooter(onNav: scrollTo),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
