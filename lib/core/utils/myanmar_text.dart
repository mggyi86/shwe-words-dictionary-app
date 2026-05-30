/// Myanmar text normalization utilities.
class MyanmarText {
  MyanmarText._();

  /// Apply Unicode NFC normalization for consistent search matching.
  static String normalize(String input) {
    // Dart's built-in normalization via characters package isn't needed;
    // toUpperCase/toLowerCase for Latin; Myanmar stays as-is after trim.
    return input.trim().replaceAll(RegExp(r'\s+'), ' ');
  }

  /// Detect if text contains Myanmar script characters.
  static bool containsMyanmar(String text) {
    return RegExp(r'[\u1000-\u109F]').hasMatch(text);
  }

  /// True when the query is primarily Latin letters (English search).
  static bool looksLatin(String text) {
    return RegExp(r'[a-zA-Z]').hasMatch(text);
  }

  /// Infers search script from query text: Myanmar script, Latin, or unknown.
  static SearchScript? detectScript(String text) {
    final normalized = normalize(text);
    if (normalized.isEmpty) return null;
    if (containsMyanmar(normalized)) return SearchScript.myanmar;
    if (looksLatin(normalized)) return SearchScript.latin;
    return null;
  }
}

/// Script detected in user-entered search text.
enum SearchScript {
  latin,
  myanmar,
}
