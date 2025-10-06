// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FixedColumnsStruct extends BaseStruct {
  FixedColumnsStruct({
    String? invStatus,
    String? orderNo,
    String? client,
    double? availableQuantity,
    double? currentCustomsWarranty,
    double? remainingCustomsThreshold,
  })  : _invStatus = invStatus,
        _orderNo = orderNo,
        _client = client,
        _availableQuantity = availableQuantity,
        _currentCustomsWarranty = currentCustomsWarranty,
        _remainingCustomsThreshold = remainingCustomsThreshold;

  // "inv_status" field.
  String? _invStatus;
  String get invStatus => _invStatus ?? 'brez izbire';
  set invStatus(String? val) => _invStatus = val;

  bool hasInvStatus() => _invStatus != null;

  // "order_no" field.
  String? _orderNo;
  String get orderNo => _orderNo ?? 'brez izbire';
  set orderNo(String? val) => _orderNo = val;

  bool hasOrderNo() => _orderNo != null;

  // "client" field.
  String? _client;
  String get client => _client ?? 'brez izbire';
  set client(String? val) => _client = val;

  bool hasClient() => _client != null;

  // "available_quantity" field.
  double? _availableQuantity;
  double get availableQuantity => _availableQuantity ?? 0.0;
  set availableQuantity(double? val) => _availableQuantity = val;

  void incrementAvailableQuantity(double amount) =>
      availableQuantity = availableQuantity + amount;

  bool hasAvailableQuantity() => _availableQuantity != null;

  // "current_customs_warranty" field.
  double? _currentCustomsWarranty;
  double get currentCustomsWarranty => _currentCustomsWarranty ?? 0.0;
  set currentCustomsWarranty(double? val) => _currentCustomsWarranty = val;

  void incrementCurrentCustomsWarranty(double amount) =>
      currentCustomsWarranty = currentCustomsWarranty + amount;

  bool hasCurrentCustomsWarranty() => _currentCustomsWarranty != null;

  // "remaining_customs_threshold" field.
  double? _remainingCustomsThreshold;
  double get remainingCustomsThreshold => _remainingCustomsThreshold ?? 0.0;
  set remainingCustomsThreshold(double? val) =>
      _remainingCustomsThreshold = val;

  void incrementRemainingCustomsThreshold(double amount) =>
      remainingCustomsThreshold = remainingCustomsThreshold + amount;

  bool hasRemainingCustomsThreshold() => _remainingCustomsThreshold != null;

  static FixedColumnsStruct fromMap(Map<String, dynamic> data) =>
      FixedColumnsStruct(
        invStatus: data['inv_status'] as String?,
        orderNo: data['order_no'] as String?,
        client: data['client'] as String?,
        availableQuantity: castToType<double>(data['available_quantity']),
        currentCustomsWarranty:
            castToType<double>(data['current_customs_warranty']),
        remainingCustomsThreshold:
            castToType<double>(data['remaining_customs_threshold']),
      );

  static FixedColumnsStruct? maybeFromMap(dynamic data) => data is Map
      ? FixedColumnsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'inv_status': _invStatus,
        'order_no': _orderNo,
        'client': _client,
        'available_quantity': _availableQuantity,
        'current_customs_warranty': _currentCustomsWarranty,
        'remaining_customs_threshold': _remainingCustomsThreshold,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'inv_status': serializeParam(
          _invStatus,
          ParamType.String,
        ),
        'order_no': serializeParam(
          _orderNo,
          ParamType.String,
        ),
        'client': serializeParam(
          _client,
          ParamType.String,
        ),
        'available_quantity': serializeParam(
          _availableQuantity,
          ParamType.double,
        ),
        'current_customs_warranty': serializeParam(
          _currentCustomsWarranty,
          ParamType.double,
        ),
        'remaining_customs_threshold': serializeParam(
          _remainingCustomsThreshold,
          ParamType.double,
        ),
      }.withoutNulls;

  static FixedColumnsStruct fromSerializableMap(Map<String, dynamic> data) =>
      FixedColumnsStruct(
        invStatus: deserializeParam(
          data['inv_status'],
          ParamType.String,
          false,
        ),
        orderNo: deserializeParam(
          data['order_no'],
          ParamType.String,
          false,
        ),
        client: deserializeParam(
          data['client'],
          ParamType.String,
          false,
        ),
        availableQuantity: deserializeParam(
          data['available_quantity'],
          ParamType.double,
          false,
        ),
        currentCustomsWarranty: deserializeParam(
          data['current_customs_warranty'],
          ParamType.double,
          false,
        ),
        remainingCustomsThreshold: deserializeParam(
          data['remaining_customs_threshold'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'FixedColumnsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FixedColumnsStruct &&
        invStatus == other.invStatus &&
        orderNo == other.orderNo &&
        client == other.client &&
        availableQuantity == other.availableQuantity &&
        currentCustomsWarranty == other.currentCustomsWarranty &&
        remainingCustomsThreshold == other.remainingCustomsThreshold;
  }

  @override
  int get hashCode => const ListEquality().hash([
        invStatus,
        orderNo,
        client,
        availableQuantity,
        currentCustomsWarranty,
        remainingCustomsThreshold
      ]);
}

FixedColumnsStruct createFixedColumnsStruct({
  String? invStatus,
  String? orderNo,
  String? client,
  double? availableQuantity,
  double? currentCustomsWarranty,
  double? remainingCustomsThreshold,
}) =>
    FixedColumnsStruct(
      invStatus: invStatus,
      orderNo: orderNo,
      client: client,
      availableQuantity: availableQuantity,
      currentCustomsWarranty: currentCustomsWarranty,
      remainingCustomsThreshold: remainingCustomsThreshold,
    );
