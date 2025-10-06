import '../database.dart';

class ManipulationsTable extends SupabaseTable<ManipulationsRow> {
  @override
  String get tableName => 'manipulations';

  @override
  ManipulationsRow createRow(Map<String, dynamic> data) =>
      ManipulationsRow(data);
}

class ManipulationsRow extends SupabaseDataRow {
  ManipulationsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ManipulationsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String get manipulation => getField<String>('manipulation')!;
  set manipulation(String value) => setField<String>('manipulation', value);
}
