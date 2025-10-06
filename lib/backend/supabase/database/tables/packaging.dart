import '../database.dart';

class PackagingTable extends SupabaseTable<PackagingRow> {
  @override
  String get tableName => 'packaging';

  @override
  PackagingRow createRow(Map<String, dynamic> data) => PackagingRow(data);
}

class PackagingRow extends SupabaseDataRow {
  PackagingRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PackagingTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String get packaging => getField<String>('packaging')!;
  set packaging(String value) => setField<String>('packaging', value);

  String get abbreviation => getField<String>('abbreviation')!;
  set abbreviation(String value) => setField<String>('abbreviation', value);
}
