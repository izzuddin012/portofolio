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
  static const String name       = 'Muhammad Izzuddin';
  static const String shortName  = 'Izzuddin';

  // Used in hero heading (80 pt) and navbar logo
  static const String firstName  = 'Izzuddin';

  // Headline shown under the name
  static const String heroRole    = 'Senior Mobile Apps Engineer';
  static const String heroTagline =
      '10+ years building high-performance mobile apps\n'
      'for iOS & Flutter — from large-scale e-commerce\n'
      'to real-time logistics systems.';

  // Direct link to your CV / résumé PDF
  static const String cvUrl = 'https://your-cv-link.com/cv.pdf'; // TODO: replace

  // Social / contact links
  static const String githubUrl   = 'https://github.com/izzuddin012';
  static const String linkedinUrl = 'https://linkedin.com/in/izzuddin012';
  static const String email       = 'izzuddin.m012@gmail.com';

  // Location & availability
  static const String location           = 'Indonesia 🇮🇩';
  static const String availabilityStatus = 'Open to opportunities';

  // ── 2. Hero stats ──────────────────────────────────────────────────────────

  static const String statYears         = '10+';
  static const String statYearsLabel    = 'Years Exp.';
  static const String statProjects      = 'M+';
  static const String statProjectsLabel = 'Users Reached';
  static const String statDownloads     = '2';
  static const String statDownloadsLabel = 'Core Teams';
  static const String statRating        = '3.81';
  static const String statRatingLabel   = 'GPA / 4.0';

  // ── 3. About / bio ─────────────────────────────────────────────────────────

  static const String aboutBio1 =
      'I\'m a Senior Mobile Apps Engineer with over 10 years of experience '
      'building high-performance mobile applications across iOS and Flutter. '
      'My work spans large-scale e-commerce platforms serving millions of users '
      'to real-time operational tools for logistics and supply chain.';

  static const String aboutBio2 =
      'I specialize in clean architecture, performance optimization, and '
      'system-level thinking — taking ownership of both feature delivery and '
      'engineering standards. I\'ve served on Flutter and iOS Core Teams, '
      'defining shared patterns and driving reliability improvements across the stack.';

  // Engineering philosophy / blockquote
  static const String aboutApproach =
      '"Scalable systems, performance optimization, operational excellence — '
      'not just buzzwords, but the lens through which every architectural '
      'decision gets made."';

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
  static const String ctaViewWork    = 'VIEW WORK';
  static const String ctaGithub      = 'GITHUB';
  static const String ctaDownloadCv  = 'DOWNLOAD CV';
  static const String ctaContact     = 'CONTACT';
  static const String ctaSendMessage = 'SEND MESSAGE';

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
      'Flutter', 'Dart', 'Swift', 'Objective-C',
      'SwiftUI', 'UIKit', 'Xcode', 'Android Studio',
    ],
  ),
  (
    'Architecture',
    [
      'Clean Architecture', 'MVVM', 'BLoC / Cubit',
      'Riverpod', 'Repository Pattern', 'Modularization',
    ],
  ),
  (
    'Backend & APIs',
    [
      'REST APIs', 'Laravel', 'JWT', 'Firebase',
      'MySQL', 'Docker',
    ],
  ),
  (
    'Tools & DevOps',
    [
      'Git', 'GitHub Actions', 'CI/CD', 'Fastlane',
      'TestFlight', 'Google Play Console', 'Postman',
    ],
  ),
  (
    'Systems',
    [
      'Push Notifications', 'Background Services',
      'QR / Barcode', 'Offline Support', 'Deep Linking',
    ],
  ),
];

// ── 6. Projects ───────────────────────────────────────────────────────────────

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
  Project(
    title: 'Allofresh Ops App',
    description:
        'Flutter application supporting midmile and lastmile logistics operations — '
        'covering tasking, packing, and delivery flows for warehouse and store users.',
    techStack: ['Flutter', 'Dart', 'BLoC', 'Clean Architecture', 'REST API'],
    contribution: [
      'Core contributor building and iterating on the Flutter app from the ground up',
      'Implemented store operation features: tasking, packing, and end-to-end delivery flows',
      'Resolved duplicate API requests and state inconsistency bugs, improving overall stability',
      'Enhanced logging, monitoring, and debugging infrastructure for faster production support',
      'Improved workflow efficiency for warehouse and store users through targeted UX and performance work',
    ],
  ),
  Project(
    title: 'Bukalapak iOS App',
    description:
        'Large-scale marketplace iOS application serving millions of users. '
        'Contributed to seller workflows, virtual products, and iOS Core Team modules.',
    techStack: ['Swift', 'Objective-C', 'UIKit', 'MVVM', 'Firebase'],
    contribution: [
      'Developed and maintained multiple features across the large-scale marketplace iOS app',
      'Enhanced seller-facing workflows including product listing, inventory, and order management',
      'iOS Core Team member: maintained shared modules and upheld engineering standards across squads',
      'Improved app performance and reduced crash rates through profiling, refactoring, and targeted fixes',
      'Migrated legacy Objective-C codebases into Swift to improve maintainability',
    ],
  ),
  Project(
    title: 'Virtual Products System',
    description:
        'Built and maintained digital goods and mobile top-up features inside the '
        'Bukalapak marketplace, handling high-volume transaction flows reliably.',
    techStack: ['Swift', 'REST API', 'JWT', 'UIKit'],
    contribution: [
      'Designed and built the complete digital goods and mobile top-up purchase flow end-to-end',
      'Integrated with multiple external provider APIs to enable reliable fulfillment across products',
      'Implemented robust error handling and transaction state management for partial and failed orders',
      'Ensured high availability of the virtual product catalog under peak traffic conditions',
    ],
  ),
  Project(
    title: 'Flutter Core Module Library',
    description:
        'Shared module library maintained by the Flutter Core Team at Allofresh — '
        'standardizing architecture patterns, logging, and debugging across all apps.',
    techStack: ['Flutter', 'Dart', 'Clean Architecture', 'BLoC'],
    contribution: [
      'Designed the shared module architecture adopted across all Allofresh Flutter applications',
      'Established coding standards, architecture patterns, and documentation for the Core Team',
      'Built reusable building blocks for API communication, error handling, and state management',
      'Maintained backward compatibility and versioning as the library evolved across multiple teams',
    ],
  ),
  Project(
    title: 'Developer Portfolio (This Site)',
    description:
        'This portfolio — built entirely in Flutter Web with clean architecture, '
        'Riverpod state management, and GitHub Pages deployment.',
    techStack: ['Flutter Web', 'Riverpod', 'flutter_animate', 'GitHub Pages'],
    category: ProjectCategory.web,
    githubUrl: 'https://github.com/izzuddin012/devolio_flutter',
    demoUrl: 'https://izzuddin012.github.io/devolio_flutter',
    contribution: [
      'Designed and built the full portfolio UI from scratch in Flutter Web',
      'Implemented responsive layouts for desktop, tablet, and mobile viewports',
      'Built dark/light theme toggle, smooth scroll navigation, and section entrance animations',
      'Created a single-file content system (portfolio_content.dart) for easy future updates',
      'Set up GitHub Pages deployment with SPA routing via a custom 404.html redirect',
    ],
  ),
  Project(
    title: 'Push Notification Infrastructure',
    description:
        'System-level push notification integration with priority handling, '
        'background delivery, and robust retry logic for high-frequency operational apps.',
    techStack: ['Flutter', 'Firebase FCM', 'Background Services', 'Docker'],
    category: ProjectCategory.backend,
    contribution: [
      'Integrated Flutter\'s push notification stack with Firebase Cloud Messaging (FCM) end-to-end',
      'Implemented background notification handling and foreground message processing',
      'Built notification-driven deep linking for critical operational alerts and workflow triggers',
      'Added delivery confirmation and retry logic for high-frequency, high-reliability use cases',
    ],
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

const List<Experience> experiences = [
  Experience(
    company: 'Allofresh',
    role: 'Senior Mobile Apps Engineer (Flutter)',
    dateRange: '2022 – 2026',
    location: 'Indonesia 🇮🇩',
    achievements: [
      'Core contributor to Flutter applications supporting midmile and lastmile logistics operations',
      'Member of Flutter Core Team — defined architecture standards and built shared modules across all apps',
      'Built scalable features for store operations: tasking, packing, and delivery flows',
      'Resolved duplicate API requests and state inconsistency issues, improving app stability',
      'Enhanced logging, monitoring, and debugging capabilities for high-frequency operational usage',
      'Improved workflow efficiency for warehouse and store users through targeted UX and performance work',
    ],
  ),
  Experience(
    company: 'Bukalapak',
    role: 'Senior Mobile Apps Engineer (iOS Native, Flutter)',
    dateRange: '2016 – 2022',
    location: 'Indonesia 🇮🇩',
    achievements: [
      'Developed large-scale iOS applications serving millions of users on one of Indonesia\'s largest marketplaces',
      'Member of iOS Core Team — maintained shared modules and upheld engineering standards across teams',
      'Enhanced seller experience including product listing, order management, and fulfillment workflows',
      'Built and maintained virtual product systems for digital goods and mobile top-ups',
      'Migrated legacy Objective-C codebases to Swift, improving maintainability and performance',
      'Improved app performance and reduced crash rates through targeted profiling and refactoring',
    ],
  ),
];
