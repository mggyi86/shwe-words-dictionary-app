import 'package:flutter/material.dart';

/// ShweWords brand palette (light + dark) from product mockups.
class AppColors {
  AppColors._();

  static const gold = Color(0xFFC4A35A);
  static const goldDark = Color(0xFFD4B06A);

  static const lightScaffold = Color(0xFFF5F5F0);
  static const lightCard = Color(0xFFFFFFFF);
  static const lightSearchFill = Color(0xFFECECE6);
  static const lightMutedText = Color(0xFF6B6B65);
  static const lightTitle = Color(0xFF1A1A18);

  static const darkScaffold = Color(0xFF1A1C20);
  static const darkCard = Color(0xFF23262B);
  static const darkSearchFill = Color(0xFF2A2D33);
  static const darkMutedText = Color(0xFFB0B0AA);
  static const darkTitle = Color(0xFFF2F2EE);

  static const englishTabActive = Color(0xFFD8EAD8);
  static const englishTabActiveText = Color(0xFF2A3D2A);
  static const englishTabActiveDark = Color(0xFF2E3F32);
  static const englishTabActiveTextDark = Color(0xFFB8D4B8);

  static const synonymTabActiveDark = Color(0xFF2A2620);

  static Color scaffoldBackground(Brightness brightness) =>
      brightness == Brightness.dark ? darkScaffold : lightScaffold;

  static Color cardBackground(Brightness brightness) =>
      brightness == Brightness.dark ? darkCard : lightCard;

  static Color searchFill(Brightness brightness) =>
      brightness == Brightness.dark ? darkSearchFill : lightSearchFill;

  static Color primaryText(Brightness brightness) =>
      brightness == Brightness.dark ? darkTitle : lightTitle;

  static Color mutedText(Brightness brightness) =>
      brightness == Brightness.dark ? darkMutedText : lightMutedText;

  static Color goldBorder(Brightness brightness) =>
      brightness == Brightness.dark ? goldDark : gold;

  static List<BoxShadow> cardGlow(Brightness brightness) {
    if (brightness == Brightness.light) return const [];
    return [
      BoxShadow(
        color: gold.withValues(alpha: 0.28),
        blurRadius: 10,
        spreadRadius: 0,
      ),
    ];
  }

  static List<BoxShadow> tabGlow(Brightness brightness) {
    if (brightness == Brightness.light) return const [];
    return [
      BoxShadow(
        color: gold.withValues(alpha: 0.45),
        blurRadius: 12,
        spreadRadius: 0,
      ),
    ];
  }
}
