import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:shwewords/data/database/app_database.dart';
import 'package:shwewords/data/database/search_queries.dart';
import 'package:shwewords/domain/entities/dictionary_entry.dart';
import 'package:shwewords/domain/entities/search_result.dart';

void main() {
  final sourceDb = File(
    p.join('..', 'dictionary_crawler', 'output', 'dictionary.db'),
  );

  TestWidgetsFlutterBinding.ensureInitialized();

  group('SearchQueries integration', () {
    late Directory tempDir;
    late AppDatabase database;
    late SearchQueries queries;

    setUpAll(() async {
      if (!sourceDb.existsSync()) return;

      tempDir = await Directory.systemTemp.createTemp('shwewords_test_');
      final testDbPath = p.join(tempDir.path, 'dictionary.db');
      await sourceDb.copy(testDbPath);

      final executor = NativeDatabase.createInBackground(
        File(testDbPath),
        setup: (db) {
          db.execute('PRAGMA cache_size = -8000');
        },
      );
      database = AppDatabase.connect(executor);
      queries = SearchQueries(database);
    });

    tearDownAll(() async {
      await database.close();
      if (sourceDb.existsSync()) {
        await tempDir.delete(recursive: true);
      }
    });

    test('exactLookup finds known word', () async {
      if (!sourceDb.existsSync()) return;

      final entry = await queries.exactLookup('water');
      expect(entry, isNotNull);
      expect(entry!.word, 'water');
      expect(entry.allMeanings, isNotEmpty);
    }, skip: !sourceDb.existsSync() ? 'dictionary.db not found' : false);

    test('english search returns results for prefix', () async {
      if (!sourceDb.existsSync()) return;

      final page = await queries.search(
        query: 'wat',
        mode: SearchMode.english,
        limit: 10,
      );
      expect(page.results, isNotEmpty);
      expect(
        page.results.any(
          (r) => r.word.toLowerCase().contains('wat'),
        ),
        isTrue,
      );
    }, skip: !sourceDb.existsSync() ? 'dictionary.db not found' : false);

    test('lookupEntryIds returns ids for known words only', () async {
      if (!sourceDb.existsSync()) return;

      final ids = await queries.lookupEntryIds(
        ['water', 'bring', 'not-a-real-word-xyz'],
      );

      expect(ids['water'], isNotNull);
      expect(ids['bring'], isNotNull);
      expect(ids.containsKey('not-a-real-word-xyz'), isFalse);
    }, skip: !sourceDb.existsSync() ? 'dictionary.db not found' : false);

    test('myanmar search executes without error', () async {
      if (!sourceDb.existsSync()) return;

      final page = await queries.search(
        query: 'ရေ',
        mode: SearchMode.myanmar,
        limit: 10,
      );
      expect(page.results, isA<List<SearchResult>>());
    }, skip: !sourceDb.existsSync() ? 'dictionary.db not found' : false);
  });
}
