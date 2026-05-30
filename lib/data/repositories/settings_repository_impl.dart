import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shwewords/core/theme/myanmar_font_choice.dart';
import 'package:shwewords/domain/entities/download_status.dart';
import 'package:shwewords/domain/repositories/repositories.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  static const _settingsKey = 'app_settings';

  @override
  Future<AppSettings> getSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_settingsKey);
    if (raw == null) return const AppSettings();

    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return AppSettings(
        wifiOnlyDownload: map['wifiOnlyDownload'] as bool? ?? false,
        myanmarFontScale: (map['myanmarFontScale'] as num?)?.toDouble() ?? 1.0,
        myanmarFont: MyanmarFontChoice.fromStorage(
          map['myanmarFont'] as String?,
        ),
        preferredLanguage: map['preferredLanguage'] as String? ?? 'en',
      );
    } catch (_) {
      return const AppSettings();
    }
  }

  @override
  Future<void> saveSettings(AppSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _settingsKey,
      jsonEncode({
        'wifiOnlyDownload': settings.wifiOnlyDownload,
        'myanmarFontScale': settings.myanmarFontScale,
        'myanmarFont': settings.myanmarFont.storageValue,
        'preferredLanguage': settings.preferredLanguage,
      }),
    );
  }
}
