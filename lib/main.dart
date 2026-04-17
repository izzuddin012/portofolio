import 'package:flutter/material.dart';

import 'features/home/home_section.dart';
import 'shared/widgets/app_navbar.dart';

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
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ScrollController _scrollController = ScrollController();

  final homeKey = GlobalKey();
  final aboutKey = GlobalKey();
  final projectKey = GlobalKey();
  final contactKey = GlobalKey();

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
                Container(key: aboutKey, child: const Placeholder()),
                Container(key: projectKey, child: const Placeholder()),
                Container(key: contactKey, child: const Placeholder()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}