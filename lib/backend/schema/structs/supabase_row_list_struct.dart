// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SupabaseRowListStruct extends BaseStruct {
  SupabaseRowListStruct({
    List<String>? supabaseRowList,
  }) : _supabaseRowList = supabaseRowList;

  // "supabaseRowList" field.
  List<String>? _supabaseRowList;
  List<String> get supabaseRowList => _supabaseRowList ?? const [];
  set supabaseRowList(List<String>? val) => _supabaseRowList = val;

  void updateSupabaseRowList(Function(List<String>) updateFn) {
    updateFn(_supabaseRowList ??= []);
  }

  bool hasSupabaseRowList() => _supabaseRowList != null;

  static SupabaseRowListStruct fromMap(Map<String, dynamic> data) =>
      SupabaseRowListStruct(
        supabaseRowList: getDataList(data['supabaseRowList']),
      );

  static SupabaseRowListStruct? maybeFromMap(dynamic data) => data is Map
      ? SupabaseRowListStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'supabaseRowList': _supabaseRowList,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'supabaseRowList': serializeParam(
          _supabaseRowList,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static SupabaseRowListStruct fromSerializableMap(Map<String, dynamic> data) =>
      SupabaseRowListStruct(
        supabaseRowList: deserializeParam<String>(
          data['supabaseRowList'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'SupabaseRowListStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is SupabaseRowListStruct &&
        listEquality.equals(supabaseRowList, other.supabaseRowList);
  }

  @override
  int get hashCode => const ListEquality().hash([supabaseRowList]);
}

SupabaseRowListStruct createSupabaseRowListStruct() => SupabaseRowListStruct();
