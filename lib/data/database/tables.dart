import 'package:drift/drift.dart';

class Entries extends Table {
  IntColumn get id => integer()();
  TextColumn get word => text()();
  TextColumn get language => text()();
  TextColumn get dictionarySlug => text().nullable()();
  TextColumn get data => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
