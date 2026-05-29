import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shwewords/domain/entities/dictionary_entry.dart';

part 'search_result.freezed.dart';

enum SearchMode {
  english,
  myanmar,
  synonym,
}

@freezed
class SearchResult with _$SearchResult {
  const factory SearchResult({
    required int id,
    required String word,
    required String language,
    required DictionaryEntry entry,
    @Default(0) int rank,
  }) = _SearchResult;
}

@freezed
class SearchPage with _$SearchPage {
  const factory SearchPage({
    required List<SearchResult> results,
    required bool hasMore,
    @Default(0) int offset,
  }) = _SearchPage;
}
