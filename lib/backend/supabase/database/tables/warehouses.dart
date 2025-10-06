import '../database.dart';

class WarehousesTable extends SupabaseTable<WarehousesRow> {
  @override
  String get tableName => 'warehouses';

  @override
  WarehousesRow createRow(Map<String, dynamic> data) => WarehousesRow(data);
}

class WarehousesRow extends SupabaseDataRow {
  WarehousesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => WarehousesTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String get warehouse => getField<String>('warehouse')!;
  set warehouse(String value) => setField<String>('warehouse', value);
}
