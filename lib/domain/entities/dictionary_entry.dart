import 'package:freezed_annotation/freezed_annotation.dart';

part 'dictionary_entry.freezed.dart';
part 'dictionary_entry.g.dart';

@freezed
class Definition with _$Definition {
  const factory Definition({
    String? pos,
    @Default([]) List<String> meanings,
    @Default([]) List<String> examples,
  }) = _Definition;

  factory Definition.fromJson(Map<String, dynamic> json) =>
      _$DefinitionFromJson(json);
}

@freezed
class DictionaryEntry with _$DictionaryEntry {
  const factory DictionaryEntry({
    required String word,
    required String language,
    String? dictionarySlug,
    @Default([]) List<Definition> definitions,
    @Default([]) List<String> synonyms,
  }) = _DictionaryEntry;

  factory DictionaryEntry.fromJson(Map<String, dynamic> json) =>
      _$DictionaryEntryFromJson(json);
}

extension DictionaryEntryX on DictionaryEntry {
  String get primaryMeaning {
    for (final def in definitions) {
      if (def.meanings.isNotEmpty) return def.meanings.first;
    }
    return '';
  }

  List<String> get allMeanings =>
      definitions.expand((d) => d.meanings).toList();

  List<String> get allExamples =>
      definitions.expand((d) => d.examples).toList();

  /// Compact preview for search result cards (`~ gloss meaning`).
  String get cardPreviewLine {
    final meaning = primaryMeaning;
    final pos = definitions.isNotEmpty ? definitions.first.pos : null;
    if (pos != null && pos.isNotEmpty) {
      if (meaning.isNotEmpty && meaning != pos) {
        return '~ $pos $meaning';
      }
      return '~ $pos';
    }
    if (meaning.isNotEmpty) return '~ $meaning';
    return '';
  }
}
