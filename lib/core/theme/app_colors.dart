import 'package:flutter/material.dart';

/// ShweWords brand palette aligned with [example.dart].
class AppColors {
  AppColors._();

  static const gold = Color(0xFFD4AF37);

  static const lightScaffold = Color(0xFFF5F5F0);
  static const lightCard = Color(0xFFFFFFFF);
  static const lightSearchFill = Color(0xFFECECE6);
  static const lightMutedText = Color(0xFF6B6B65);
  static const lightTitle = Color(0xFF1A1A18);

  static const darkScaffold = Color(0xFF121214);
  static const darkCard = Color(0xFF1C1C20);
  static const darkSearchFill = Color(0xFF1C1C20);
  static const darkTitle = Color(0xFFFFFFFF);

  /// Material grey shades used in example.dart.
  static const grey300 = Color(0xFFE0E0E0);
  static const grey400 = Color(0xFFBDBDBD);
  static const grey500 = Color(0xFF9E9E9E);

  static const englishTabActive = Color(0xFFD8EAD8);
  static const englishTabActiveText = Color(0xFF2A3D2A);
  static const englishTabActiveDark = Color(0xFF2A3A2A);
  static const tabActiveGreen = Color(0xFF81C784);

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
      brightness == Brightness.dark ? grey400 : lightMutedText;

  static Color secondaryText(Brightness brightness) =>
      brightness == Brightness.dark ? grey300 : lightMutedText;

  static Color goldBorder(Brightness brightness) => gold;

  static Color goldBorderSubtle(Brightness brightness, {double alpha = 0.5}) =>
      gold.withValues(alpha: alpha);

  static Color goldBorderCard(Brightness brightness) =>
      gold.withValues(alpha: 0.4);

  static Color goldIcon(Brightness brightness, {double alpha = 0.8}) =>
      gold.withValues(alpha: alpha);

  static Color inactiveTabForeground(Brightness brightness) =>
      brightness == Brightness.dark ? grey400 : lightMutedText;

  static Color activeTabForeground(Brightness brightness) =>
      brightness == Brightness.dark ? tabActiveGreen : englishTabActiveText;

  static Color searchIcon(Brightness brightness) =>
      brightness == Brightness.dark ? grey500 : lightMutedText;

  static List<BoxShadow> cardGlow(Brightness brightness) {
    if (brightness == Brightness.light) return const [];
    return [
      BoxShadow(
        color: gold.withValues(alpha: 0.4),
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
