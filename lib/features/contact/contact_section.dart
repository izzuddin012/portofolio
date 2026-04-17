import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:devolio_flutter/shared/layout/app_container.dart';
import 'package:devolio_flutter/core/utils/responsive.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return AppContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contact',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            "I'm open to opportunities and collaborations. Feel free to reach out if you’d like to work together.",
            style: TextStyle(height: 1.6),
          ),
          const SizedBox(height: 24),
          isDesktop
              ? const Row(
                  children: [
                    Expanded(child: _ContactCard(type: 'Email')),
                    SizedBox(width: 16),
                    Expanded(child: _ContactCard(type: 'LinkedIn')),
                    SizedBox(width: 16),
                    Expanded(child: _ContactCard(type: 'GitHub')),
                  ],
                )
              : const Column(
                  children: [
                    _ContactCard(type: 'Email'),
                    SizedBox(height: 12),
                    _ContactCard(type: 'LinkedIn'),
                    SizedBox(height: 12),
                    _ContactCard(type: 'GitHub'),
                  ],
                ),
        ],
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {

  const _ContactCard({required this.type});
  
  final String type;

  @override
  Widget build(BuildContext context) {
    String label;
    String value;

    switch (type) {
      case 'Email':
        label = 'Email';
        value = 'your@email.com';
        break;
      case 'LinkedIn':
        label = 'LinkedIn';
        value = 'linkedin.com/in/yourprofile';
        break;
      case 'GitHub':
        label = 'GitHub';
        value = 'github.com/yourusername';
        break;
      default:
        label = '';
        value = '';
    }

    return InkWell(
      onTap: () async {
        final uri = Uri.parse('https://$value');
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(value),
          ],
        ),
      ),
    );
  }
}
