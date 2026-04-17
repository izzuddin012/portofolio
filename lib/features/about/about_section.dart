import 'package:flutter/material.dart';
import 'package:devolio_flutter/core/utils/responsive.dart';
import 'package:devolio_flutter/shared/layout/app_container.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return AppContainer(
      child: isDesktop
          ? const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _AboutText()),
                SizedBox(width: 40),
                Expanded(child: _SkillsGrid()),
              ],
            )
          : const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _AboutText(),
                SizedBox(height: 32),
                _SkillsGrid(),
              ],
            ),
    );
  }
}

class _AboutText extends StatelessWidget {
  const _AboutText();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About Me',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Text(
          'I\'m a Senior Mobile Engineer with extensive experience building scalable iOS and Flutter applications. '
          'I focus on clean architecture, performance optimization, and delivering reliable production systems.',
          style: TextStyle(fontSize: 16, height: 1.6),
        ),
        SizedBox(height: 12),
        Text(
          "Over the years, I've contributed to high-impact features, improved system performance, and reduced technical debt "
          'across multiple projects.',
          style: TextStyle(fontSize: 16, height: 1.6),
        ),
      ],
    );
  }
}

class _SkillsGrid extends StatelessWidget {
  const _SkillsGrid();

  final List<String> skills = const [
    'Flutter',
    'Dart',
    'Swift',
    'Objective-C',
    'REST API',
    'Clean Architecture',
    'Bloc',
    'Firebase',
    'CI/CD',
    'Git',
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: skills.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isDesktop ? 3 : 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 3,
      ),
      itemBuilder: (context, index) {
        return _SkillCard(skill: skills[index]);
      },
    );
  }
}

class _SkillCard extends StatelessWidget {

  const _SkillCard({required this.skill});
  
  final String skill;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white24),
      ),
      alignment: Alignment.centerLeft,
      child: Text(skill),
    );
  }
}