# Flutter Web Portfolio

Personal developer portfolio built with Flutter Web — responsive, dark/light themed, and auto-deployed to GitHub Pages via GitHub Actions.

---

## Features

- Hero section with CTA buttons
- About + tech stack side-by-side (desktop) / stacked (mobile)
- Projects grid with category filter, hover cards, and tap-to-open detail modal
- Project detail modal — description, contribution bullets, tech tags, gallery carousel, App Store / Play Store links
- Full-screen image lightbox with pinch-to-zoom
- Experience timeline
- Contact section with social links
- Dark / light theme toggle (dark by default)
- Fully responsive — mobile, tablet, desktop
- Branded loading splash (instant, pure CSS) that fades out when Flutter mounts
- GitHub Actions CI/CD — push to `main` → auto build → auto deploy

---

## Local setup

**Prerequisites:** Flutter 3.32.8 via FVM (`fvm install 3.32.8`)

```bash
fvm flutter pub get
fvm flutter run -d chrome
```

---

## Customising content

**Everything is in one file:**

```
lib/core/constants/portfolio_content.dart
```

You never need to touch any other file to update your portfolio content.

---

### 1. Personal info & links

```dart
class AppConstants {
  static const String name       = 'Your Full Name';
  static const String firstName  = 'YourFirst';   // navbar logo + hero heading
  static const String heroRole   = 'Your Job Title';
  static const String heroTagline = '...';

  static const String cvUrl      = 'https://...'; // CV / résumé PDF link
  static const String githubUrl  = 'https://github.com/yourhandle';
  static const String linkedinUrl = 'https://linkedin.com/in/yourhandle';
  static const String email      = 'you@example.com';

  static const String location           = 'Your City, Country';
  static const String availabilityStatus = 'Open to opportunities';
  // ⚠️  Avoid emoji here — flag/emoji characters load a 2.8 MB font at runtime
}
```

### 2. Bio & philosophy quote

```dart
static const String aboutBio1     = '...'; // first paragraph
static const String aboutBio2     = '...'; // second paragraph
static const String aboutApproach = '"..."'; // blockquote
```

### 3. Tech stack

```dart
const kTechStack = <(String, List<String>)>[
  ('Mobile Development', ['Flutter', 'Dart', 'Swift', ...]),
  ('Architecture',       ['Clean Architecture', 'MVVM', ...]),
  // add or remove categories freely
];
```

### 4. Projects

Each `Project` entry supports:

| Field | Type | Required | Description |
|---|---|---|---|
| `title` | `String` | ✓ | Card heading |
| `description` | `String` | ✓ | Short summary (shown on card + modal) |
| `techStack` | `List<String>` | ✓ | Tags shown on card and modal |
| `contribution` | `List<String>` | ✓ | Bullet points in the detail modal |
| `category` | `ProjectCategory` | — | `mobile` (default), `web`, `backend` |
| `images` | `List<String>` | — | Screenshot URLs for gallery carousel |
| `githubUrl` | `String?` | — | Source code link |
| `demoUrl` | `String?` | — | Live demo link |
| `appStoreUrl` | `String?` | — | Apple App Store link |
| `playStoreUrl` | `String?` | — | Google Play Store link |

**Example:**

```dart
Project(
  title: 'My App',
  description: 'Short description shown on the card.',
  techStack: ['Flutter', 'Dart', 'BLoC'],
  contribution: [
    'Led architecture design from scratch',
    'Built CI/CD pipeline with Fastlane + GitHub Actions',
  ],
  category: ProjectCategory.mobile,
  images: [
    'https://raw.githubusercontent.com/youruser/assets/main/myapp/screen1.png',
    'https://raw.githubusercontent.com/youruser/assets/main/myapp/screen2.png',
  ],
  appStoreUrl:  'https://apps.apple.com/...',
  playStoreUrl: 'https://play.google.com/...',
),
```

> **Tip for images:** Upload screenshots to a public GitHub repo and use `raw.githubusercontent.com` URLs. These are permanent, CORS-safe, and work reliably with `Image.network()` in Flutter Web. Avoid `github.com/user-attachments/assets/` URLs — they expire after 5 minutes.

### 5. Experience

```dart
Experience(
  company:      'Company Name',
  role:         'Your Role',
  dateRange:    '2022 – Present',
  location:     'City, Country',   // avoid emoji — see note above
  achievements: [
    'Led a team of 5 engineers...',
    'Reduced crash rate by 40%...',
  ],
),
```

---

## Deployment

Deployment is fully automated — just push to `main`.

### How it works

```
push to main
    └─▶  GitHub Actions  (.github/workflows/deploy.yml)
              └─▶  flutter build web --release --wasm --base-href /your-repo-name/
                        └─▶  push build/web to gh-pages branch
```

### First-time GitHub Pages setup (one-time only)

1. Go to your repo → **Settings → Pages**
2. Under *Source*, select **Deploy from a branch**
3. Branch: **`gh-pages`** / folder: **`/ (root)`** → **Save**

The site will be live at `https://<username>.github.io/<reponame>` after the first Actions run completes (~2–3 min).

### Changing the URL path

The URL path equals the repo name. To change it (e.g. `github.io/portfolio`):

1. Rename the repo on GitHub (Settings → Repository name)
2. Update `--base-href` in `.github/workflows/deploy.yml`:
   ```yaml
   run: flutter build web --release --base-href /your-new-name/ --wasm
   ```
3. Update your local remote:
   ```bash
   git remote set-url origin git@github.com:youruser/your-new-name.git
   ```

### Manual build (optional)

```bash
fvm flutter build web --release --base-href /your-repo-name/ --wasm
```

Output goes to `build/web/`. The `--wasm` flag uses the Skwasm renderer (~1.7 MB) instead of CanvasKit (~5.6 MB), cutting initial load time significantly.

---

## Customising the loading splash

Edit the HTML in `web/index.html`. The splash is pure HTML/CSS — it renders instantly before Flutter loads and dismisses itself on the `flutter-first-frame` event.

Update these three values inside the `<div id="loading">` block:

```html
<div class="splash-monogram"><span>YN</span></div>  <!-- 2-letter monogram -->
<div class="splash-name">Your Name</div>
<div class="splash-role">Your Job Title</div>
```

Key CSS classes: `.splash-monogram`, `.splash-name`, `.splash-role`, `.splash-dots`

Colours in the splash match the site palette — update them if you change `AppColors.accent` or `AppColors.bg`.

---

## Dependencies

| Package | Purpose |
|---|---|
| `flutter_animate` | Section entrance and hover animations |
| `flutter_riverpod` | Theme toggle state |
| `google_fonts` | Inter typeface |
| `url_launcher` | Open links / mailto |

---

## Project structure

```
lib/
├── core/
│   ├── constants/
│   │   └── portfolio_content.dart   ← EDIT THIS FILE TO CUSTOMISE
│   ├── theme/
│   │   ├── app_colors.dart          ← colour palette
│   │   ├── app_theme.dart           ← Material theme config
│   │   └── app_typography.dart      ← named text styles
│   └── utils/responsive.dart
├── features/
│   ├── hero/hero_section.dart
│   ├── about/about_section.dart
│   ├── projects/project_section.dart
│   ├── experience/experience_section.dart
│   └── contact/contact_section.dart
├── shared/
│   ├── layout/app_container.dart
│   └── widgets/
│       ├── app_navbar.dart
│       ├── section_title.dart
│       └── footer.dart
└── main.dart

web/
├── index.html    ← loading splash + SEO meta tags
└── 404.html      ← GitHub Pages SPA routing workaround

.github/
└── workflows/
    └── deploy.yml   ← CI/CD pipeline
```
