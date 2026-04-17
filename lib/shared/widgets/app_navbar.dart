import 'package:flutter/material.dart';
import '../../core/utils/responsive.dart';

class AppNavbar extends StatelessWidget {
  final Function(String section) onMenuTap;

  const AppNavbar({super.key, required this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: isDesktop ? _DesktopNav(onMenuTap) : _MobileNav(onMenuTap),
    );
  }
}

class _MobileNav extends StatelessWidget {
  final Function(String) onMenuTap;

  const _MobileNav(this.onMenuTap);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Devolio"),
        PopupMenuButton<String>(
          onSelected: onMenuTap,
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'home', child: Text('Home')),
            PopupMenuItem(value: 'about', child: Text('About')),
            PopupMenuItem(value: 'projects', child: Text('Projects')),
            PopupMenuItem(value: 'contact', child: Text('Contact')),
          ],
        )
      ],
    );
  }
}

class _DesktopNav extends StatelessWidget {
  final Function(String) onMenuTap;

  const _DesktopNav(this.onMenuTap);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Devolio"),
        Row(
          children: [
            _NavItem("Home", () => onMenuTap('home')),
            _NavItem("About", () => onMenuTap('about')),
            _NavItem("Projects", () => onMenuTap('projects')),
            _NavItem("Contact", () => onMenuTap('contact')),
          ],
        )
      ],
    );
  }
}

class _NavItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _NavItem(this.title, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: InkWell(
        onTap: onTap,
        child: Text(title),
      ),
    );
  }
}