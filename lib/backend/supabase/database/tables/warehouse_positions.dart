import '../database.dart';

class WarehousePositionsTable extends SupabaseTable<WarehousePositionsRow> {
  @override
  String get tableName => 'warehouse_positions';

  @override
  WarehousePositionsRow createRow(Map<String, dynamic> data) =>
      WarehousePositionsRow(data);
}

class WarehousePositionsRow extends SupabaseDataRow {
  WarehousePositionsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => WarehousePositionsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String get warehouse => getField<String>('warehouse')!;
  set warehouse(String value) => setField<String>('warehouse', value);

  String get position => getField<String>('position')!;
  set position(String value) => setField<String>('position', value);
}
