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
  static const String name = 'Muhammad Izzuddin';
  static const String shortName = 'Izzuddin';

  // Used in hero heading (80 pt) and navbar logo
  static const String firstName = 'Muhammad Izzuddin';

  // Headline shown under the name
  static const String heroRole = 'Senior Mobile Apps Engineer';
  static const String heroTagline =
      '10+ years building high-performance mobile apps for iOS & Flutter — '
      'from large-scale e-commerce\n to real-time logistics systems.';

  // Direct link to your CV / résumé PDF
  static const String cvUrl =
      'https://raw.githubusercontent.com/izzuddin012/portofolio_assets/refs/heads/main/cv/Resume%20-%20Muhammad%20Izzuddin.pdf';

  // Social / contact links
  static const String githubUrl = 'https://github.com/izzuddin012';
  static const String linkedinUrl = 'https://linkedin.com/in/izzuddin012';
  static const String email = 'izzuddin.m012@gmail.com';

  // Location & availability
  static const String location = 'Indonesia';
  static const String availabilityStatus = 'Open to opportunities';

  // ── 2. About / bio ─────────────────────────────────────────────────────────

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
    'Mobile Development',
    [
      'Flutter',
      'Dart',
      'Swift',
      'Objective-C',
      'SwiftUI',
      'UIKit',
      'Xcode',
      'Android Studio',
    ],
  ),
  (
    'Architecture',
    [
      'Clean Architecture',
      'MVVM',
      'BLoC / Cubit',
      'Riverpod',
      'Repository Pattern',
      'Modularization',
    ],
  ),
  (
    'Backend & APIs',
    ['REST APIs', 'Laravel', 'JWT', 'Firebase', 'MySQL', 'Docker'],
  ),
  (
    'Tools & DevOps',
    [
      'Git',
      'GitHub Actions',
      'CI/CD',
      'Fastlane',
      'TestFlight',
      'Google Play Console',
      'Postman',
    ],
  ),
  (
    'Systems',
    [
      'Push Notifications',
      'Background Services',
      'QR / Barcode',
      'Offline Support',
      'Deep Linking',
    ],
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
  // ── Bukalapak iOS ───────────────────────────────────────────────────────────
  Project(
    title: 'Bukalapak',
    description:
        'iOS app for one of Indonesia\'s largest marketplaces — serving millions '
        'of buyers and sellers.',
    techStack: [
      'Swift',
      'Objective-C',
      'UIKit',
      'Programmatic Autolayout',
      'MVVM',
      'Firebase',
    ],
    contribution: [
      'Shipped "Nego Cincai" — a viral price-negotiation feature that became '
          'one of Bukalapak\'s signature social commerce mechanics (2017)',
      'Built virtual product purchase flows for mobile top-ups, flight tickets, '
          'and train tickets, integrating multiple third-party provider APIs',
      'Led migration from Storyboard/XIB to programmatic Autolayout, '
          'significantly improving maintainability and layout flexibility at scale',
      'Built generic reusable UITableView/UICollectionView components '
          'adopted across multiple squads in the iOS codebase',
      'Developed and iterated on seller features including product listing, '
          'inventory management, and order fulfilment workflows',
    ],
    images: [
      'https://raw.githubusercontent.com/izzuddin012/portofolio_assets/refs/heads/main/Bukalapak/bukalapak_0.png',
      'https://raw.githubusercontent.com/izzuddin012/portofolio_assets/refs/heads/main/Bukalapak/bukalapak_1.png',
      'https://raw.githubusercontent.com/izzuddin012/portofolio_assets/refs/heads/main/Bukalapak/bukalapak_2.png',
      'https://raw.githubusercontent.com/izzuddin012/portofolio_assets/refs/heads/main/Bukalapak/bukalapak_3.png',
      'https://raw.githubusercontent.com/izzuddin012/portofolio_assets/refs/heads/main/Bukalapak/bukalapak_4.png',
    ],
    appStoreUrl:
        'https://apps.apple.com/id/app/bukalapak-jual-beli-online/id1003169137',
  ),

  // ── Allofresh consumer app ──────────────────────────────────────────────────
  Project(
    title: 'Allofresh',
    description:
        'Consumer-facing Flutter grocery app — built on a clean multi-module '
        'architecture migrated from native',
    techStack: [
      'Flutter',
      'Dart',
      'BLoC',
      'Clean Architecture',
      'Modularization',
      'REST API',
    ],
    contribution: [
      'Led multi-module architecture design during migration from native to Flutter, '
          'enabling independent parallel feature delivery across squads',
      'Built a network wrapper module that standardized API communication, '
          'response parsing, and error handling across all app modules',
      'Designed and implemented an impression tracker — capturing which sections '
          'users actually see, feeding behavioral data directly into product decisions',
      'Managed the full release pipeline: internal testing, staged rollouts, '
          'and App Store & Play Store submissions',
    ],
    images: [
      'https://raw.githubusercontent.com/izzuddin012/portofolio_assets/refs/heads/main/Allofresh/allofresh_0.png',
      'https://raw.githubusercontent.com/izzuddin012/portofolio_assets/refs/heads/main/Allofresh/allofresh_1.jpg',
      'https://raw.githubusercontent.com/izzuddin012/portofolio_assets/refs/heads/main/Allofresh/allofresh_2.jpg',
      'https://raw.githubusercontent.com/izzuddin012/portofolio_assets/refs/heads/main/Allofresh/allofresh_3.jpg',
      'https://raw.githubusercontent.com/izzuddin012/portofolio_assets/refs/heads/main/Allofresh/allofresh_4.jpg',
      'https://raw.githubusercontent.com/izzuddin012/portofolio_assets/refs/heads/main/Allofresh/allofresh_5.jpg',
    ],
    appStoreUrl:
        'https://apps.apple.com/id/app/allofresh-grocery-shopping/id1610121515',
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=id.allofresh.ecommerce&hl=en',
  ),

  // ── PickPack (mid-mile warehouse ops) ───────────────────────────────────────
  Project(
    title: 'PickPack by Allofresh',
    description:
        'Flutter warehouse operations app — owned end-to-end, driving midmile '
        'picking & packing workflows with hardware integrations for barcode '
        'scanners and thermal printers.',
    techStack: [
      'Flutter',
      'Dart',
      'BLoC',
      'CI/CD',
      'Fastlane',
      'GitHub Actions',
      'Barcode Scanner',
      'Thermal Printer',
    ],
    contribution: [
      'Sole owner of the app end-to-end — architecture, features, integrations, '
          'and every production release decision',
      'Drove three major Flutter SDK migrations (1.x → 2.x → 3.x), keeping '
          'the app on stable, modern foundations with zero feature regressions',
      'Integrated barcode scanners and thermal printers, equipping warehouse '
          'staff with hardware-backed workflows that cut manual steps',
      'Built CI/CD pipelines for automated unit testing and static analysis '
          'on every pull request, maintaining code quality at scale',
      'Resolved persistent data sync issues between packaging and inventory '
          'services, improving fulfillment accuracy across warehouse operations',
      'Managed internal test distribution and full Play Store submission lifecycle',
    ],
    images: [
      'https://raw.githubusercontent.com/izzuddin012/portofolio_assets/refs/heads/main/pickpack/pickpack_0.png',
      'https://raw.githubusercontent.com/izzuddin012/portofolio_assets/refs/heads/main/pickpack/pickpack_1.png',
      'https://raw.githubusercontent.com/izzuddin012/portofolio_assets/refs/heads/main/pickpack/pickpack_2.png',
      'https://raw.githubusercontent.com/izzuddin012/portofolio_assets/refs/heads/main/pickpack/pickpack_3.png',
      'https://raw.githubusercontent.com/izzuddin012/portofolio_assets/refs/heads/main/pickpack/pickpack_4.png',
    ],
    playStoreUrl:
        'https://play.google.com/store/apps/details?id=id.allofresh.pickpack&hl=id',
  ),

  // ── Kingkong Meats ──────────────────────────────────────────────────────────
  Project(
    title: 'Kingkong Meats',
    description:
        'Flutter e-commerce app built from scratch for a specialty meat retailer '
        '— covering product browsing, cart, and push notifications, '
        'launched on both App Store and Play Store.',
    techStack: [
      'Flutter',
      'Dart',
      'Clean Architecture',
      'Firebase',
      'REST API',
    ],
    contribution: [
      'Contributed to app architecture design from day zero, establishing '
          'scalable patterns for the team to build on',
      'Built core commerce features: product listing with filters, '
          'cart management, and push notification delivery',
      'Prepared and launched the app on both App Store and Play Store, '
          'handling all submission, compliance, and release requirements',
    ],
    images: [
      'https://raw.githubusercontent.com/izzuddin012/portofolio_assets/refs/heads/main/Kingkong%20Meats/kingkong_0.png',
      'https://raw.githubusercontent.com/izzuddin012/portofolio_assets/refs/heads/main/Kingkong%20Meats/kingkong_1.png',
      'https://raw.githubusercontent.com/izzuddin012/portofolio_assets/refs/heads/main/Kingkong%20Meats/kingkong_2.png',
    ],
  ),

  // ── Developer Portfolio ─────────────────────────────────────────────────────
  Project(
    title: 'Developer Portfolio (This Site)',
    description:
        'This portfolio — built entirely in Flutter Web with clean architecture, '
        'Riverpod state management, and GitHub Pages deployment.',
    techStack: ['Flutter Web', 'Riverpod', 'flutter_animate', 'GitHub Pages'],
    category: ProjectCategory.web,
    contribution: [
      'Designed and built the full portfolio UI from scratch in Flutter Web',
      'Implemented responsive layouts for desktop, tablet, and mobile viewports',
      'Built dark/light theme toggle, smooth scroll navigation, and section entrance animations',
      'Created a single-file content system (portfolio_content.dart) for easy future updates',
      'Set up GitHub Pages deployment with SPA routing via a custom 404.html redirect',
    ],
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
    company: 'Allofresh',
    role: 'Senior Mobile Apps Engineer (Flutter)',
    dateRange: '2022 – 2026',
    location: 'Indonesia',
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
    location: 'Indonesia',
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
