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

/// Grouped part-of-speech preview for search result cards.
class EntryCardSection {
  const EntryCardSection({
    required this.pos,
    required this.lines,
  });

  final String pos;
  final List<String> lines;
}

/// Visual style for a meaning line on the word detail page.
enum DetailLineKind {
  gloss,
  translation,
  domain,
  conjugation,
}

/// A single meaning line in a detail section.
class DetailMeaningLine {
  const DetailMeaningLine({
    required this.text,
    required this.kind,
    this.domainLabel,
  });

  final String text;
  final DetailLineKind kind;
  final String? domainLabel;
}

/// One sense block (meanings + examples) within a part of speech.
class DetailBlock {
  const DetailBlock({
    required this.meanings,
    required this.examples,
  });

  final List<DetailMeaningLine> meanings;
  final List<String> examples;
}

/// Full part-of-speech section for the word detail page.
class DetailSection {
  const DetailSection({
    required this.pos,
    required this.blocks,
  });

  final String pos;
  final List<DetailBlock> blocks;
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

  static const _cardPosLimits = <String, int>{
    'noun': 2,
    'verb': 1,
  };

  static const _cardPosOrder = ['noun', 'verb'];

  static const _detailPosOrder = [
    'noun',
    'verb',
    'adjective',
    'adverb',
    'preposition',
    'conjunction',
    'interjection',
    'pronoun',
    'determiner',
  ];

  static final _domainPrefix = RegExp(
    r'^(mathematics|grammar|formal|dated|sing|plural|usu|esp|espBrit|esp Brit|often|usually|British|US)\b',
    caseSensitive: false,
  );

  static final _conjugationHint = RegExp(
    r'\(\d+(?:st|nd|rd|th) person\)|past tense|present participle|past participle',
    caseSensitive: false,
  );

  /// Format a single meaning line for card preview.
  static String formatCardLine(String raw, String pos) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) return '';

    final isVerb = pos.toLowerCase() == 'verb';
    if (isVerb) {
      if (trimmed.startsWith('-')) return trimmed;
      return '- $trimmed';
    }

    if (trimmed.startsWith('~')) return trimmed;
    return '~ $trimmed';
  }

  /// Build grouped card sections (up to 2 noun + 1 verb lines).
  static List<EntryCardSection> cardSectionsFromEntry(DictionaryEntry entry) {
    if (entry.definitions.isEmpty) return const [];

    final byPos = <String, List<String>>{};
    for (final def in entry.definitions) {
      final pos = def.pos?.trim().toLowerCase();
      if (pos == null || pos.isEmpty) continue;
      final limit = _cardPosLimits[pos];
      if (limit == null) continue;

      final bucket = byPos.putIfAbsent(pos, () => []);
      for (final meaning in def.meanings) {
        if (bucket.length >= limit) break;
        final line = formatCardLine(meaning, pos);
        if (line.isNotEmpty) bucket.add(line);
      }
    }

    final sections = _cardPosOrder
        .where((pos) => byPos[pos]?.isNotEmpty ?? false)
        .map((pos) => EntryCardSection(pos: pos, lines: byPos[pos]!))
        .toList();

    if (sections.isNotEmpty) return sections;

    final def = entry.definitions.first;
    final pos = def.pos?.trim().toLowerCase();
    if (pos == null || pos.isEmpty) return const [];

    final lines = <String>[];
    for (final meaning in def.meanings) {
      final line = formatCardLine(meaning, pos);
      if (line.isNotEmpty) lines.add(line);
      if (lines.length >= 2) break;
    }

    if (lines.isEmpty && def.examples.isNotEmpty) {
      lines.add(formatCardLine(def.examples.first, pos));
    }

    if (lines.isEmpty) return const [];
    return [EntryCardSection(pos: pos, lines: lines)];
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

  /// Build full detail sections grouped by part of speech.
  static List<DetailSection> detailSectionsFromEntry(DictionaryEntry entry) {
    if (entry.definitions.isEmpty) return const [];

    final orderedPos = <String>[];
    final blocksByPos = <String, List<DetailBlock>>{};

    for (final def in entry.definitions) {
      final pos = def.pos?.trim().toLowerCase() ?? '';
      if (pos.isEmpty) continue;

      if (!blocksByPos.containsKey(pos)) {
        orderedPos.add(pos);
        blocksByPos[pos] = [];
      }

      final meanings = def.meanings
          .map((raw) => toDetailMeaningLine(raw, pos))
          .where((line) => line.text.isNotEmpty)
          .toList();

      if (meanings.isEmpty && def.examples.isEmpty) continue;

      blocksByPos[pos]!.add(
        DetailBlock(
          meanings: meanings,
          examples: List<String>.from(def.examples),
        ),
      );
    }

    orderedPos.sort(_comparePos);

    return orderedPos
        .map((pos) => DetailSection(pos: pos, blocks: blocksByPos[pos]!))
        .toList();
  }

  /// Classify and normalize a raw meaning string for detail display.
  static DetailMeaningLine toDetailMeaningLine(String raw, String pos) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) {
      return const DetailMeaningLine(
        text: '',
        kind: DetailLineKind.translation,
      );
    }

    if (trimmed.startsWith('~')) {
      return DetailMeaningLine(text: trimmed, kind: DetailLineKind.gloss);
    }

    if (_conjugationHint.hasMatch(trimmed)) {
      return DetailMeaningLine(
        text: trimmed.startsWith('-') ? trimmed : '- $trimmed',
        kind: DetailLineKind.conjugation,
      );
    }

    final domainMatch = _domainPrefix.firstMatch(trimmed);
    if (domainMatch != null) {
      final label = domainMatch.group(1)!;
      final rest = trimmed.substring(domainMatch.end).trim();
      return DetailMeaningLine(
        text: rest.isEmpty ? trimmed : rest,
        kind: DetailLineKind.domain,
        domainLabel: label,
      );
    }

    return DetailMeaningLine(text: trimmed, kind: DetailLineKind.translation);
  }

  static int _comparePos(String a, String b) {
    final ai = _detailPosOrder.indexOf(a);
    final bi = _detailPosOrder.indexOf(b);
    if (ai != -1 && bi != -1) return ai.compareTo(bi);
    if (ai != -1) return -1;
    if (bi != -1) return 1;
    return a.compareTo(b);
  }
}
