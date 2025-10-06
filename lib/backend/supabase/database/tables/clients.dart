import '../database.dart';

class ClientsTable extends SupabaseTable<ClientsRow> {
  @override
  String get tableName => 'clients';

  @override
  ClientsRow createRow(Map<String, dynamic> data) => ClientsRow(data);
}

class ClientsRow extends SupabaseDataRow {
  ClientsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ClientsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String get client => getField<String>('client')!;
  set client(String value) => setField<String>('client', value);

  String get address => getField<String>('address')!;
  set address(String value) => setField<String>('address', value);

  String get city => getField<String>('city')!;
  set city(String value) => setField<String>('city', value);

  String get country => getField<String>('country')!;
  set country(String value) => setField<String>('country', value);

  String get nameAiss => getField<String>('name_aiss')!;
  set nameAiss(String value) => setField<String>('name_aiss', value);

  String get vatNo => getField<String>('vat_no')!;
  set vatNo(String value) => setField<String>('vat_no', value);
}
