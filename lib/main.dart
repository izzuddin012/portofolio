import 'package:flutter/material.dart';

import 'package:devolio_flutter/features/about/about_section.dart';
import 'package:devolio_flutter/features/contact/contact_section.dart';
import 'package:devolio_flutter/features/home/home_section.dart';
import 'package:devolio_flutter/features/projects/project_section.dart';
import 'package:devolio_flutter/shared/widgets/app_navbar.dart';

void main() {
  runApp(const DevolioApp());
}

class DevolioApp extends StatelessWidget {
  const DevolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Devolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  final homeKey = GlobalKey();
  final aboutKey = GlobalKey();
  final projectKey = GlobalKey();
  final contactKey = GlobalKey();

  String activeSection = 'home';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final sections = {
      'home': homeKey,
      'about': aboutKey,
      'projects': projectKey,
      'contact': contactKey,
    };

    for (final entry in sections.entries) {
      final context = entry.value.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox?;
        final position = box?.localToGlobal(Offset.zero).dy ?? 0;

        if (position >= 0 && position < 1000) {
          if (activeSection != entry.key) {
            setState(() {
              activeSection = entry.key;
            });
          }
        }
      }
    }
  }

  void scrollTo(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppNavbar(
            activeSection: activeSection,
            onMenuTap: (section) {
              if (section == 'home') scrollTo(homeKey);
              if (section == 'about') scrollTo(aboutKey);
              if (section == 'projects') scrollTo(projectKey);
              if (section == 'contact') scrollTo(contactKey);
            },
          ),
          Expanded(
            child: ListView(
              controller: _scrollController,
              children: [
                Container(key: homeKey, child: const HomeSection()),
                Container(key: aboutKey, child: const AboutSection()),
                Container(key: projectKey, child: const ProjectsSection()),
                Container(key: contactKey, child: const ContactSection()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
