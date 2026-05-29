import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:shwewords/core/config/app_config.dart';
import 'package:shwewords/core/utils/fts_query_sanitizer.dart';
import 'package:shwewords/core/utils/myanmar_text.dart';
import 'package:shwewords/data/database/app_database.dart';
import 'package:shwewords/domain/entities/dictionary_entry.dart';
import 'package:shwewords/domain/entities/search_result.dart';

class SearchQueries {
  SearchQueries(this._db);

  final AppDatabase _db;

  Future<DictionaryEntry?> exactLookup(String word, {String language = 'en'}) async {
    final normalized = word.trim();
    if (normalized.isEmpty) return null;

    final rows = await _db.customSelect(
      '''
      SELECT data FROM entries
      WHERE word = ? AND language = ?
      LIMIT 1
      ''',
      variables: [
        Variable.withString(normalized),
        Variable.withString(language),
      ],
    ).get();

    if (rows.isEmpty) return null;
    return _parseEntry(rows.first.read<String>('data'));
  }

  Future<SearchPage> search({
    required String query,
    required SearchMode mode,
    String language = 'en',
    int limit = AppConfig.searchPageSize,
    int offset = 0,
  }) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      return const SearchPage(results: [], hasMore: false, offset: 0);
    }

    return switch (mode) {
      SearchMode.english => _englishSearch(trimmed, language, limit, offset),
      SearchMode.myanmar => _myanmarSearch(trimmed, language, limit, offset),
      SearchMode.synonym => _synonymSearch(trimmed, language, limit, offset),
    };
  }

  Future<DictionaryEntry?> getEntryById(int id) async {
    final rows = await _db.customSelect(
      'SELECT data FROM entries WHERE id = ? LIMIT 1',
      variables: [Variable.withInt(id)],
    ).get();

    if (rows.isEmpty) return null;
    return _parseEntry(rows.first.read<String>('data'));
  }

  Future<SearchPage> _englishSearch(
    String query,
    String language,
    int limit,
    int offset,
  ) async {
    final matchQuery = FtsQuerySanitizer.prefixQuery('word', query);
    if (matchQuery.isEmpty) {
      return SearchPage(results: [], hasMore: false, offset: offset);
    }

    return _ftsSearch(
      matchQuery: matchQuery,
      language: language,
      limit: limit,
      offset: offset,
    );
  }

  Future<SearchPage> _myanmarSearch(
    String query,
    String language,
    int limit,
    int offset,
  ) async {
    final useTrigram = MyanmarText.containsMyanmar(query);
    final matchQuery = useTrigram
        ? FtsQuerySanitizer.trigramQuery('meanings_my', query)
        : FtsQuerySanitizer.prefixQuery('meanings_my', query);

    if (matchQuery.isEmpty) {
      return SearchPage(results: [], hasMore: false, offset: offset);
    }

    return _ftsSearch(
      matchQuery: matchQuery,
      language: language,
      limit: limit,
      offset: offset,
    );
  }

  Future<SearchPage> _synonymSearch(
    String query,
    String language,
    int limit,
    int offset,
  ) async {
    final matchQuery = FtsQuerySanitizer.prefixQuery('synonyms', query);
    if (matchQuery.isEmpty) {
      return SearchPage(results: [], hasMore: false, offset: offset);
    }

    return _ftsSearch(
      matchQuery: matchQuery,
      language: language,
      limit: limit,
      offset: offset,
    );
  }

  Future<SearchPage> _ftsSearch({
    required String matchQuery,
    required String language,
    required int limit,
    required int offset,
    String? rankExpression,
    List<Variable> rankVariables = const [],
  }) async {
    final rankSelect = rankExpression ?? '0';
    final variables = <Variable>[
      Variable.withString(matchQuery),
      Variable.withString(language),
      ...rankVariables,
      Variable.withInt(limit + 1),
      Variable.withInt(offset),
    ];

    final rows = await _db.customSelect(
      '''
      SELECT
        e.id AS id,
        e.word AS word,
        e.language AS language,
        e.data AS data,
        $rankSelect AS rank
      FROM entries_fts AS fidx
      JOIN entries AS e ON fidx.rowid = e.id
      WHERE entries_fts MATCH ?
        AND fidx.language = ?
      ORDER BY rank ASC, LENGTH(e.word) ASC, e.word ASC
      LIMIT ? OFFSET ?
      ''',
      variables: variables,
    ).get();

    final hasMore = rows.length > limit;
    final trimmed = hasMore ? rows.sublist(0, limit) : rows;

    final results = trimmed.map((row) {
      final entry = _parseEntry(row.read<String>('data'));
      return SearchResult(
        id: row.read<int>('id'),
        word: row.read<String>('word'),
        language: row.read<String>('language'),
        entry: entry,
        rank: row.read<int>('rank'),
      );
    }).toList();

    return SearchPage(
      results: results,
      hasMore: hasMore,
      offset: offset,
    );
  }

  DictionaryEntry _parseEntry(String jsonStr) {
    final map = jsonDecode(jsonStr) as Map<String, dynamic>;
    return DictionaryEntry.fromJson(map);
  }
}
