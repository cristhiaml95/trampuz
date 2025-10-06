// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PackaingRowStruct extends BaseStruct {
  PackaingRowStruct({
    String? id,
    String? packaging,
  })  : _id = id,
        _packaging = packaging;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "packaging" field.
  String? _packaging;
  String get packaging => _packaging ?? '';
  set packaging(String? val) => _packaging = val;

  bool hasPackaging() => _packaging != null;

  static PackaingRowStruct fromMap(Map<String, dynamic> data) =>
      PackaingRowStruct(
        id: data['id'] as String?,
        packaging: data['packaging'] as String?,
      );

  static PackaingRowStruct? maybeFromMap(dynamic data) => data is Map
      ? PackaingRowStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'packaging': _packaging,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'packaging': serializeParam(
          _packaging,
          ParamType.String,
        ),
      }.withoutNulls;

  static PackaingRowStruct fromSerializableMap(Map<String, dynamic> data) =>
      PackaingRowStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        packaging: deserializeParam(
          data['packaging'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PackaingRowStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PackaingRowStruct &&
        id == other.id &&
        packaging == other.packaging;
  }

  @override
  int get hashCode => const ListEquality().hash([id, packaging]);
}

PackaingRowStruct createPackaingRowStruct({
  String? id,
  String? packaging,
}) =>
    PackaingRowStruct(
      id: id,
      packaging: packaging,
    );
