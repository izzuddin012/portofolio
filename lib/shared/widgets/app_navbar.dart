import 'package:flutter/material.dart';
import 'package:devolio_flutter/core/utils/responsive.dart';

class AppNavbar extends StatelessWidget {
  final void Function(String section) onMenuTap;
  final String activeSection;

  const AppNavbar({
    super.key,
    required this.onMenuTap,
    required this.activeSection,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: isDesktop
          ? _DesktopNav(onMenuTap, activeSection)
          : _MobileNav(onMenuTap),
    );
  }
}

class _MobileNav extends StatelessWidget {

  const _MobileNav(this.onMenuTap);

  final void Function(String) onMenuTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Devolio'),
        PopupMenuButton<String>(
          onSelected: onMenuTap,
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'home', child: Text('Home')),
            PopupMenuItem(value: 'about', child: Text('About')),
            PopupMenuItem(value: 'projects', child: Text('Projects')),
            PopupMenuItem(value: 'contact', child: Text('Contact')),
          ],
        ),
      ],
    );
  }
}

class _DesktopNav extends StatelessWidget {

  const _DesktopNav(this.onMenuTap, this.activeSection);
  
  final void Function(String) onMenuTap;
  final String activeSection;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Devolio'),
        Row(
          children: [
            _NavItem(
              'Home',
              () => onMenuTap('home'),
              isActive: activeSection == 'home',
            ),
            _NavItem(
              'About',
              () => onMenuTap('about'),
              isActive: activeSection == 'about',
            ),
            _NavItem(
              'Projects',
              () => onMenuTap('projects'),
              isActive: activeSection == 'projects',
            ),
            _NavItem(
              'Contact',
              () => onMenuTap('contact'),
              isActive: activeSection == 'contact',
            ),
          ],
        ),
      ],
    );
  }
}

class _NavItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem(this.title, this.onTap, {this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: InkWell(
        onTap: onTap,
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.blue : Colors.white,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
