import '../database.dart';

class OrderLevelRefreshLogsTable
    extends SupabaseTable<OrderLevelRefreshLogsRow> {
  @override
  String get tableName => 'order_level_refresh_logs';

  @override
  OrderLevelRefreshLogsRow createRow(Map<String, dynamic> data) =>
      OrderLevelRefreshLogsRow(data);
}

class OrderLevelRefreshLogsRow extends SupabaseDataRow {
  OrderLevelRefreshLogsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => OrderLevelRefreshLogsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get rowId => getField<String>('row_id')!;
  set rowId(String value) => setField<String>('row_id', value);

  String get operationType => getField<String>('operation_type')!;
  set operationType(String value) => setField<String>('operation_type', value);

  List<String> get affectedGroups => getListField<String>('affected_groups');
  set affectedGroups(List<String>? value) =>
      setListField<String>('affected_groups', value);

  int? get executionTimeMs => getField<int>('execution_time_ms');
  set executionTimeMs(int? value) => setField<int>('execution_time_ms', value);

  int? get recordsUpdated => getField<int>('records_updated');
  set recordsUpdated(int? value) => setField<int>('records_updated', value);

  bool? get customsPropagated => getField<bool>('customs_propagated');
  set customsPropagated(bool? value) =>
      setField<bool>('customs_propagated', value);

  bool? get isCustomsOperation => getField<bool>('is_customs_operation');
  set isCustomsOperation(bool? value) =>
      setField<bool>('is_customs_operation', value);

  String? get errorMessage => getField<String>('error_message');
  set errorMessage(String? value) => setField<String>('error_message', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get createdBy => getField<String>('created_by');
  set createdBy(String? value) => setField<String>('created_by', value);
}
