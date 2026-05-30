import 'package:flutter_tts/flutter_tts.dart';
import 'package:shwewords/core/utils/myanmar_text.dart';

/// Text-to-speech for dictionary headwords and glosses.
class PronunciationService {
  PronunciationService() : _tts = FlutterTts();

  final FlutterTts _tts;
  bool _initialized = false;

  Future<void> speak(String text, {String? language}) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    await _ensureInitialized();
    await _tts.stop();

    final locale = _localeFor(language, trimmed);
    if (locale != null) {
      await _tts.setLanguage(locale);
    }

    await _tts.speak(trimmed);
  }

  Future<void> dispose() async {
    await _tts.stop();
  }

  Future<void> _ensureInitialized() async {
    if (_initialized) return;
    await _tts.setSpeechRate(0.45);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
    _initialized = true;
  }

  String? _localeFor(String? language, String text) {
    final code = language?.toLowerCase();
    if (code == 'en' || code == 'english') return 'en-US';
    if (code == 'my' ||
        code == 'mm' ||
        code == 'myanmar' ||
        code == 'burmese') {
      return 'my-MM';
    }
    if (MyanmarText.containsMyanmar(text)) return 'my-MM';
    return 'en-US';
  }
}
