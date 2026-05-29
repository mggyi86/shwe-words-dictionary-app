import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shwewords/data/datasources/local/dictionary_local_ds.dart';
import 'package:shwewords/data/datasources/local/favorites_local_ds.dart';
import 'package:shwewords/data/datasources/remote/dictionary_remote_ds.dart';
import 'package:shwewords/data/repositories/dictionary_repository_impl.dart';
import 'package:shwewords/data/repositories/download_repository_impl.dart';
import 'package:shwewords/data/repositories/favorites_repository_impl.dart';
import 'package:shwewords/data/repositories/search_repository_impl.dart';
import 'package:shwewords/data/repositories/settings_repository_impl.dart';
import 'package:shwewords/domain/repositories/repositories.dart';

final dictionaryLocalDataSourceProvider = Provider<DictionaryLocalDataSource>(
  (ref) => DictionaryLocalDataSource(),
);

final favoritesLocalDataSourceProvider = Provider<FavoritesLocalDataSource>(
  (ref) => FavoritesLocalDataSource(),
);

final dictionaryRemoteDataSourceProvider = Provider<DictionaryRemoteDataSource>(
  (ref) => DictionaryRemoteDataSource(),
);

final dictionaryRepositoryProvider = Provider<DictionaryRepository>(
  (ref) => DictionaryRepositoryImpl(ref.watch(dictionaryLocalDataSourceProvider)),
);

final searchRepositoryProvider = Provider<SearchRepository>(
  (ref) => SearchRepositoryImpl(ref.watch(dictionaryLocalDataSourceProvider)),
);

final downloadRepositoryProvider = Provider<DownloadRepository>(
  (ref) => DownloadRepositoryImpl(
    ref.watch(dictionaryLocalDataSourceProvider),
    ref.watch(dictionaryRemoteDataSourceProvider),
  ),
);

final favoritesRepositoryProvider = Provider<FavoritesRepository>(
  (ref) => FavoritesRepositoryImpl(ref.watch(favoritesLocalDataSourceProvider)),
);

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepositoryImpl(),
);
