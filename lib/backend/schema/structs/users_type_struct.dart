// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersTypeStruct extends BaseStruct {
  UsersTypeStruct({
    String? userId,
    String? email,
    String? name,
    String? lastName,
  })  : _userId = userId,
        _email = email,
        _name = name,
        _lastName = lastName;

  // "userId" field.
  String? _userId;
  String get userId => _userId ?? '';
  set userId(String? val) => _userId = val;

  bool hasUserId() => _userId != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  set email(String? val) => _email = val;

  bool hasEmail() => _email != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "lastName" field.
  String? _lastName;
  String get lastName => _lastName ?? '';
  set lastName(String? val) => _lastName = val;

  bool hasLastName() => _lastName != null;

  static UsersTypeStruct fromMap(Map<String, dynamic> data) => UsersTypeStruct(
        userId: data['userId'] as String?,
        email: data['email'] as String?,
        name: data['name'] as String?,
        lastName: data['lastName'] as String?,
      );

  static UsersTypeStruct? maybeFromMap(dynamic data) => data is Map
      ? UsersTypeStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'userId': _userId,
        'email': _email,
        'name': _name,
        'lastName': _lastName,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'userId': serializeParam(
          _userId,
          ParamType.String,
        ),
        'email': serializeParam(
          _email,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'lastName': serializeParam(
          _lastName,
          ParamType.String,
        ),
      }.withoutNulls;

  static UsersTypeStruct fromSerializableMap(Map<String, dynamic> data) =>
      UsersTypeStruct(
        userId: deserializeParam(
          data['userId'],
          ParamType.String,
          false,
        ),
        email: deserializeParam(
          data['email'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        lastName: deserializeParam(
          data['lastName'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'UsersTypeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UsersTypeStruct &&
        userId == other.userId &&
        email == other.email &&
        name == other.name &&
        lastName == other.lastName;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([userId, email, name, lastName]);
}

UsersTypeStruct createUsersTypeStruct({
  String? userId,
  String? email,
  String? name,
  String? lastName,
}) =>
    UsersTypeStruct(
      userId: userId,
      email: email,
      name: name,
      lastName: lastName,
    );
