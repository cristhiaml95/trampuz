// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ClientRowStruct extends BaseStruct {
  ClientRowStruct({
    String? id,
    String? client,
  })  : _id = id,
        _client = client;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "client" field.
  String? _client;
  String get client => _client ?? '';
  set client(String? val) => _client = val;

  bool hasClient() => _client != null;

  static ClientRowStruct fromMap(Map<String, dynamic> data) => ClientRowStruct(
        id: data['id'] as String?,
        client: data['client'] as String?,
      );

  static ClientRowStruct? maybeFromMap(dynamic data) => data is Map
      ? ClientRowStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'client': _client,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'client': serializeParam(
          _client,
          ParamType.String,
        ),
      }.withoutNulls;

  static ClientRowStruct fromSerializableMap(Map<String, dynamic> data) =>
      ClientRowStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        client: deserializeParam(
          data['client'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ClientRowStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ClientRowStruct && id == other.id && client == other.client;
  }

  @override
  int get hashCode => const ListEquality().hash([id, client]);
}

ClientRowStruct createClientRowStruct({
  String? id,
  String? client,
}) =>
    ClientRowStruct(
      id: id,
      client: client,
    );
