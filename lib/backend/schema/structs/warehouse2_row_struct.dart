// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class Warehouse2RowStruct extends BaseStruct {
  Warehouse2RowStruct({
    String? warehouseName,
    String? orderNo,
    String? clientName,
    String? orderStatus,
    bool? acepted,
    bool? precheck,
    bool? checked,
    String? flow,
    String? arrival2,
    String? loadingGateRamp,
    int? loadingSequence,
    String? loadRefDvh,
    int? quantity,
    String? packagingName,
    int? weight,
    String? customName,
    String? comment,
    List<String>? documents,
    String? adminName,
    String? adminLastName,
    String? etaI2,
    String? etaF2,
    String? etaDate2,
    String? licencePlate,
    String? improvement,
    String? containerNo,
    String? id,
  })  : _warehouseName = warehouseName,
        _orderNo = orderNo,
        _clientName = clientName,
        _orderStatus = orderStatus,
        _acepted = acepted,
        _precheck = precheck,
        _checked = checked,
        _flow = flow,
        _arrival2 = arrival2,
        _loadingGateRamp = loadingGateRamp,
        _loadingSequence = loadingSequence,
        _loadRefDvh = loadRefDvh,
        _quantity = quantity,
        _packagingName = packagingName,
        _weight = weight,
        _customName = customName,
        _comment = comment,
        _documents = documents,
        _adminName = adminName,
        _adminLastName = adminLastName,
        _etaI2 = etaI2,
        _etaF2 = etaF2,
        _etaDate2 = etaDate2,
        _licencePlate = licencePlate,
        _improvement = improvement,
        _containerNo = containerNo,
        _id = id;

  // "warehouse_name" field.
  String? _warehouseName;
  String get warehouseName => _warehouseName ?? '';
  set warehouseName(String? val) => _warehouseName = val;

  bool hasWarehouseName() => _warehouseName != null;

  // "order_no" field.
  String? _orderNo;
  String get orderNo => _orderNo ?? '';
  set orderNo(String? val) => _orderNo = val;

  bool hasOrderNo() => _orderNo != null;

  // "client_name" field.
  String? _clientName;
  String get clientName => _clientName ?? '';
  set clientName(String? val) => _clientName = val;

  bool hasClientName() => _clientName != null;

  // "order_status" field.
  String? _orderStatus;
  String get orderStatus => _orderStatus ?? '';
  set orderStatus(String? val) => _orderStatus = val;

  bool hasOrderStatus() => _orderStatus != null;

  // "acepted" field.
  bool? _acepted;
  bool get acepted => _acepted ?? false;
  set acepted(bool? val) => _acepted = val;

  bool hasAcepted() => _acepted != null;

  // "precheck" field.
  bool? _precheck;
  bool get precheck => _precheck ?? false;
  set precheck(bool? val) => _precheck = val;

  bool hasPrecheck() => _precheck != null;

  // "checked" field.
  bool? _checked;
  bool get checked => _checked ?? false;
  set checked(bool? val) => _checked = val;

  bool hasChecked() => _checked != null;

  // "flow" field.
  String? _flow;
  String get flow => _flow ?? '';
  set flow(String? val) => _flow = val;

  bool hasFlow() => _flow != null;

  // "arrival2" field.
  String? _arrival2;
  String get arrival2 => _arrival2 ?? '';
  set arrival2(String? val) => _arrival2 = val;

  bool hasArrival2() => _arrival2 != null;

  // "loading_gate_ramp" field.
  String? _loadingGateRamp;
  String get loadingGateRamp => _loadingGateRamp ?? '';
  set loadingGateRamp(String? val) => _loadingGateRamp = val;

  bool hasLoadingGateRamp() => _loadingGateRamp != null;

  // "loading_sequence" field.
  int? _loadingSequence;
  int get loadingSequence => _loadingSequence ?? 0;
  set loadingSequence(int? val) => _loadingSequence = val;

  void incrementLoadingSequence(int amount) =>
      loadingSequence = loadingSequence + amount;

  bool hasLoadingSequence() => _loadingSequence != null;

  // "load_ref_dvh" field.
  String? _loadRefDvh;
  String get loadRefDvh => _loadRefDvh ?? '';
  set loadRefDvh(String? val) => _loadRefDvh = val;

  bool hasLoadRefDvh() => _loadRefDvh != null;

  // "quantity" field.
  int? _quantity;
  int get quantity => _quantity ?? 0;
  set quantity(int? val) => _quantity = val;

  void incrementQuantity(int amount) => quantity = quantity + amount;

  bool hasQuantity() => _quantity != null;

  // "packaging_name" field.
  String? _packagingName;
  String get packagingName => _packagingName ?? '';
  set packagingName(String? val) => _packagingName = val;

  bool hasPackagingName() => _packagingName != null;

  // "weight" field.
  int? _weight;
  int get weight => _weight ?? 0;
  set weight(int? val) => _weight = val;

  void incrementWeight(int amount) => weight = weight + amount;

  bool hasWeight() => _weight != null;

  // "custom_name" field.
  String? _customName;
  String get customName => _customName ?? '';
  set customName(String? val) => _customName = val;

  bool hasCustomName() => _customName != null;

  // "comment" field.
  String? _comment;
  String get comment => _comment ?? '';
  set comment(String? val) => _comment = val;

  bool hasComment() => _comment != null;

  // "documents" field.
  List<String>? _documents;
  List<String> get documents => _documents ?? const [];
  set documents(List<String>? val) => _documents = val;

  void updateDocuments(Function(List<String>) updateFn) {
    updateFn(_documents ??= []);
  }

  bool hasDocuments() => _documents != null;

  // "admin_name" field.
  String? _adminName;
  String get adminName => _adminName ?? '';
  set adminName(String? val) => _adminName = val;

  bool hasAdminName() => _adminName != null;

  // "admin_last_name" field.
  String? _adminLastName;
  String get adminLastName => _adminLastName ?? '';
  set adminLastName(String? val) => _adminLastName = val;

  bool hasAdminLastName() => _adminLastName != null;

  // "eta_i2" field.
  String? _etaI2;
  String get etaI2 => _etaI2 ?? '';
  set etaI2(String? val) => _etaI2 = val;

  bool hasEtaI2() => _etaI2 != null;

  // "eta_f2" field.
  String? _etaF2;
  String get etaF2 => _etaF2 ?? '';
  set etaF2(String? val) => _etaF2 = val;

  bool hasEtaF2() => _etaF2 != null;

  // "eta_date2" field.
  String? _etaDate2;
  String get etaDate2 => _etaDate2 ?? '';
  set etaDate2(String? val) => _etaDate2 = val;

  bool hasEtaDate2() => _etaDate2 != null;

  // "licence_plate" field.
  String? _licencePlate;
  String get licencePlate => _licencePlate ?? '';
  set licencePlate(String? val) => _licencePlate = val;

  bool hasLicencePlate() => _licencePlate != null;

  // "improvement" field.
  String? _improvement;
  String get improvement => _improvement ?? '';
  set improvement(String? val) => _improvement = val;

  bool hasImprovement() => _improvement != null;

  // "container_no" field.
  String? _containerNo;
  String get containerNo => _containerNo ?? '';
  set containerNo(String? val) => _containerNo = val;

  bool hasContainerNo() => _containerNo != null;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  static Warehouse2RowStruct fromMap(Map<String, dynamic> data) =>
      Warehouse2RowStruct(
        warehouseName: data['warehouse_name'] as String?,
        orderNo: data['order_no'] as String?,
        clientName: data['client_name'] as String?,
        orderStatus: data['order_status'] as String?,
        acepted: data['acepted'] as bool?,
        precheck: data['precheck'] as bool?,
        checked: data['checked'] as bool?,
        flow: data['flow'] as String?,
        arrival2: data['arrival2'] as String?,
        loadingGateRamp: data['loading_gate_ramp'] as String?,
        loadingSequence: castToType<int>(data['loading_sequence']),
        loadRefDvh: data['load_ref_dvh'] as String?,
        quantity: castToType<int>(data['quantity']),
        packagingName: data['packaging_name'] as String?,
        weight: castToType<int>(data['weight']),
        customName: data['custom_name'] as String?,
        comment: data['comment'] as String?,
        documents: getDataList(data['documents']),
        adminName: data['admin_name'] as String?,
        adminLastName: data['admin_last_name'] as String?,
        etaI2: data['eta_i2'] as String?,
        etaF2: data['eta_f2'] as String?,
        etaDate2: data['eta_date2'] as String?,
        licencePlate: data['licence_plate'] as String?,
        improvement: data['improvement'] as String?,
        containerNo: data['container_no'] as String?,
        id: data['id'] as String?,
      );

  static Warehouse2RowStruct? maybeFromMap(dynamic data) => data is Map
      ? Warehouse2RowStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'warehouse_name': _warehouseName,
        'order_no': _orderNo,
        'client_name': _clientName,
        'order_status': _orderStatus,
        'acepted': _acepted,
        'precheck': _precheck,
        'checked': _checked,
        'flow': _flow,
        'arrival2': _arrival2,
        'loading_gate_ramp': _loadingGateRamp,
        'loading_sequence': _loadingSequence,
        'load_ref_dvh': _loadRefDvh,
        'quantity': _quantity,
        'packaging_name': _packagingName,
        'weight': _weight,
        'custom_name': _customName,
        'comment': _comment,
        'documents': _documents,
        'admin_name': _adminName,
        'admin_last_name': _adminLastName,
        'eta_i2': _etaI2,
        'eta_f2': _etaF2,
        'eta_date2': _etaDate2,
        'licence_plate': _licencePlate,
        'improvement': _improvement,
        'container_no': _containerNo,
        'id': _id,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'warehouse_name': serializeParam(
          _warehouseName,
          ParamType.String,
        ),
        'order_no': serializeParam(
          _orderNo,
          ParamType.String,
        ),
        'client_name': serializeParam(
          _clientName,
          ParamType.String,
        ),
        'order_status': serializeParam(
          _orderStatus,
          ParamType.String,
        ),
        'acepted': serializeParam(
          _acepted,
          ParamType.bool,
        ),
        'precheck': serializeParam(
          _precheck,
          ParamType.bool,
        ),
        'checked': serializeParam(
          _checked,
          ParamType.bool,
        ),
        'flow': serializeParam(
          _flow,
          ParamType.String,
        ),
        'arrival2': serializeParam(
          _arrival2,
          ParamType.String,
        ),
        'loading_gate_ramp': serializeParam(
          _loadingGateRamp,
          ParamType.String,
        ),
        'loading_sequence': serializeParam(
          _loadingSequence,
          ParamType.int,
        ),
        'load_ref_dvh': serializeParam(
          _loadRefDvh,
          ParamType.String,
        ),
        'quantity': serializeParam(
          _quantity,
          ParamType.int,
        ),
        'packaging_name': serializeParam(
          _packagingName,
          ParamType.String,
        ),
        'weight': serializeParam(
          _weight,
          ParamType.int,
        ),
        'custom_name': serializeParam(
          _customName,
          ParamType.String,
        ),
        'comment': serializeParam(
          _comment,
          ParamType.String,
        ),
        'documents': serializeParam(
          _documents,
          ParamType.String,
          isList: true,
        ),
        'admin_name': serializeParam(
          _adminName,
          ParamType.String,
        ),
        'admin_last_name': serializeParam(
          _adminLastName,
          ParamType.String,
        ),
        'eta_i2': serializeParam(
          _etaI2,
          ParamType.String,
        ),
        'eta_f2': serializeParam(
          _etaF2,
          ParamType.String,
        ),
        'eta_date2': serializeParam(
          _etaDate2,
          ParamType.String,
        ),
        'licence_plate': serializeParam(
          _licencePlate,
          ParamType.String,
        ),
        'improvement': serializeParam(
          _improvement,
          ParamType.String,
        ),
        'container_no': serializeParam(
          _containerNo,
          ParamType.String,
        ),
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
      }.withoutNulls;

  static Warehouse2RowStruct fromSerializableMap(Map<String, dynamic> data) =>
      Warehouse2RowStruct(
        warehouseName: deserializeParam(
          data['warehouse_name'],
          ParamType.String,
          false,
        ),
        orderNo: deserializeParam(
          data['order_no'],
          ParamType.String,
          false,
        ),
        clientName: deserializeParam(
          data['client_name'],
          ParamType.String,
          false,
        ),
        orderStatus: deserializeParam(
          data['order_status'],
          ParamType.String,
          false,
        ),
        acepted: deserializeParam(
          data['acepted'],
          ParamType.bool,
          false,
        ),
        precheck: deserializeParam(
          data['precheck'],
          ParamType.bool,
          false,
        ),
        checked: deserializeParam(
          data['checked'],
          ParamType.bool,
          false,
        ),
        flow: deserializeParam(
          data['flow'],
          ParamType.String,
          false,
        ),
        arrival2: deserializeParam(
          data['arrival2'],
          ParamType.String,
          false,
        ),
        loadingGateRamp: deserializeParam(
          data['loading_gate_ramp'],
          ParamType.String,
          false,
        ),
        loadingSequence: deserializeParam(
          data['loading_sequence'],
          ParamType.int,
          false,
        ),
        loadRefDvh: deserializeParam(
          data['load_ref_dvh'],
          ParamType.String,
          false,
        ),
        quantity: deserializeParam(
          data['quantity'],
          ParamType.int,
          false,
        ),
        packagingName: deserializeParam(
          data['packaging_name'],
          ParamType.String,
          false,
        ),
        weight: deserializeParam(
          data['weight'],
          ParamType.int,
          false,
        ),
        customName: deserializeParam(
          data['custom_name'],
          ParamType.String,
          false,
        ),
        comment: deserializeParam(
          data['comment'],
          ParamType.String,
          false,
        ),
        documents: deserializeParam<String>(
          data['documents'],
          ParamType.String,
          true,
        ),
        adminName: deserializeParam(
          data['admin_name'],
          ParamType.String,
          false,
        ),
        adminLastName: deserializeParam(
          data['admin_last_name'],
          ParamType.String,
          false,
        ),
        etaI2: deserializeParam(
          data['eta_i2'],
          ParamType.String,
          false,
        ),
        etaF2: deserializeParam(
          data['eta_f2'],
          ParamType.String,
          false,
        ),
        etaDate2: deserializeParam(
          data['eta_date2'],
          ParamType.String,
          false,
        ),
        licencePlate: deserializeParam(
          data['licence_plate'],
          ParamType.String,
          false,
        ),
        improvement: deserializeParam(
          data['improvement'],
          ParamType.String,
          false,
        ),
        containerNo: deserializeParam(
          data['container_no'],
          ParamType.String,
          false,
        ),
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'Warehouse2RowStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is Warehouse2RowStruct &&
        warehouseName == other.warehouseName &&
        orderNo == other.orderNo &&
        clientName == other.clientName &&
        orderStatus == other.orderStatus &&
        acepted == other.acepted &&
        precheck == other.precheck &&
        checked == other.checked &&
        flow == other.flow &&
        arrival2 == other.arrival2 &&
        loadingGateRamp == other.loadingGateRamp &&
        loadingSequence == other.loadingSequence &&
        loadRefDvh == other.loadRefDvh &&
        quantity == other.quantity &&
        packagingName == other.packagingName &&
        weight == other.weight &&
        customName == other.customName &&
        comment == other.comment &&
        listEquality.equals(documents, other.documents) &&
        adminName == other.adminName &&
        adminLastName == other.adminLastName &&
        etaI2 == other.etaI2 &&
        etaF2 == other.etaF2 &&
        etaDate2 == other.etaDate2 &&
        licencePlate == other.licencePlate &&
        improvement == other.improvement &&
        containerNo == other.containerNo &&
        id == other.id;
  }

  @override
  int get hashCode => const ListEquality().hash([
        warehouseName,
        orderNo,
        clientName,
        orderStatus,
        acepted,
        precheck,
        checked,
        flow,
        arrival2,
        loadingGateRamp,
        loadingSequence,
        loadRefDvh,
        quantity,
        packagingName,
        weight,
        customName,
        comment,
        documents,
        adminName,
        adminLastName,
        etaI2,
        etaF2,
        etaDate2,
        licencePlate,
        improvement,
        containerNo,
        id
      ]);
}

Warehouse2RowStruct createWarehouse2RowStruct({
  String? warehouseName,
  String? orderNo,
  String? clientName,
  String? orderStatus,
  bool? acepted,
  bool? precheck,
  bool? checked,
  String? flow,
  String? arrival2,
  String? loadingGateRamp,
  int? loadingSequence,
  String? loadRefDvh,
  int? quantity,
  String? packagingName,
  int? weight,
  String? customName,
  String? comment,
  String? adminName,
  String? adminLastName,
  String? etaI2,
  String? etaF2,
  String? etaDate2,
  String? licencePlate,
  String? improvement,
  String? containerNo,
  String? id,
}) =>
    Warehouse2RowStruct(
      warehouseName: warehouseName,
      orderNo: orderNo,
      clientName: clientName,
      orderStatus: orderStatus,
      acepted: acepted,
      precheck: precheck,
      checked: checked,
      flow: flow,
      arrival2: arrival2,
      loadingGateRamp: loadingGateRamp,
      loadingSequence: loadingSequence,
      loadRefDvh: loadRefDvh,
      quantity: quantity,
      packagingName: packagingName,
      weight: weight,
      customName: customName,
      comment: comment,
      adminName: adminName,
      adminLastName: adminLastName,
      etaI2: etaI2,
      etaF2: etaF2,
      etaDate2: etaDate2,
      licencePlate: licencePlate,
      improvement: improvement,
      containerNo: containerNo,
      id: id,
    );
