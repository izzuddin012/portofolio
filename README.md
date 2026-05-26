# Devolio — Flutter Web Portfolio

A sleek, production-ready personal developer portfolio built with Flutter Web.

## ✨ Features

- Animated hero section with particle background and typewriter title
- About section with tech stack grid and hover effects
- Projects section with category filtering and GitHub/demo links
- Experience timeline with collapsible entries
- Contact form with mailto fallback + social links
- Dark/light theme toggle (dark by default)
- Fully responsive: mobile, tablet, desktop
- Scroll-triggered animations via `flutter_animate`
- Optimized for GitHub Pages deployment

---

## 🚀 Local Setup

### Prerequisites
- Flutter 3.x (`fvm use 3.32.8` if using FVM)

### Run locally

```bash
flutter pub get
flutter run -d chrome
```

---

## ✏️ Customizing Content

All user-facing text is in one file — **`lib/core/constants/app_constants.dart`**

Edit: `name`, `heroTagline`, `cvUrl`, `githubUrl`, `linkedinUrl`, `twitterUrl`, `email`, bio paragraphs.

### Projects

Edit **`lib/features/projects/project_data.dart`** — add/remove `Project` entries with `title`, `description`, `techStack`, `category`, `githubUrl`, `demoUrl`.

### Experience

Edit **`lib/features/experience/experience_data.dart`** — add `Experience` entries with `company`, `role`, `dateRange`, `location`, `achievements`.

### Avatar / Photo

In `lib/features/hero/hero_section.dart`, find `_HeroAvatar` and replace the placeholder with:

```dart
ClipOval(child: Image.network('your-photo-url', width: size, height: size, fit: BoxFit.cover))
```

---

## 🚢 GitHub Pages Deployment

### 1. Build

```bash
# Sub-path deploy (user.github.io/<repo>)
flutter build web --base-href "/<repo-name>/"

# Custom domain
flutter build web --base-href "/"
```

### 2. Deploy via `/docs` folder

```bash
cp -r build/web/* docs/
git add docs/ && git commit -m "deploy" && git push
```

Set GitHub Pages source → `main` branch, `/docs` folder.

### 3. 404 handling

`web/404.html` handles SPA routing on GitHub Pages automatically. Check `pathSegmentsToKeep` inside it:
- Custom domain → `0`
- `user.github.io/<repo>` → `1` (default)

---

## 📦 Key Dependencies

| Package | Purpose |
|---|---|
| `flutter_animate` | Entry/scroll animations |
| `flutter_riverpod` | Theme toggle state |
| `google_fonts` | Space Grotesk typography |
| `url_launcher` | Open links / mailto |
| `responsive_framework` | Breakpoint helpers |

---

## 🎨 Theming

- Colors → `lib/core/theme/app_colors.dart`
- Theme config → `lib/core/theme/app_theme.dart`
- Theme toggle state → `lib/providers.dart`

---

## 📁 Structure

```
lib/
├── core/
│   ├── constants/app_constants.dart   ← all text + TODOs
│   ├── theme/app_colors.dart + app_theme.dart
│   └── utils/responsive.dart
├── features/
│   ├── hero/hero_section.dart
│   ├── about/about_section.dart
│   ├── projects/project_section.dart + data + model
│   ├── experience/experience_section.dart + data + model
│   └── contact/contact_section.dart
├── shared/
│   ├── layout/app_container.dart
│   └── widgets/app_navbar.dart + section_title.dart + footer.dart
├── providers.dart
└── main.dart
web/
├── index.html     ← GitHub Pages ready
└── 404.html       ← SPA routing redirect
```
