import '../database.dart';

class UsersTable extends SupabaseTable<UsersRow> {
  @override
  String get tableName => 'users';

  @override
  UsersRow createRow(Map<String, dynamic> data) => UsersRow(data);
}

class UsersRow extends SupabaseDataRow {
  UsersRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UsersTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String get email => getField<String>('email')!;
  set email(String value) => setField<String>('email', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);

  String get lastName => getField<String>('last_name')!;
  set lastName(String value) => setField<String>('last_name', value);

  String get userType => getField<String>('user_type')!;
  set userType(String value) => setField<String>('user_type', value);

  String get status => getField<String>('status')!;
  set status(String value) => setField<String>('status', value);

  String get job => getField<String>('job')!;
  set job(String value) => setField<String>('job', value);

  String? get password => getField<String>('password');
  set password(String? value) => setField<String>('password', value);

  String get image => getField<String>('image')!;
  set image(String value) => setField<String>('image', value);

  List<dynamic> get lastGridState => getListField<dynamic>('last_grid_state');
  set lastGridState(List<dynamic>? value) =>
      setListField<dynamic>('last_grid_state', value);

  List<dynamic> get gridStateList => getListField<dynamic>('grid_state_list');
  set gridStateList(List<dynamic>? value) =>
      setListField<dynamic>('grid_state_list', value);

  List<dynamic> get currentGridSet => getListField<dynamic>('current_grid_set');
  set currentGridSet(List<dynamic>? value) =>
      setListField<dynamic>('current_grid_set', value);
}
