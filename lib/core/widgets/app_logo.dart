import 'package:flutter/material.dart';

enum AppLogoVariant {
  /// Full wide logo with app name and tagline.
  full,

  /// Square icon suitable for small spaces (app bar, favicon-style).
  icon,
}

/// Responsive ShweWords logo that scales cleanly at any size.
class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.height,
    this.width,
    this.variant = AppLogoVariant.full,
    this.semanticLabel = 'ShweWords logo',
  });

  final double? height;
  final double? width;
  final AppLogoVariant variant;
  final String semanticLabel;

  static const _fullAsset = 'assets/images/logo.png';
  static const _iconAsset = 'assets/images/app_icon.png';

  @override
  Widget build(BuildContext context) {
    final asset = variant == AppLogoVariant.full ? _fullAsset : _iconAsset;
    final maxWidth = width ??
        switch (variant) {
          AppLogoVariant.full => MediaQuery.sizeOf(context).width * 0.75,
          AppLogoVariant.icon => 48.0,
        };

    return Semantics(
      label: semanticLabel,
      image: true,
      child: Image.asset(
        asset,
        height: height,
        width: width,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.menu_book_rounded,
          size: height ?? maxWidth,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
