// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GoodDescriptionRowStruct extends BaseStruct {
  GoodDescriptionRowStruct({
    String? id,
    String? opisBlaga,
  })  : _id = id,
        _opisBlaga = opisBlaga;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "opis_blaga" field.
  String? _opisBlaga;
  String get opisBlaga => _opisBlaga ?? '';
  set opisBlaga(String? val) => _opisBlaga = val;

  bool hasOpisBlaga() => _opisBlaga != null;

  static GoodDescriptionRowStruct fromMap(Map<String, dynamic> data) =>
      GoodDescriptionRowStruct(
        id: data['id'] as String?,
        opisBlaga: data['opis_blaga'] as String?,
      );

  static GoodDescriptionRowStruct? maybeFromMap(dynamic data) => data is Map
      ? GoodDescriptionRowStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'opis_blaga': _opisBlaga,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'opis_blaga': serializeParam(
          _opisBlaga,
          ParamType.String,
        ),
      }.withoutNulls;

  static GoodDescriptionRowStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      GoodDescriptionRowStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        opisBlaga: deserializeParam(
          data['opis_blaga'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'GoodDescriptionRowStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is GoodDescriptionRowStruct &&
        id == other.id &&
        opisBlaga == other.opisBlaga;
  }

  @override
  int get hashCode => const ListEquality().hash([id, opisBlaga]);
}

GoodDescriptionRowStruct createGoodDescriptionRowStruct({
  String? id,
  String? opisBlaga,
}) =>
    GoodDescriptionRowStruct(
      id: id,
      opisBlaga: opisBlaga,
    );
