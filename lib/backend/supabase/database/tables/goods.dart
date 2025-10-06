import '../database.dart';

class GoodsTable extends SupabaseTable<GoodsRow> {
  @override
  String get tableName => 'goods';

  @override
  GoodsRow createRow(Map<String, dynamic> data) => GoodsRow(data);
}

class GoodsRow extends SupabaseDataRow {
  GoodsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => GoodsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String get item => getField<String>('item')!;
  set item(String value) => setField<String>('item', value);
}
