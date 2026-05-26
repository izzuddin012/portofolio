// ═══════════════════════════════════════════════════════════════════════════════
//  PORTFOLIO CONTENT  — edit everything in this file to customise your site.
//
//  Sections:
//    1. Personal info & links
//    2. Hero stats
//    3. About / bio
//    4. UI labels (nav, CTAs, section headings)
//    5. Tech stack
//    6. Projects
//    7. Experience
// ═══════════════════════════════════════════════════════════════════════════════

// ── 1. Personal info & links ──────────────────────────────────────────────────

class AppConstants {
  // TODO: your name
  static const String name       = 'Muhammad Izzuddin';
  static const String shortName  = 'Izzuddin';
  static const String firstName  = 'Muhammad Izzuddin';

  // TODO: your headline
  static const String heroRole    = 'Senior Mobile Apps Engineer';
  static const String heroTagline =
      'Crafting exceptional mobile experiences\nwith clean, maintainable code.';

  // TODO: direct link to your CV / résumé PDF
  static const String cvUrl = 'https://your-cv-link.com/cv.pdf';

  // TODO: social / contact links
  static const String githubUrl   = 'https://github.com/izzuddin012';
  static const String linkedinUrl = 'https://linkedin.com/in/izzuddin012';
  static const String email       = 'izzuddin.m012@gmail.com';

  // TODO: location & availability
  static const String location           = 'Indonesia 🇮🇩';
  static const String availabilityStatus = 'Open to opportunities';

  // ── 2. Hero stats ──────────────────────────────────────────────────────────

  // TODO: update your numbers
  static const String statYears        = '5+';
  static const String statYearsLabel   = 'Years Exp.';
  static const String statProjects     = '20+';
  static const String statProjectsLabel = 'Projects Shipped';
  static const String statDownloads    = '100K+';
  static const String statDownloadsLabel = 'App Downloads';
  static const String statRating       = '4.9★';
  static const String statRatingLabel  = 'Client Rating';

  // ── 3. About / bio ─────────────────────────────────────────────────────────

  // TODO: write your own bio paragraphs
  static const String aboutBio1 =
      'I\'m a Senior Mobile Engineer with 5+ years of experience building '
      'scalable iOS and Flutter applications. I focus on clean architecture, '
      'performance optimization, and shipping products people actually love using.';

  static const String aboutBio2 =
      'Over the years I\'ve led feature delivery, reduced crash rates by 40%, '
      'built CI/CD pipelines, and mentored engineers across cross-functional teams. '
      'I care deeply about code quality, design fidelity, and engineering craft.';

  // TODO: your personal engineering philosophy / quote
  static const String aboutApproach =
      '"Clean architecture first. Test what matters. '
      'Optimize for the real user, not the benchmark."';

  // ── 4. UI labels ───────────────────────────────────────────────────────────

  // Nav
  static const String navHome       = 'Home';
  static const String navAbout      = 'About';
  static const String navSkills     = 'Skills';
  static const String navProjects   = 'Projects';
  static const String navExperience = 'Experience';
  static const String navContact    = 'Contact';

  // Section headings
  static const String aboutHeading      = 'About Me';
  static const String skillsHeading     = 'Technical Stack';
  static const String projectsHeading   = 'Featured Projects';
  static const String experienceHeading = 'Career';
  static const String contactHeading    = 'Get In Touch';

  // CTA labels
  static const String ctaViewWork     = 'VIEW WORK';
  static const String ctaGithub       = 'GITHUB';
  static const String ctaDownloadCv   = 'DOWNLOAD CV';
  static const String ctaContact      = 'CONTACT';
  static const String ctaSendMessage  = 'SEND MESSAGE';

  // Contact form
  static const String contactSubtitle =
      'Have a project in mind or want to collaborate? '
      "I'd love to hear from you.";
  static const String formName    = 'Name';
  static const String formEmail   = 'Email';
  static const String formMessage = 'Message';

  // Footer
  static const String footerBuilt = 'Built with Flutter Web';
}

// ── 5. Tech stack ─────────────────────────────────────────────────────────────
//
//  Each entry is  (categoryName, [skill, skill, ...])
//  Add, remove or rename entries freely.

const kTechStack = <(String, List<String>)>[
  (
    'Mobile Development',
    [
      'Flutter', 'Dart', 'Swift', 'SwiftUI', 'Objective-C',
      'UIKit', 'Xcode', 'Android Studio',
    ],
  ),
  (
    'State & Architecture',
    [
      'Bloc / Cubit', 'Riverpod', 'Provider', 'GetX',
      'Clean Architecture', 'MVVM', 'Repository Pattern',
    ],
  ),
  (
    'Backend & Cloud',
    [
      'Firebase', 'Supabase', 'REST API', 'GraphQL',
      'Node.js', 'MySQL', 'PostgreSQL', 'Redis',
    ],
  ),
  (
    'Tools & Platforms',
    [
      'Git', 'GitHub Actions', 'Fastlane', 'TestFlight',
      'Google Play Console', 'Figma', 'Postman', 'Docker',
    ],
  ),
  (
    'Testing',
    [
      'Unit Testing', 'Widget Testing', 'Integration Tests',
      'Mockito', 'Flutter Test', 'Detox',
    ],
  ),
];

// ── 6. Projects ───────────────────────────────────────────────────────────────

enum ProjectCategory { all, mobile, web, backend }

class Project {
  final String title;
  final String description;
  final List<String> techStack;
  final ProjectCategory category;
  final String? githubUrl;
  final String? demoUrl;

  const Project({
    required this.title,
    required this.description,
    required this.techStack,
    this.category = ProjectCategory.mobile,
    this.githubUrl,
    this.demoUrl,
  });
}

// TODO: replace with your real projects
const List<Project> projects = [
  Project(
    title: 'Flutter E-Commerce App',
    description:
        'Scalable e-commerce platform with optimised state management, '
        'offline cart persistence, and 30 % faster checkout flow.',
    techStack: ['Flutter', 'Bloc', 'REST API', 'SQLite'],
    category: ProjectCategory.mobile,
    githubUrl: 'https://github.com/yourusername/ecommerce-app',
  ),
  Project(
    title: 'iOS Logistics Tracker',
    description:
        'Real-time logistics tracking for last-mile delivery. '
        'Reduced delivery errors by 25 % through better state tracking.',
    techStack: ['Swift', 'Objective-C', 'Firebase', 'MapKit'],
    category: ProjectCategory.mobile,
    githubUrl: 'https://github.com/yourusername/logistics-tracker',
  ),
  Project(
    title: 'Developer Portfolio (This Site)',
    description:
        'This portfolio — built entirely in Flutter Web with clean architecture, '
        'Riverpod state management, and GitHub Pages deployment.',
    techStack: ['Flutter Web', 'Riverpod', 'go_router', 'flutter_animate'],
    category: ProjectCategory.web,
    githubUrl: 'https://github.com/yourusername/devolio_flutter',
    demoUrl: 'https://yourusername.github.io/devolio_flutter',
  ),
  Project(
    title: 'Internal Ops Dashboard',
    description:
        'Internal tooling to streamline warehouse workflows, reducing '
        'manual processing time by 60 % and improving team efficiency.',
    techStack: ['Flutter', 'Laravel API', 'MySQL', 'REST API'],
    category: ProjectCategory.web,
    githubUrl: 'https://github.com/yourusername/ops-dashboard',
  ),
  Project(
    title: 'Push Notification Service',
    description:
        'Microservice handling 500 K+ daily push notifications with '
        'priority queuing, retry logic, and delivery analytics.',
    techStack: ['Dart', 'Firebase FCM', 'Redis', 'Docker'],
    category: ProjectCategory.backend,
    githubUrl: 'https://github.com/yourusername/push-service',
  ),
  Project(
    title: 'Flutter UI Component Library',
    description:
        'Shared design system used across 3 products. '
        'Includes theming, accessibility, and Storybook-style demos.',
    techStack: ['Flutter', 'Dart', 'Pub.dev'],
    category: ProjectCategory.mobile,
    githubUrl: 'https://github.com/yourusername/flutter-ui-kit',
  ),
];

// ── 7. Experience ─────────────────────────────────────────────────────────────

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

// TODO: replace with your real work history (most recent first)
const List<Experience> experiences = [
  Experience(
    company: 'Acme Tech',
    role: 'Senior Mobile Engineer',
    dateRange: 'Jan 2022 – Present',
    location: 'Remote',
    achievements: [
      'Led Flutter migration from iOS-only app, reducing development cost by 40 %',
      'Architected offline-first data sync layer handling 200 K+ daily active users',
      'Reduced app startup time by 35 % through lazy loading and AOT optimisations',
      'Mentored 3 junior engineers, established code-review culture and PR templates',
    ],
  ),
  Experience(
    company: 'Startup Labs',
    role: 'Mobile Engineer',
    dateRange: 'Mar 2020 – Dec 2021',
    location: 'Kuala Lumpur, MY',
    achievements: [
      'Built core iOS app features in Swift / Objective-C serving 50 K+ users',
      'Integrated Firebase Analytics and Crashlytics, reducing crash rate by 40 %',
      'Delivered CI/CD pipeline with Fastlane and Bitrise, cutting release time by 60 %',
      'Collaborated with design team to implement pixel-perfect UI from Figma specs',
    ],
  ),
  Experience(
    company: 'Freelance',
    role: 'Flutter & iOS Developer',
    dateRange: 'Jun 2018 – Feb 2020',
    location: 'Remote',
    achievements: [
      'Delivered 8+ mobile apps for clients across logistics, retail, and fintech',
      'Maintained long-term client relationships with 4.9 / 5 average satisfaction',
      'Built REST API integrations with robust error handling and offline support',
    ],
  ),
];
