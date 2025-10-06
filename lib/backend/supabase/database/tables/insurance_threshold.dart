import '../database.dart';

class InsuranceThresholdTable extends SupabaseTable<InsuranceThresholdRow> {
  @override
  String get tableName => 'insurance_threshold';

  @override
  InsuranceThresholdRow createRow(Map<String, dynamic> data) =>
      InsuranceThresholdRow(data);
}

class InsuranceThresholdRow extends SupabaseDataRow {
  InsuranceThresholdRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => InsuranceThresholdTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String get modifier => getField<String>('modifier')!;
  set modifier(String value) => setField<String>('modifier', value);

  double get lastInsuranceThreshold =>
      getField<double>('last_insurance_threshold')!;
  set lastInsuranceThreshold(double value) =>
      setField<double>('last_insurance_threshold', value);
}
