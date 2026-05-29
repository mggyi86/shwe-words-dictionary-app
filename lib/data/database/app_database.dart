import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shwewords/core/config/app_config.dart';
import 'package:shwewords/data/database/tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Entries])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  AppDatabase.connect(QueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onUpgrade: (m, from, to) async {
          // Prebuilt dictionary databases ship without drift metadata.
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  static AppDatabase? _instance;

  static Future<AppDatabase> open({String? overridePath}) async {
    if (_instance != null) return _instance!;

    final dbPath = overridePath ?? await _resolveDatabasePath();
    final file = File(dbPath);

    if (!file.existsSync()) {
      throw StateError('Dictionary database not found at $dbPath');
    }

    final executor = NativeDatabase.createInBackground(
      file,
      setup: (db) {
        db.execute('PRAGMA journal_mode = OFF');
        db.execute('PRAGMA cache_size = -64000');
        db.execute('PRAGMA temp_store = MEMORY');
      },
    );

    _instance = AppDatabase.connect(executor);
    await _instance!.customStatement('PRAGMA query_only = ON');
    return _instance!;
  }

  static Future<String> _resolveDatabasePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return p.join(dir.path, AppConfig.databaseFileName);
  }

  static Future<String> databaseFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return p.join(dir.path, AppConfig.databaseFileName);
  }

  static Future<void> closeInstance() async {
    await _instance?.close();
    _instance = null;
  }

  Future<int> countEntries() async {
    final row = await customSelect('SELECT COUNT(*) AS c FROM entries').getSingle();
    return row.read<int>('c');
  }

  Future<bool> validateIntegrity() async {
    final rows = await customSelect('PRAGMA integrity_check').get();
    if (rows.isEmpty) return false;
    return rows.first.read<String>('integrity_check') == 'ok';
  }
}
