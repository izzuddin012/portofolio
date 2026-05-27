// ═══════════════════════════════════════════════════════════════════════════════
//  PORTFOLIO CONTENT  — edit everything in this file to customise your site.
//
//  Sections:
//    1. Personal info & links
//    2. About / bio
//    3. UI labels (nav, CTAs, section headings)
//    4. Tech stack
//    5. Projects
//    6. Experience
// ═══════════════════════════════════════════════════════════════════════════════

// ── 1. Personal info & links ──────────────────────────────────────────────────

class AppConstants {
  static const String name = 'Your Full Name';
  static const String shortName = 'YourName';

  // Used in hero heading (80 pt) and navbar logo
  static const String firstName = 'Your Full Name';

  // Headline shown under the name
  static const String heroRole = 'Your Job Title';
  static const String heroTagline =
      'A short tagline describing your work and expertise.\n'
      'Keep it to two or three lines for best visual balance.';

  // Direct link to your CV / résumé PDF
  static const String cvUrl = 'https://example.com/your-cv.pdf';

  // Social / contact links
  static const String githubUrl = 'https://github.com/yourusername';
  static const String linkedinUrl = 'https://linkedin.com/in/yourusername';
  static const String email = 'you@example.com';

  // Location & availability
  // ⚠️  Avoid emoji here — flag/emoji characters load a 2.8 MB font at runtime
  static const String location = 'Your City, Country';
  static const String availabilityStatus = 'Open to opportunities';

  // ── 2. About / bio ─────────────────────────────────────────────────────────

  static const String aboutBio1 =
      'Write your first bio paragraph here. Describe your background, '
      'years of experience, and the kind of work you do. '
      'Keep it personal and specific — what makes your experience unique?';

  static const String aboutBio2 =
      'Write your second bio paragraph here. Focus on your specialisations, '
      'how you approach engineering problems, and what you care about '
      'most in your craft.';

  // Engineering philosophy / blockquote
  static const String aboutApproach =
      '"A short quote or engineering philosophy that reflects '
      'how you think about your work."';

  // ── 3. UI labels ───────────────────────────────────────────────────────────

  // Nav
  static const String navHome = 'Home';
  static const String navAbout = 'About';
  static const String navSkills = 'Skills';
  static const String navProjects = 'Projects';
  static const String navExperience = 'Experience';
  static const String navContact = 'Contact';

  // Section headings
  static const String aboutHeading = 'About Me';
  static const String skillsHeading = 'Technical Stack';
  static const String projectsHeading = 'Featured Projects';
  static const String experienceHeading = 'Career';
  static const String contactHeading = 'Get In Touch';

  // CTA labels
  static const String ctaViewWork = 'VIEW WORK';
  static const String ctaGithub = 'GITHUB';
  static const String ctaDownloadCv = 'DOWNLOAD CV';
  static const String ctaContact = 'CONTACT';
  static const String ctaSendMessage = 'SEND MESSAGE';

  // Contact form
  static const String contactSubtitle =
      'Have a project in mind or want to collaborate? '
      "I'd love to hear from you.";
  static const String formName = 'Name';
  static const String formEmail = 'Email';
  static const String formMessage = 'Message';

  // Footer
  static const String footerBuilt = 'Built with Flutter Web';
}

// ── 4. Tech stack ─────────────────────────────────────────────────────────────
//
//  Each entry is  (categoryName, [skill, skill, ...])
//  Add, remove or rename entries freely.

const kTechStack = <(String, List<String>)>[
  (
    'Category One',
    ['Skill A', 'Skill B', 'Skill C', 'Skill D'],
  ),
  (
    'Category Two',
    ['Skill E', 'Skill F', 'Skill G', 'Skill H'],
  ),
  (
    'Category Three',
    ['Skill I', 'Skill J', 'Skill K'],
  ),
];

// ── 5. Projects ───────────────────────────────────────────────────────────────

enum ProjectCategory { all, mobile, web, backend }

class Project {
  final String title;
  final String description;
  final List<String> techStack;
  final List<String> contribution;

  /// Screenshot / mockup URLs shown in the detail modal gallery.
  /// Supports https:// network images or assets/ paths.
  /// Leave empty to show the default tint-icon placeholder.
  final List<String> images;
  final ProjectCategory category;
  final String? githubUrl;
  final String? demoUrl;

  /// Apple App Store listing URL (optional).
  final String? appStoreUrl;

  /// Google Play Store listing URL (optional).
  final String? playStoreUrl;

  const Project({
    required this.title,
    required this.description,
    required this.techStack,
    required this.contribution,
    this.images = const [],
    this.category = ProjectCategory.mobile,
    this.githubUrl,
    this.demoUrl,
    this.appStoreUrl,
    this.playStoreUrl,
  });
}

const List<Project> projects = [
  // ── Project 1 ───────────────────────────────────────────────────────────────
  Project(
    title: 'Project One',
    description:
        'A short description of this project — what it is, who it serves, '
        'and the problem it solves.',
    techStack: ['Flutter', 'Dart', 'Firebase', 'REST API'],
    contribution: [
      'Describe what you built or contributed to in this project',
      'Highlight any technical challenges you solved',
      'Mention impact: performance gains, users reached, team benefits',
    ],
    // images: ['https://raw.githubusercontent.com/youruser/assets/main/project1/screen1.png'],
    // appStoreUrl: 'https://apps.apple.com/...',
    // playStoreUrl: 'https://play.google.com/...',
    // githubUrl: 'https://github.com/youruser/project1',
  ),

  // ── Project 2 ───────────────────────────────────────────────────────────────
  Project(
    title: 'Project Two',
    description:
        'A short description of this project — what it is, who it serves, '
        'and the problem it solves.',
    techStack: ['Flutter', 'Dart', 'BLoC', 'Clean Architecture'],
    contribution: [
      'Describe what you built or contributed to in this project',
      'Highlight any technical challenges you solved',
      'Mention impact: performance gains, users reached, team benefits',
    ],
    // images: ['https://raw.githubusercontent.com/youruser/assets/main/project2/screen1.png'],
  ),

  // ── Project 3 ───────────────────────────────────────────────────────────────
  Project(
    title: 'Project Three',
    description:
        'A short description of this project — what it is, who it serves, '
        'and the problem it solves.',
    techStack: ['Flutter Web', 'Riverpod', 'GitHub Pages'],
    category: ProjectCategory.web,
    contribution: [
      'Describe what you built or contributed to in this project',
      'Highlight any technical challenges you solved',
      'Mention impact: performance gains, users reached, team benefits',
    ],
    // demoUrl: 'https://yourusername.github.io/project3',
    // githubUrl: 'https://github.com/youruser/project3',
  ),
];

// ── 6. Experience ─────────────────────────────────────────────────────────────

class Experience {
  final String company;
  final String role;
  final String dateRange;
  final String? location;
  final List<String> achievements;

  const Experience({
    required this.company,
    required this.role,
    required this.dateRange,
    this.location,
    required this.achievements,
  });
}

const List<Experience> experiences = [
  Experience(
    company: 'Company Name',
    role: 'Your Role Title',
    dateRange: '2022 – Present',
    location: 'City, Country',   // avoid emoji — see note in section 1
    achievements: [
      'Describe a key achievement or responsibility in this role',
      'Quantify impact where possible — e.g. reduced crash rate by 40%',
      'Mention team size, scope, or scale if relevant',
    ],
  ),
  Experience(
    company: 'Previous Company',
    role: 'Your Previous Role',
    dateRange: '2018 – 2022',
    location: 'City, Country',
    achievements: [
      'Describe a key achievement or responsibility in this role',
      'Quantify impact where possible',
      'Mention any leadership, mentoring, or cross-team work',
    ],
  ),
];
