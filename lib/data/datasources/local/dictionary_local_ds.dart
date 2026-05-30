import 'dart:io';

import 'package:archive/archive.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shwewords/core/config/app_config.dart';
import 'package:shwewords/data/database/app_database.dart';
import 'package:shwewords/data/database/search_queries.dart';

class DictionaryLocalDataSource {
  DictionaryLocalDataSource();

  AppDatabase? _database;
  SearchQueries? _searchQueries;

  static const _dbVersionKey = 'dictionary_db_version';

  AppDatabase get database {
    final db = _database;
    if (db == null) {
      throw StateError('Database not opened');
    }
    return db;
  }

  SearchQueries get searchQueries {
    final q = _searchQueries;
    if (q == null) {
      throw StateError('Database not opened');
    }
    return q;
  }

  Future<String> getDatabasePath() => AppDatabase.databaseFilePath();

  Future<String> getStagingDatabasePath() async {
    final mainPath = await getDatabasePath();
    return p.join(File(mainPath).parent.path, AppConfig.databaseStagingFileName);
  }

  Future<bool> databaseExists() async {
    final path = await getDatabasePath();
    return File(path).existsSync();
  }

  Future<void> openDatabase() async {
    _database = await AppDatabase.open();
    _searchQueries = SearchQueries(_database!);
  }

  Future<void> closeDatabase() async {
    await AppDatabase.closeInstance();
    _database = null;
    _searchQueries = null;
  }

  Future<int> countEntries() async {
    return database.countEntries();
  }

  Future<bool> validateIntegrity() async {
    return database.validateIntegrity();
  }

  Future<bool> validateDatabaseFile(String path) => AppDatabase.validateFile(path);

  /// Replaces the live database with a validated staging file and deletes the old file.
  Future<void> promoteStagingDatabase() async {
    final mainPath = await getDatabasePath();
    final stagingPath = await getStagingDatabasePath();
    final dir = File(mainPath).parent;
    final backupPath = p.join(dir.path, AppConfig.databaseBackupFileName);

    final staging = File(stagingPath);
    if (!staging.existsSync()) {
      throw StateError('Staging database missing at $stagingPath');
    }

    await closeDatabase();

    final main = File(mainPath);
    final backup = File(backupPath);
    if (backup.existsSync()) await backup.delete();

    var movedOldAside = false;
    if (main.existsSync()) {
      await main.rename(backupPath);
      movedOldAside = true;
    }

    try {
      await staging.rename(mainPath);
      if (backup.existsSync()) await backup.delete();
    } catch (e) {
      if (movedOldAside && backup.existsSync()) {
        if (main.existsSync()) await main.delete();
        await backup.rename(mainPath);
      }
      rethrow;
    } finally {
      await openDatabase();
    }
  }

  Future<void> discardStagingDatabase() async {
    final stagingPath = await getStagingDatabasePath();
    final staging = File(stagingPath);
    if (staging.existsSync()) await staging.delete();

    final mainPath = await getDatabasePath();
    final dir = File(mainPath).parent;
    for (final name in [
      AppConfig.databaseTempGzipFileName,
      AppConfig.databaseGzipFileName,
    ]) {
      final file = File(p.join(dir.path, name));
      if (file.existsSync()) await file.delete();
    }
  }

  Future<String?> getLocalDbVersion() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_dbVersionKey);
  }

  Future<void> saveLocalDbVersion(String version) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_dbVersionKey, version);
  }

  Future<void> copyBundledDatabase() async {
    final targetPath = await getDatabasePath();
    final target = File(targetPath);
    final dir = target.parent;
    if (!dir.existsSync()) {
      await dir.create(recursive: true);
    }

    final data = await rootBundle.load(AppConfig.bundledDatabaseAssetPath);
    final bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    if (AppConfig.bundledDatabaseIsGzip) {
      final decoded = GZipDecoder().decodeBytes(bytes);
      if (target.existsSync()) await target.delete();
      await target.writeAsBytes(decoded, flush: true);
    } else {
      await target.writeAsBytes(bytes, flush: true);
    }
  }

  Future<void> deleteDatabase() async {
    await closeDatabase();
    final path = await getDatabasePath();
    final file = File(path);
    if (file.existsSync()) {
      await file.delete();
    }
    final gzPath = p.join(file.parent.path, AppConfig.databaseGzipFileName);
    final gzTmp = p.join(file.parent.path, AppConfig.databaseTempGzipFileName);
    for (final f in [gzPath, gzTmp]) {
      final g = File(f);
      if (g.existsSync()) await g.delete();
    }
  }

  Future<Directory> getDocumentsDirectory() => getApplicationDocumentsDirectory();
}
