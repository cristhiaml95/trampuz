import '../database.dart';

class GoodDescriptionsTable extends SupabaseTable<GoodDescriptionsRow> {
  @override
  String get tableName => 'good_descriptions';

  @override
  GoodDescriptionsRow createRow(Map<String, dynamic> data) =>
      GoodDescriptionsRow(data);
}

class GoodDescriptionsRow extends SupabaseDataRow {
  GoodDescriptionsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => GoodDescriptionsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String get opisBlaga => getField<String>('opis_blaga')!;
  set opisBlaga(String value) => setField<String>('opis_blaga', value);
}
