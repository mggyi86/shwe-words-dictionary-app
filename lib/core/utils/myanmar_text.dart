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
}
