import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:devolio_flutter/core/theme/app_colors.dart';

/// Single source of truth for every text style in the app.
///
/// Rules:
///  • Styles whose colour is ALWAYS the same (e.g. accent labels) bake the
///    colour in.
///  • Styles that change with the theme are defined WITHOUT a colour so the
///    call-site applies `.copyWith(color: ...)`.
///  • Responsive styles (hero) are static methods taking [isDesktop].
class AppTypography {
  // ── Hero ──────────────────────────────────────────────────────────────────

  /// Large name heading — 80 pt desktop / 52 pt mobile.
  static TextStyle heroName(bool isDesktop) => GoogleFonts.inter(
        fontSize: isDesktop ? 80 : 52,
        fontWeight: FontWeight.w700,
        letterSpacing: -3,
        height: 1.0,
      );

  /// Accent `=` prefix beside the role line.
  static TextStyle heroRoleAccent(bool isDesktop) => GoogleFonts.inter(
        fontSize: isDesktop ? 28 : 20,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
        color: AppColors.accent,
      );

  /// Role text next to the accent prefix (no colour — apply via copyWith).
  static TextStyle heroRoleText(bool isDesktop) => GoogleFonts.inter(
        fontSize: isDesktop ? 28 : 20,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
      );

  /// Tagline below the role line.
  static TextStyle heroTagline(bool isDesktop) => GoogleFonts.inter(
        fontSize: isDesktop ? 17 : 14,
        height: 1.75,
        fontWeight: FontWeight.w300,
        color: AppColors.textSecondary,
      );

  /// Bouncing "Scroll" label at the bottom of the hero.
  static final TextStyle scrollIndicator = GoogleFonts.inter(
    fontSize: 11,
    letterSpacing: 1.5,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
  );

  // ── Badges ────────────────────────────────────────────────────────────────

  /// Availability pill badge ("Open to opportunities").
  static final TextStyle statusBadge = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.3,
    color: AppColors.accentLight,
  );

  /// Date range badge on experience cards.
  static final TextStyle dateBadge = GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
    color: AppColors.accentLight,
  );

  // ── Section titles ────────────────────────────────────────────────────────

  /// Small-caps accent label above section headings (e.g. "— ABOUT ME").
  static final TextStyle sectionLabel = GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 3,
    color: AppColors.accent,
  );

  /// Large section heading (38 pt). Colour applied via copyWith / theme.
  static final TextStyle sectionHeading = GoogleFonts.inter(
    fontSize: 38,
    fontWeight: FontWeight.w600,
    letterSpacing: -1.2,
    height: 1.1,
  );

  /// Subtitle line beneath a section heading. No colour — apply via copyWith.
  static final TextStyle sectionSubtitle = GoogleFonts.inter(
    fontSize: 15,
    height: 1.6,
    fontWeight: FontWeight.w400,
  );

  // ── Body text ─────────────────────────────────────────────────────────────

  /// Large body — bio paragraphs (15 pt). No colour — apply via copyWith.
  static final TextStyle bodyLg = GoogleFonts.inter(
    fontSize: 15,
    height: 1.85,
    fontWeight: FontWeight.w400,
  );

  /// Standard body — achievements, descriptions (14 pt). No colour — apply via copyWith.
  static final TextStyle bodyMd = GoogleFonts.inter(
    fontSize: 14,
    height: 1.65,
    fontWeight: FontWeight.w400,
  );

  /// Small body — social description, misc labels (13 pt).
  static final TextStyle bodySm = GoogleFonts.inter(
    fontSize: 13,
    height: 1.75,
    fontWeight: FontWeight.w400,
  );

  // ── Accent text ───────────────────────────────────────────────────────────

  /// Italic philosophy / blockquote.
  static final TextStyle quote = GoogleFonts.inter(
    fontSize: 13,
    height: 1.75,
    fontStyle: FontStyle.italic,
    color: AppColors.accentLight,
  );

  /// ALL-CAPS category label (e.g. "MOBILE DEVELOPMENT", "QUICK INFO").
  static final TextStyle categoryLabel = GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    letterSpacing: 2,
    color: AppColors.accent,
  );

  // ── Skills ────────────────────────────────────────────────────────────────

  /// Skill chip pill text. No colour — apply via copyWith.
  static final TextStyle skillPill = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.1,
  );

  // ── Navigation ────────────────────────────────────────────────────────────

  /// Navbar brand / logo. No colour — apply via copyWith.
  static final TextStyle navLogo = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  );

  /// Inactive nav link. No colour — apply via copyWith.
  static final TextStyle navLink = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
  );

  /// Active nav link.
  static final TextStyle navLinkActive = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
  );

  /// GitHub button label in the navbar.
  static final TextStyle navGithubBtn = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  /// Mobile drawer nav item (inactive). No colour — apply via copyWith.
  static final TextStyle mobileNavItem = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  /// Mobile drawer nav item (active).
  static final TextStyle mobileNavItemActive = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  // ── CTA / Buttons ─────────────────────────────────────────────────────────

  /// Primary CTA button label (e.g. "VIEW WORK", "SEND MESSAGE").
  /// No colour — apply via copyWith.
  static final TextStyle ctaLabel = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
  );

  // ── Project cards ─────────────────────────────────────────────────────────

  /// Filter chip label (All / Mobile / Web / Backend).
  static final TextStyle filterChip = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  /// Project card title. No colour — apply via copyWith.
  static final TextStyle cardTitle = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.3,
  );

  /// Project card description. No colour — apply via copyWith.
  static final TextStyle cardDesc = GoogleFonts.inter(
    fontSize: 13,
    height: 1.6,
    fontWeight: FontWeight.w400,
  );

  /// Tech stack tag inside a project card. No colour — apply via copyWith.
  static final TextStyle techTag = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  // ── Experience ────────────────────────────────────────────────────────────

  /// Job title. No colour — apply via copyWith.
  static final TextStyle expRole = GoogleFonts.inter(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.4,
  );

  /// Company name — always accent.
  static final TextStyle expCompany = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.accent,
  );

  /// Location beside the company name. No colour — apply via copyWith.
  static final TextStyle expLocation = GoogleFonts.inter(
    fontSize: 13,
  );

  /// Achievement bullet text. No colour — apply via copyWith.
  static final TextStyle expAchievement = GoogleFonts.inter(
    fontSize: 14,
    height: 1.65,
    fontWeight: FontWeight.w400,
  );

  // ── Contact ───────────────────────────────────────────────────────────────

  /// Contact row field label (Email, Location, Status …).
  static final TextStyle contactMetaLabel = GoogleFonts.inter(
    fontSize: 11,
    letterSpacing: 0.5,
    color: AppColors.textMuted,
  );

  /// Contact row value text. No colour — apply via copyWith.
  static final TextStyle contactMetaValue = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  /// Clickable email / URL in contact rows.
  static final TextStyle contactLink = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.accent,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.accent,
  );

  /// Social platform name inside a social card. No colour — apply via copyWith.
  static final TextStyle socialPlatform = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  /// Social handle / username. No colour — apply via copyWith.
  static final TextStyle socialHandle = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  /// Text input field style.
  static final TextStyle formInput = GoogleFonts.inter(fontSize: 14);

  // ── Contact form success ──────────────────────────────────────────────────

  /// "Message sent!" heading.
  static final TextStyle successTitle = GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
    color: AppColors.textPrimary,
  );

  /// Success card body text. No colour — apply via copyWith.
  static final TextStyle successDesc = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );

  /// "Send another message →" link.
  static final TextStyle successLink = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.accent,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.accent,
  );

  // ── Footer ────────────────────────────────────────────────────────────────

  /// Copyright + "Built with Flutter Web" lines.
  static final TextStyle footerText = GoogleFonts.inter(
    fontSize: 12,
    color: AppColors.textMuted,
  );

  /// Footer brand name. No colour — apply via copyWith.
  static final TextStyle footerBrand = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  );

  /// Footer brand role line.
  static final TextStyle footerBrandRole = GoogleFonts.inter(
    fontSize: 13,
    color: AppColors.accent,
  );

  /// Footer brand location line.
  static final TextStyle footerBrandLocation = GoogleFonts.inter(
    fontSize: 12,
    color: AppColors.textMuted,
  );

  /// Footer navigation link. No colour — apply via copyWith.
  static final TextStyle footerNavLink = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );
}
