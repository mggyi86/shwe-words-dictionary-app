import 'package:shwewords/data/datasources/local/dictionary_local_ds.dart';
import 'package:shwewords/domain/repositories/repositories.dart';

class DictionaryRepositoryImpl implements DictionaryRepository {
  DictionaryRepositoryImpl(this._local);

  final DictionaryLocalDataSource _local;

  @override
  Future<bool> databaseExists() => _local.databaseExists();

  @override
  Future<String> getDatabasePath() => _local.getDatabasePath();

  @override
  Future<String?> getLocalDbVersion() => _local.getLocalDbVersion();

  @override
  Future<void> saveLocalDbVersion(String version) =>
      _local.saveLocalDbVersion(version);

  @override
  Future<int> getEntryCount() => _local.countEntries();

  @override
  Future<void> openDatabase() => _local.openDatabase();

  @override
  Future<void> closeDatabase() => _local.closeDatabase();
}
