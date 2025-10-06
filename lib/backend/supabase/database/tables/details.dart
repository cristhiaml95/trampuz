import '../database.dart';

class DetailsTable extends SupabaseTable<DetailsRow> {
  @override
  String get tableName => 'details';

  @override
  DetailsRow createRow(Map<String, dynamic> data) => DetailsRow(data);
}

class DetailsRow extends SupabaseDataRow {
  DetailsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => DetailsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get orderId => getField<String>('order_id');
  set orderId(String? value) => setField<String>('order_id', value);

  String get good => getField<String>('good')!;
  set good(String value) => setField<String>('good', value);

  String get goodDescription => getField<String>('good_description')!;
  set goodDescription(String value) =>
      setField<String>('good_description', value);

  String get packaging => getField<String>('packaging')!;
  set packaging(String value) => setField<String>('packaging', value);

  String get warehousePosition => getField<String>('warehouse_position')!;
  set warehousePosition(String value) =>
      setField<String>('warehouse_position', value);

  String get barcode => getField<String>('barcode')!;
  set barcode(String value) => setField<String>('barcode', value);

  bool get check => getField<bool>('check')!;
  set check(bool value) => setField<bool>('check', value);

  String get barcodeOut => getField<String>('barcode_out')!;
  set barcodeOut(String value) => setField<String>('barcode_out', value);
}
