import 'package:devolio_flutter/features/projects/project_model.dart';
import 'package:flutter/material.dart';
import 'package:devolio_flutter/shared/layout/app_container.dart';
import 'package:devolio_flutter/core/utils/responsive.dart';
import 'package:devolio_flutter/features/projects/project_data.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return AppContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Projects',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          isDesktop
              ? GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: projects.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.4,
                  ),
                  itemBuilder: (context, index) {
                    return ProjectCard(project: projects[index]);
                  },
                )
              : Column(
                  children: projects
                      .map((p) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: ProjectCard(project: p),
                          ))
                      .toList(),
                )
        ],
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {

  const ProjectCard({super.key, required this.project});
  
  final Project project;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            project.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            project.description,
            style: const TextStyle(height: 1.5),
          ),
          const Spacer(),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: project.techStack
                .map<Widget>((tech) => _TechChip(label: tech))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _TechChip extends StatelessWidget {

  const _TechChip({required this.label});
  
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}