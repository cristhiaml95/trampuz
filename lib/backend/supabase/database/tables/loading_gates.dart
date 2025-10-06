import '../database.dart';

class LoadingGatesTable extends SupabaseTable<LoadingGatesRow> {
  @override
  String get tableName => 'loading_gates';

  @override
  LoadingGatesRow createRow(Map<String, dynamic> data) => LoadingGatesRow(data);
}

class LoadingGatesRow extends SupabaseDataRow {
  LoadingGatesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => LoadingGatesTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String get warehouse => getField<String>('warehouse')!;
  set warehouse(String value) => setField<String>('warehouse', value);

  String get ramp => getField<String>('ramp')!;
  set ramp(String value) => setField<String>('ramp', value);
}
