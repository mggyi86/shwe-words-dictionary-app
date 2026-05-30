import 'package:shwewords/core/utils/myanmar_text.dart';

/// Sanitizes user input for FTS5 MATCH queries.
class FtsQuerySanitizer {
  FtsQuerySanitizer._();

  static final _ftsSpecialChars = RegExp(r'''["\-()*]''');

  /// Prepare a prefix search term for the [column] FTS field.
  static String prefixQuery(String column, String rawQuery) {
    final normalized = MyanmarText.normalize(rawQuery.trim());
    if (normalized.isEmpty) return '';

    final escaped = normalized.replaceAll(_ftsSpecialChars, ' ').trim();
    if (escaped.isEmpty) return '';

    final tokens = escaped.split(RegExp(r'\s+')).where((t) => t.isNotEmpty);
    if (tokens.isEmpty) return '';

    // For multi-token queries, join with AND for tighter results.
    if (tokens.length == 1) {
      return '$column:${tokens.first}*';
    }
    return tokens.map((t) => '$column:$t*').join(' AND ');
  }

  /// Prepare a trigram partial search (no trailing wildcard needed).
  static String trigramQuery(String column, String rawQuery) {
    final normalized = MyanmarText.normalize(rawQuery.trim());
    if (normalized.isEmpty) return '';

    final escaped = normalized.replaceAll(_ftsSpecialChars, ' ').trim();
    if (escaped.isEmpty) return '';

    return '$column:$escaped';
  }

  /// Escape a literal word for exact FTS phrase matching.
  static String exactPhrase(String column, String rawQuery) {
    final normalized = MyanmarText.normalize(rawQuery.trim());
    if (normalized.isEmpty) return '';
    final escaped = normalized.replaceAll('"', '""');
    return '$column:"$escaped"';
  }

  /// True when [synonym] starts with [query] (trigram FTS can match substrings).
  static bool synonymMatchesPrefix(String synonym, String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return false;

    final normalized = synonym.trim().toLowerCase();
    if (normalized.isEmpty) return false;

    return normalized.startsWith(q);
  }

  /// True when any synonym on the entry starts with [query].
  static bool entrySynonymsMatchPrefix(Iterable<String> synonyms, String query) {
    for (final synonym in synonyms) {
      if (synonymMatchesPrefix(synonym, query)) return true;
    }
    return false;
  }

  /// Synonyms on [synonyms] that start with [query], in list order.
  static List<String> matchingSynonyms(Iterable<String> synonyms, String query) {
    return synonyms
        .where((synonym) => synonymMatchesPrefix(synonym, query))
        .toList();
  }
}
