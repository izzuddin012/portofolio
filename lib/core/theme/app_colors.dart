import 'package:flutter/material.dart';

class AppColors {
  // ── Base ──────────────────────────────────────────────────────
  static const Color bg = Color(0xFF0A0A0A);
  static const Color surface = Color(0xFF111111);
  static const Color card = Color(0xFF161616);
  static const Color cardHover = Color(0xFF1C1C1C);
  static const Color border = Color(0xFF222222);
  static const Color borderSoft = Color(0xFF1A1A1A);

  // ── Text ──────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFF5F5F5);
  static const Color textSecondary = Color(0xFF9E9E9E); // ↑ #888→#9E — 4.6:1 on dark bg
  static const Color textMuted = Color(0xFF6E6E6E);     // ↑ #555→#6E — 3.8:1 on dark bg

  // ── Accent (Soft Green) ───────────────────────────────────────
  static const Color accent = Color(0xFF879A77);
  static const Color accentLight = Color(0xFFA3B595);
  static const Color accentDim = Color(0x22879A77);

  // ── Warm (Beige / Taupe) ──────────────────────────────────────
  static const Color warm = Color(0xFFC9AD93);
  static const Color warmDim = Color(0x22C9AD93);

  // ── Project card tints ────────────────────────────────────────────────────
  static const Color tintSlate = Color(0xFF6B8FA0);
  static const Color tintTaupe = Color(0xFF8A7B6B);
  static const Color tintOlive = Color(0xFF7A8B6A);

  // ── Light theme ───────────────────────────────────────────────
  static const Color lightBg = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF4F4F4);
  static const Color lightBorder = Color(0xFFE5E5E5);
  static const Color lightTextPrimary = Color(0xFF0A0A0A);
  static const Color lightTextSecondary = Color(0xFF525252); // ↑ #666→#525 — 6.6:1 on light bg
  static const Color lightTextMuted = Color(0xFF8A8A8A);     // new — for subtle text on light bg
}
