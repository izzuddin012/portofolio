class Project {
  final String title;
  final String description;
  final List<String> techStack;
  final String? link;

  const Project({
    required this.title,
    required this.description,
    required this.techStack,
    this.link,
  });
}