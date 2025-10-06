// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DetailsViewRowStruct extends BaseStruct {
  DetailsViewRowStruct({
    String? id,
    String? orderId,
    String? barcode,
    String? barcodeOut,
  })  : _id = id,
        _orderId = orderId,
        _barcode = barcode,
        _barcodeOut = barcodeOut;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "order_id" field.
  String? _orderId;
  String get orderId => _orderId ?? '';
  set orderId(String? val) => _orderId = val;

  bool hasOrderId() => _orderId != null;

  // "barcode" field.
  String? _barcode;
  String get barcode => _barcode ?? '';
  set barcode(String? val) => _barcode = val;

  bool hasBarcode() => _barcode != null;

  // "barcode_out" field.
  String? _barcodeOut;
  String get barcodeOut => _barcodeOut ?? '';
  set barcodeOut(String? val) => _barcodeOut = val;

  bool hasBarcodeOut() => _barcodeOut != null;

  static DetailsViewRowStruct fromMap(Map<String, dynamic> data) =>
      DetailsViewRowStruct(
        id: data['id'] as String?,
        orderId: data['order_id'] as String?,
        barcode: data['barcode'] as String?,
        barcodeOut: data['barcode_out'] as String?,
      );

  static DetailsViewRowStruct? maybeFromMap(dynamic data) => data is Map
      ? DetailsViewRowStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'order_id': _orderId,
        'barcode': _barcode,
        'barcode_out': _barcodeOut,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'order_id': serializeParam(
          _orderId,
          ParamType.String,
        ),
        'barcode': serializeParam(
          _barcode,
          ParamType.String,
        ),
        'barcode_out': serializeParam(
          _barcodeOut,
          ParamType.String,
        ),
      }.withoutNulls;

  static DetailsViewRowStruct fromSerializableMap(Map<String, dynamic> data) =>
      DetailsViewRowStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        orderId: deserializeParam(
          data['order_id'],
          ParamType.String,
          false,
        ),
        barcode: deserializeParam(
          data['barcode'],
          ParamType.String,
          false,
        ),
        barcodeOut: deserializeParam(
          data['barcode_out'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DetailsViewRowStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DetailsViewRowStruct &&
        id == other.id &&
        orderId == other.orderId &&
        barcode == other.barcode &&
        barcodeOut == other.barcodeOut;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([id, orderId, barcode, barcodeOut]);
}

DetailsViewRowStruct createDetailsViewRowStruct({
  String? id,
  String? orderId,
  String? barcode,
  String? barcodeOut,
}) =>
    DetailsViewRowStruct(
      id: id,
      orderId: orderId,
      barcode: barcode,
      barcodeOut: barcodeOut,
    );
