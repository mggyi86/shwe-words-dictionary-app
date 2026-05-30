import 'package:shwewords/data/datasources/local/dictionary_local_ds.dart';
import 'package:shwewords/domain/entities/dictionary_entry.dart';
import 'package:shwewords/domain/entities/search_result.dart';
import 'package:shwewords/domain/repositories/repositories.dart';

class SearchRepositoryImpl implements SearchRepository {
  SearchRepositoryImpl(this._local);

  final DictionaryLocalDataSource _local;

  @override
  Future<DictionaryEntry?> exactLookup(
    String word, {
    String language = 'en',
  }) {
    return _local.searchQueries.exactLookup(word, language: language);
  }

  @override
  Future<Map<String, int>> lookupEntryIds(
    Iterable<String> words, {
    String language = 'en',
  }) {
    return _local.searchQueries.lookupEntryIds(words, language: language);
  }

  @override
  Future<SearchPage> search(
    String query, {
    required SearchMode searchMode,
    String language = 'en',
    int limit = 30,
    int offset = 0,
  }) {
    return _local.searchQueries.search(
      query: query,
      mode: searchMode,
      language: language,
      limit: limit,
      offset: offset,
    );
  }

  @override
  Future<DictionaryEntry?> getEntryById(int id) {
    return _local.searchQueries.getEntryById(id);
  }
}
