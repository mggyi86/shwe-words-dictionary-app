import 'package:flutter/material.dart';

enum AppLogoVariant {
  /// Full logo with app name and tagline.
  full,

  /// Square icon for app bar, favicon-style, and small spaces.
  icon,
}

/// Responsive ShweWords logo that scales cleanly at any size and density.
///
/// Uses high-resolution PNG assets; Flutter scales them per device pixel ratio.
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

  /// Intrinsic aspect ratio of [logo.png] (width / height).
  static const _logoAspectRatio = 472 / 481;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final dpr = mediaQuery.devicePixelRatio;

    final displayWidth = width ??
        switch (variant) {
          AppLogoVariant.full => mediaQuery.size.width * 0.75,
          AppLogoVariant.icon => 48.0,
        };

    final displayHeight = height ??
        switch (variant) {
          AppLogoVariant.full => displayWidth / _logoAspectRatio,
          AppLogoVariant.icon => displayWidth,
        };

    final asset = variant == AppLogoVariant.full ? _fullAsset : _iconAsset;
    final cacheWidth = (displayWidth * dpr).round();
    final cacheHeight = (displayHeight * dpr).round();

    return Semantics(
      label: semanticLabel,
      image: true,
      child: Image.asset(
        asset,
        width: displayWidth,
        height: displayHeight,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
        gaplessPlayback: true,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.menu_book_rounded,
          size: displayHeight,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
