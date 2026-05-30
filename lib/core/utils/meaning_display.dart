import 'package:shwewords/domain/entities/dictionary_entry.dart';

/// Parsed lines for search result card display.
class EntryCardLines {
  const EntryCardLines({
    this.pos,
    this.englishLine,
    this.myanmarLine,
  });

  final String? pos;
  final String? englishLine;
  final String? myanmarLine;

  bool get isEmpty =>
      (pos == null || pos!.isEmpty) &&
      (englishLine == null || englishLine!.isEmpty) &&
      (myanmarLine == null || myanmarLine!.isEmpty);
}

/// Splits gloss-style meanings into English and Myanmar display lines.
class MeaningDisplay {
  MeaningDisplay._();

  static final _myanmarStart = RegExp(r'[\u1000-\u109F]');

  /// Parse a single meaning string into English and Myanmar portions.
  static ({String? english, String? myanmar}) parseMeaning(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) return (english: null, myanmar: null);

    final match = _myanmarStart.firstMatch(trimmed);
    if (match == null) {
      return (english: _cleanLatin(trimmed), myanmar: null);
    }

    final latinPart = trimmed.substring(0, match.start);
    final myanmarPart = trimmed.substring(match.start).trim();

    return (
      english: _cleanLatin(latinPart),
      myanmar: myanmarPart.isEmpty ? null : myanmarPart,
    );
  }

  static String? _cleanLatin(String input) {
    var text = input.trim();
    if (text.isEmpty) return null;

    text = text.replaceAll(RegExp(r'~+'), ' ');
    text = text.replaceAll(RegExp(r'\s+'), ' ').trim();
    return text.isEmpty ? null : text;
  }

  /// Build card display lines from the first definition of an entry.
  static EntryCardLines fromEntry(DictionaryEntry entry) {
    if (entry.definitions.isEmpty) return const EntryCardLines();

    final def = entry.definitions.first;
    final pos = def.pos?.trim();
    final meaning = def.meanings.isNotEmpty ? def.meanings.first : '';
    final parsed = parseMeaning(meaning);

    var englishLine = parsed.english;
    if ((englishLine == null || englishLine.isEmpty) &&
        def.examples.isNotEmpty) {
      englishLine = def.examples.first.trim();
    }

    return EntryCardLines(
      pos: pos?.isNotEmpty == true ? pos : null,
      englishLine: englishLine,
      myanmarLine: parsed.myanmar,
    );
  }
}
