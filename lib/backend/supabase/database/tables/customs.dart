import '../database.dart';

class CustomsTable extends SupabaseTable<CustomsRow> {
  @override
  String get tableName => 'customs';

  @override
  CustomsRow createRow(Map<String, dynamic> data) => CustomsRow(data);
}

class CustomsRow extends SupabaseDataRow {
  CustomsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => CustomsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String get custom => getField<String>('custom')!;
  set custom(String value) => setField<String>('custom', value);
}
