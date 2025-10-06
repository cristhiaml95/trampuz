// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OrderWarehouseRowStruct extends BaseStruct {
  OrderWarehouseRowStruct({
    String? id,
    String? orderNo,
    String? clientName,
    String? invStatus,
    bool? acepted,
    bool? precheck,
    bool? checked,
    String? warehouseName,
    String? orderStatus,
    String? flow,
    String? licencePlate,
    String? improvement,
    String? containerNo,
    int? quantity,
    String? packagingName,
    int? weight,
    double? palletPosition,
    String? universalRefNo,
    String? fmsRef,
    String? loadRefDvh,
    String? customName,
    String? internalRefCustom,
    String? comment,
    List<String>? documents,
    String? item,
    String? opisBlaga,
    String? loadingType,
    String? otherManipulation,
    String? responsibleName,
    String? responsibleLastName,
    String? assistant1Name,
    String? assistant1LastName,
    String? assistant2Name,
    String? assistant2LastName,
    String? adminName,
    String? adminLastName,
    String? internalAccounting,
    int? details,
    String? loadingGateRamp,
    int? loadingSequence,
    String? assistant3Name,
    String? assistant3LastName,
    String? assistant4Name,
    String? assistant4LastName,
    String? assistant5Name,
    String? assistant5LastName,
    String? assistant6Name,
    String? assistant6LastName,
    String? loadingType2,
    String? availability,
    List<String>? noBarcodes,
    List<String>? repeatedBarcodes,
    String? damageMark,
    String? warehouse,
    int? quantityAvailable,
    List<String>? barcodes,
    String? good,
    String? goodDescription,
    String? packaging,
    String? client,
    String? custom,
    List<String>? associatedOrders,
    String? createdAt2,
    String? etaDate2,
    String? etaI2,
    String? etaF2,
    String? arrival2,
    String? start2,
    String? stop2,
    String? admin,
    String? assistant1,
    String? assistant2,
    String? assistant3,
    String? assistant4,
    String? assistant5,
    String? assistant6,
    String? associatedOrder,
    String? warehousePositionName,
    String? taricCode,
    double? customsPercentage,
    String? euroOrDolar,
    double? exchangeRateUsed,
    double? initCost,
    double? exchangedCost,
    double? valuePerUnit,
    double? customPercentagePerCost,
    double? acumulatedCustomsPercentages,
    double? currentCustomsWarranty,
    double? remainingCustomsThreshold,
    double? euros,
    double? dolars,
    double? weightBalance,
    int? unit,
    String? responsible,
    String? loadingGate,
    double? groupConsumedThreshold,
  })  : _id = id,
        _orderNo = orderNo,
        _clientName = clientName,
        _invStatus = invStatus,
        _acepted = acepted,
        _precheck = precheck,
        _checked = checked,
        _warehouseName = warehouseName,
        _orderStatus = orderStatus,
        _flow = flow,
        _licencePlate = licencePlate,
        _improvement = improvement,
        _containerNo = containerNo,
        _quantity = quantity,
        _packagingName = packagingName,
        _weight = weight,
        _palletPosition = palletPosition,
        _universalRefNo = universalRefNo,
        _fmsRef = fmsRef,
        _loadRefDvh = loadRefDvh,
        _customName = customName,
        _internalRefCustom = internalRefCustom,
        _comment = comment,
        _documents = documents,
        _item = item,
        _opisBlaga = opisBlaga,
        _loadingType = loadingType,
        _otherManipulation = otherManipulation,
        _responsibleName = responsibleName,
        _responsibleLastName = responsibleLastName,
        _assistant1Name = assistant1Name,
        _assistant1LastName = assistant1LastName,
        _assistant2Name = assistant2Name,
        _assistant2LastName = assistant2LastName,
        _adminName = adminName,
        _adminLastName = adminLastName,
        _internalAccounting = internalAccounting,
        _details = details,
        _loadingGateRamp = loadingGateRamp,
        _loadingSequence = loadingSequence,
        _assistant3Name = assistant3Name,
        _assistant3LastName = assistant3LastName,
        _assistant4Name = assistant4Name,
        _assistant4LastName = assistant4LastName,
        _assistant5Name = assistant5Name,
        _assistant5LastName = assistant5LastName,
        _assistant6Name = assistant6Name,
        _assistant6LastName = assistant6LastName,
        _loadingType2 = loadingType2,
        _availability = availability,
        _noBarcodes = noBarcodes,
        _repeatedBarcodes = repeatedBarcodes,
        _damageMark = damageMark,
        _warehouse = warehouse,
        _quantityAvailable = quantityAvailable,
        _barcodes = barcodes,
        _good = good,
        _goodDescription = goodDescription,
        _packaging = packaging,
        _client = client,
        _custom = custom,
        _associatedOrders = associatedOrders,
        _createdAt2 = createdAt2,
        _etaDate2 = etaDate2,
        _etaI2 = etaI2,
        _etaF2 = etaF2,
        _arrival2 = arrival2,
        _start2 = start2,
        _stop2 = stop2,
        _admin = admin,
        _assistant1 = assistant1,
        _assistant2 = assistant2,
        _assistant3 = assistant3,
        _assistant4 = assistant4,
        _assistant5 = assistant5,
        _assistant6 = assistant6,
        _associatedOrder = associatedOrder,
        _warehousePositionName = warehousePositionName,
        _taricCode = taricCode,
        _customsPercentage = customsPercentage,
        _euroOrDolar = euroOrDolar,
        _exchangeRateUsed = exchangeRateUsed,
        _initCost = initCost,
        _exchangedCost = exchangedCost,
        _valuePerUnit = valuePerUnit,
        _customPercentagePerCost = customPercentagePerCost,
        _acumulatedCustomsPercentages = acumulatedCustomsPercentages,
        _currentCustomsWarranty = currentCustomsWarranty,
        _remainingCustomsThreshold = remainingCustomsThreshold,
        _euros = euros,
        _dolars = dolars,
        _weightBalance = weightBalance,
        _unit = unit,
        _responsible = responsible,
        _loadingGate = loadingGate,
        _groupConsumedThreshold = groupConsumedThreshold;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

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

  // "inv_status" field.
  String? _invStatus;
  String get invStatus => _invStatus ?? '';
  set invStatus(String? val) => _invStatus = val;

  bool hasInvStatus() => _invStatus != null;

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

  // "warehouse_name" field.
  String? _warehouseName;
  String get warehouseName => _warehouseName ?? '';
  set warehouseName(String? val) => _warehouseName = val;

  bool hasWarehouseName() => _warehouseName != null;

  // "order_status" field.
  String? _orderStatus;
  String get orderStatus => _orderStatus ?? '';
  set orderStatus(String? val) => _orderStatus = val;

  bool hasOrderStatus() => _orderStatus != null;

  // "flow" field.
  String? _flow;
  String get flow => _flow ?? '';
  set flow(String? val) => _flow = val;

  bool hasFlow() => _flow != null;

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

  // "pallet_position" field.
  double? _palletPosition;
  double get palletPosition => _palletPosition ?? 0.0;
  set palletPosition(double? val) => _palletPosition = val;

  void incrementPalletPosition(double amount) =>
      palletPosition = palletPosition + amount;

  bool hasPalletPosition() => _palletPosition != null;

  // "universal_ref_no" field.
  String? _universalRefNo;
  String get universalRefNo => _universalRefNo ?? '';
  set universalRefNo(String? val) => _universalRefNo = val;

  bool hasUniversalRefNo() => _universalRefNo != null;

  // "fms_ref" field.
  String? _fmsRef;
  String get fmsRef => _fmsRef ?? '';
  set fmsRef(String? val) => _fmsRef = val;

  bool hasFmsRef() => _fmsRef != null;

  // "load_ref_dvh" field.
  String? _loadRefDvh;
  String get loadRefDvh => _loadRefDvh ?? '';
  set loadRefDvh(String? val) => _loadRefDvh = val;

  bool hasLoadRefDvh() => _loadRefDvh != null;

  // "custom_name" field.
  String? _customName;
  String get customName => _customName ?? '';
  set customName(String? val) => _customName = val;

  bool hasCustomName() => _customName != null;

  // "internal_ref_custom" field.
  String? _internalRefCustom;
  String get internalRefCustom => _internalRefCustom ?? '';
  set internalRefCustom(String? val) => _internalRefCustom = val;

  bool hasInternalRefCustom() => _internalRefCustom != null;

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

  // "item" field.
  String? _item;
  String get item => _item ?? '';
  set item(String? val) => _item = val;

  bool hasItem() => _item != null;

  // "opis_blaga" field.
  String? _opisBlaga;
  String get opisBlaga => _opisBlaga ?? '';
  set opisBlaga(String? val) => _opisBlaga = val;

  bool hasOpisBlaga() => _opisBlaga != null;

  // "loading_type" field.
  String? _loadingType;
  String get loadingType => _loadingType ?? '';
  set loadingType(String? val) => _loadingType = val;

  bool hasLoadingType() => _loadingType != null;

  // "other_manipulation" field.
  String? _otherManipulation;
  String get otherManipulation => _otherManipulation ?? '';
  set otherManipulation(String? val) => _otherManipulation = val;

  bool hasOtherManipulation() => _otherManipulation != null;

  // "responsible_name" field.
  String? _responsibleName;
  String get responsibleName => _responsibleName ?? '';
  set responsibleName(String? val) => _responsibleName = val;

  bool hasResponsibleName() => _responsibleName != null;

  // "responsible_last_name" field.
  String? _responsibleLastName;
  String get responsibleLastName => _responsibleLastName ?? '';
  set responsibleLastName(String? val) => _responsibleLastName = val;

  bool hasResponsibleLastName() => _responsibleLastName != null;

  // "assistant1_name" field.
  String? _assistant1Name;
  String get assistant1Name => _assistant1Name ?? '';
  set assistant1Name(String? val) => _assistant1Name = val;

  bool hasAssistant1Name() => _assistant1Name != null;

  // "assistant1_last_name" field.
  String? _assistant1LastName;
  String get assistant1LastName => _assistant1LastName ?? '';
  set assistant1LastName(String? val) => _assistant1LastName = val;

  bool hasAssistant1LastName() => _assistant1LastName != null;

  // "assistant2_name" field.
  String? _assistant2Name;
  String get assistant2Name => _assistant2Name ?? '';
  set assistant2Name(String? val) => _assistant2Name = val;

  bool hasAssistant2Name() => _assistant2Name != null;

  // "assistant2_last_name" field.
  String? _assistant2LastName;
  String get assistant2LastName => _assistant2LastName ?? '';
  set assistant2LastName(String? val) => _assistant2LastName = val;

  bool hasAssistant2LastName() => _assistant2LastName != null;

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

  // "internal_accounting" field.
  String? _internalAccounting;
  String get internalAccounting => _internalAccounting ?? '';
  set internalAccounting(String? val) => _internalAccounting = val;

  bool hasInternalAccounting() => _internalAccounting != null;

  // "details" field.
  int? _details;
  int get details => _details ?? 0;
  set details(int? val) => _details = val;

  void incrementDetails(int amount) => details = details + amount;

  bool hasDetails() => _details != null;

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

  // "assistant3_name" field.
  String? _assistant3Name;
  String get assistant3Name => _assistant3Name ?? '';
  set assistant3Name(String? val) => _assistant3Name = val;

  bool hasAssistant3Name() => _assistant3Name != null;

  // "assistant3_last_name" field.
  String? _assistant3LastName;
  String get assistant3LastName => _assistant3LastName ?? '';
  set assistant3LastName(String? val) => _assistant3LastName = val;

  bool hasAssistant3LastName() => _assistant3LastName != null;

  // "assistant4_name" field.
  String? _assistant4Name;
  String get assistant4Name => _assistant4Name ?? '';
  set assistant4Name(String? val) => _assistant4Name = val;

  bool hasAssistant4Name() => _assistant4Name != null;

  // "assistant4_last_name" field.
  String? _assistant4LastName;
  String get assistant4LastName => _assistant4LastName ?? '';
  set assistant4LastName(String? val) => _assistant4LastName = val;

  bool hasAssistant4LastName() => _assistant4LastName != null;

  // "assistant5_name" field.
  String? _assistant5Name;
  String get assistant5Name => _assistant5Name ?? '';
  set assistant5Name(String? val) => _assistant5Name = val;

  bool hasAssistant5Name() => _assistant5Name != null;

  // "assistant5_last_name" field.
  String? _assistant5LastName;
  String get assistant5LastName => _assistant5LastName ?? '';
  set assistant5LastName(String? val) => _assistant5LastName = val;

  bool hasAssistant5LastName() => _assistant5LastName != null;

  // "assistant6_name" field.
  String? _assistant6Name;
  String get assistant6Name => _assistant6Name ?? '';
  set assistant6Name(String? val) => _assistant6Name = val;

  bool hasAssistant6Name() => _assistant6Name != null;

  // "assistant6_last_name" field.
  String? _assistant6LastName;
  String get assistant6LastName => _assistant6LastName ?? '';
  set assistant6LastName(String? val) => _assistant6LastName = val;

  bool hasAssistant6LastName() => _assistant6LastName != null;

  // "loading_type2" field.
  String? _loadingType2;
  String get loadingType2 => _loadingType2 ?? '';
  set loadingType2(String? val) => _loadingType2 = val;

  bool hasLoadingType2() => _loadingType2 != null;

  // "availability" field.
  String? _availability;
  String get availability => _availability ?? '';
  set availability(String? val) => _availability = val;

  bool hasAvailability() => _availability != null;

  // "no_barcodes" field.
  List<String>? _noBarcodes;
  List<String> get noBarcodes => _noBarcodes ?? const [];
  set noBarcodes(List<String>? val) => _noBarcodes = val;

  void updateNoBarcodes(Function(List<String>) updateFn) {
    updateFn(_noBarcodes ??= []);
  }

  bool hasNoBarcodes() => _noBarcodes != null;

  // "repeated_barcodes" field.
  List<String>? _repeatedBarcodes;
  List<String> get repeatedBarcodes => _repeatedBarcodes ?? const [];
  set repeatedBarcodes(List<String>? val) => _repeatedBarcodes = val;

  void updateRepeatedBarcodes(Function(List<String>) updateFn) {
    updateFn(_repeatedBarcodes ??= []);
  }

  bool hasRepeatedBarcodes() => _repeatedBarcodes != null;

  // "damage_mark" field.
  String? _damageMark;
  String get damageMark => _damageMark ?? '';
  set damageMark(String? val) => _damageMark = val;

  bool hasDamageMark() => _damageMark != null;

  // "warehouse" field.
  String? _warehouse;
  String get warehouse => _warehouse ?? '';
  set warehouse(String? val) => _warehouse = val;

  bool hasWarehouse() => _warehouse != null;

  // "quantity_available" field.
  int? _quantityAvailable;
  int get quantityAvailable => _quantityAvailable ?? 0;
  set quantityAvailable(int? val) => _quantityAvailable = val;

  void incrementQuantityAvailable(int amount) =>
      quantityAvailable = quantityAvailable + amount;

  bool hasQuantityAvailable() => _quantityAvailable != null;

  // "barcodes" field.
  List<String>? _barcodes;
  List<String> get barcodes => _barcodes ?? const [];
  set barcodes(List<String>? val) => _barcodes = val;

  void updateBarcodes(Function(List<String>) updateFn) {
    updateFn(_barcodes ??= []);
  }

  bool hasBarcodes() => _barcodes != null;

  // "good" field.
  String? _good;
  String get good => _good ?? '';
  set good(String? val) => _good = val;

  bool hasGood() => _good != null;

  // "good_description" field.
  String? _goodDescription;
  String get goodDescription => _goodDescription ?? '';
  set goodDescription(String? val) => _goodDescription = val;

  bool hasGoodDescription() => _goodDescription != null;

  // "packaging" field.
  String? _packaging;
  String get packaging => _packaging ?? '';
  set packaging(String? val) => _packaging = val;

  bool hasPackaging() => _packaging != null;

  // "client" field.
  String? _client;
  String get client => _client ?? '';
  set client(String? val) => _client = val;

  bool hasClient() => _client != null;

  // "custom" field.
  String? _custom;
  String get custom => _custom ?? '';
  set custom(String? val) => _custom = val;

  bool hasCustom() => _custom != null;

  // "associated_orders" field.
  List<String>? _associatedOrders;
  List<String> get associatedOrders => _associatedOrders ?? const [];
  set associatedOrders(List<String>? val) => _associatedOrders = val;

  void updateAssociatedOrders(Function(List<String>) updateFn) {
    updateFn(_associatedOrders ??= []);
  }

  bool hasAssociatedOrders() => _associatedOrders != null;

  // "created_at2" field.
  String? _createdAt2;
  String get createdAt2 => _createdAt2 ?? '';
  set createdAt2(String? val) => _createdAt2 = val;

  bool hasCreatedAt2() => _createdAt2 != null;

  // "eta_date2" field.
  String? _etaDate2;
  String get etaDate2 => _etaDate2 ?? '';
  set etaDate2(String? val) => _etaDate2 = val;

  bool hasEtaDate2() => _etaDate2 != null;

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

  // "arrival2" field.
  String? _arrival2;
  String get arrival2 => _arrival2 ?? '';
  set arrival2(String? val) => _arrival2 = val;

  bool hasArrival2() => _arrival2 != null;

  // "start2" field.
  String? _start2;
  String get start2 => _start2 ?? '';
  set start2(String? val) => _start2 = val;

  bool hasStart2() => _start2 != null;

  // "stop2" field.
  String? _stop2;
  String get stop2 => _stop2 ?? '';
  set stop2(String? val) => _stop2 = val;

  bool hasStop2() => _stop2 != null;

  // "admin" field.
  String? _admin;
  String get admin => _admin ?? '';
  set admin(String? val) => _admin = val;

  bool hasAdmin() => _admin != null;

  // "assistant1" field.
  String? _assistant1;
  String get assistant1 => _assistant1 ?? '';
  set assistant1(String? val) => _assistant1 = val;

  bool hasAssistant1() => _assistant1 != null;

  // "assistant2" field.
  String? _assistant2;
  String get assistant2 => _assistant2 ?? '';
  set assistant2(String? val) => _assistant2 = val;

  bool hasAssistant2() => _assistant2 != null;

  // "assistant3" field.
  String? _assistant3;
  String get assistant3 => _assistant3 ?? '';
  set assistant3(String? val) => _assistant3 = val;

  bool hasAssistant3() => _assistant3 != null;

  // "assistant4" field.
  String? _assistant4;
  String get assistant4 => _assistant4 ?? '';
  set assistant4(String? val) => _assistant4 = val;

  bool hasAssistant4() => _assistant4 != null;

  // "assistant5" field.
  String? _assistant5;
  String get assistant5 => _assistant5 ?? '';
  set assistant5(String? val) => _assistant5 = val;

  bool hasAssistant5() => _assistant5 != null;

  // "assistant6" field.
  String? _assistant6;
  String get assistant6 => _assistant6 ?? '';
  set assistant6(String? val) => _assistant6 = val;

  bool hasAssistant6() => _assistant6 != null;

  // "associated_order" field.
  String? _associatedOrder;
  String get associatedOrder => _associatedOrder ?? '';
  set associatedOrder(String? val) => _associatedOrder = val;

  bool hasAssociatedOrder() => _associatedOrder != null;

  // "warehouse_position_name" field.
  String? _warehousePositionName;
  String get warehousePositionName => _warehousePositionName ?? '';
  set warehousePositionName(String? val) => _warehousePositionName = val;

  bool hasWarehousePositionName() => _warehousePositionName != null;

  // "taric_code" field.
  String? _taricCode;
  String get taricCode => _taricCode ?? '';
  set taricCode(String? val) => _taricCode = val;

  bool hasTaricCode() => _taricCode != null;

  // "customs_percentage" field.
  double? _customsPercentage;
  double get customsPercentage => _customsPercentage ?? 0.0;
  set customsPercentage(double? val) => _customsPercentage = val;

  void incrementCustomsPercentage(double amount) =>
      customsPercentage = customsPercentage + amount;

  bool hasCustomsPercentage() => _customsPercentage != null;

  // "euro_or_dolar" field.
  String? _euroOrDolar;
  String get euroOrDolar => _euroOrDolar ?? '';
  set euroOrDolar(String? val) => _euroOrDolar = val;

  bool hasEuroOrDolar() => _euroOrDolar != null;

  // "exchange_rate_used" field.
  double? _exchangeRateUsed;
  double get exchangeRateUsed => _exchangeRateUsed ?? 0.0;
  set exchangeRateUsed(double? val) => _exchangeRateUsed = val;

  void incrementExchangeRateUsed(double amount) =>
      exchangeRateUsed = exchangeRateUsed + amount;

  bool hasExchangeRateUsed() => _exchangeRateUsed != null;

  // "init_cost" field.
  double? _initCost;
  double get initCost => _initCost ?? 0.0;
  set initCost(double? val) => _initCost = val;

  void incrementInitCost(double amount) => initCost = initCost + amount;

  bool hasInitCost() => _initCost != null;

  // "exchanged_cost" field.
  double? _exchangedCost;
  double get exchangedCost => _exchangedCost ?? 0.0;
  set exchangedCost(double? val) => _exchangedCost = val;

  void incrementExchangedCost(double amount) =>
      exchangedCost = exchangedCost + amount;

  bool hasExchangedCost() => _exchangedCost != null;

  // "value_per_unit" field.
  double? _valuePerUnit;
  double get valuePerUnit => _valuePerUnit ?? 0.0;
  set valuePerUnit(double? val) => _valuePerUnit = val;

  void incrementValuePerUnit(double amount) =>
      valuePerUnit = valuePerUnit + amount;

  bool hasValuePerUnit() => _valuePerUnit != null;

  // "custom_percentage_per_cost" field.
  double? _customPercentagePerCost;
  double get customPercentagePerCost => _customPercentagePerCost ?? 0.0;
  set customPercentagePerCost(double? val) => _customPercentagePerCost = val;

  void incrementCustomPercentagePerCost(double amount) =>
      customPercentagePerCost = customPercentagePerCost + amount;

  bool hasCustomPercentagePerCost() => _customPercentagePerCost != null;

  // "acumulated_customs_percentages" field.
  double? _acumulatedCustomsPercentages;
  double get acumulatedCustomsPercentages =>
      _acumulatedCustomsPercentages ?? 0.0;
  set acumulatedCustomsPercentages(double? val) =>
      _acumulatedCustomsPercentages = val;

  void incrementAcumulatedCustomsPercentages(double amount) =>
      acumulatedCustomsPercentages = acumulatedCustomsPercentages + amount;

  bool hasAcumulatedCustomsPercentages() =>
      _acumulatedCustomsPercentages != null;

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

  // "euros" field.
  double? _euros;
  double get euros => _euros ?? 0.0;
  set euros(double? val) => _euros = val;

  void incrementEuros(double amount) => euros = euros + amount;

  bool hasEuros() => _euros != null;

  // "dolars" field.
  double? _dolars;
  double get dolars => _dolars ?? 0.0;
  set dolars(double? val) => _dolars = val;

  void incrementDolars(double amount) => dolars = dolars + amount;

  bool hasDolars() => _dolars != null;

  // "weight_balance" field.
  double? _weightBalance;
  double get weightBalance => _weightBalance ?? 0.0;
  set weightBalance(double? val) => _weightBalance = val;

  void incrementWeightBalance(double amount) =>
      weightBalance = weightBalance + amount;

  bool hasWeightBalance() => _weightBalance != null;

  // "unit" field.
  int? _unit;
  int get unit => _unit ?? 0;
  set unit(int? val) => _unit = val;

  void incrementUnit(int amount) => unit = unit + amount;

  bool hasUnit() => _unit != null;

  // "responsible" field.
  String? _responsible;
  String get responsible => _responsible ?? '';
  set responsible(String? val) => _responsible = val;

  bool hasResponsible() => _responsible != null;

  // "loading_gate" field.
  String? _loadingGate;
  String get loadingGate => _loadingGate ?? '';
  set loadingGate(String? val) => _loadingGate = val;

  bool hasLoadingGate() => _loadingGate != null;

  // "group_consumed_threshold" field.
  double? _groupConsumedThreshold;
  double get groupConsumedThreshold => _groupConsumedThreshold ?? 0.0;
  set groupConsumedThreshold(double? val) => _groupConsumedThreshold = val;

  void incrementGroupConsumedThreshold(double amount) =>
      groupConsumedThreshold = groupConsumedThreshold + amount;

  bool hasGroupConsumedThreshold() => _groupConsumedThreshold != null;

  static OrderWarehouseRowStruct fromMap(Map<String, dynamic> data) =>
      OrderWarehouseRowStruct(
        id: data['id'] as String?,
        orderNo: data['order_no'] as String?,
        clientName: data['client_name'] as String?,
        invStatus: data['inv_status'] as String?,
        acepted: data['acepted'] as bool?,
        precheck: data['precheck'] as bool?,
        checked: data['checked'] as bool?,
        warehouseName: data['warehouse_name'] as String?,
        orderStatus: data['order_status'] as String?,
        flow: data['flow'] as String?,
        licencePlate: data['licence_plate'] as String?,
        improvement: data['improvement'] as String?,
        containerNo: data['container_no'] as String?,
        quantity: castToType<int>(data['quantity']),
        packagingName: data['packaging_name'] as String?,
        weight: castToType<int>(data['weight']),
        palletPosition: castToType<double>(data['pallet_position']),
        universalRefNo: data['universal_ref_no'] as String?,
        fmsRef: data['fms_ref'] as String?,
        loadRefDvh: data['load_ref_dvh'] as String?,
        customName: data['custom_name'] as String?,
        internalRefCustom: data['internal_ref_custom'] as String?,
        comment: data['comment'] as String?,
        documents: getDataList(data['documents']),
        item: data['item'] as String?,
        opisBlaga: data['opis_blaga'] as String?,
        loadingType: data['loading_type'] as String?,
        otherManipulation: data['other_manipulation'] as String?,
        responsibleName: data['responsible_name'] as String?,
        responsibleLastName: data['responsible_last_name'] as String?,
        assistant1Name: data['assistant1_name'] as String?,
        assistant1LastName: data['assistant1_last_name'] as String?,
        assistant2Name: data['assistant2_name'] as String?,
        assistant2LastName: data['assistant2_last_name'] as String?,
        adminName: data['admin_name'] as String?,
        adminLastName: data['admin_last_name'] as String?,
        internalAccounting: data['internal_accounting'] as String?,
        details: castToType<int>(data['details']),
        loadingGateRamp: data['loading_gate_ramp'] as String?,
        loadingSequence: castToType<int>(data['loading_sequence']),
        assistant3Name: data['assistant3_name'] as String?,
        assistant3LastName: data['assistant3_last_name'] as String?,
        assistant4Name: data['assistant4_name'] as String?,
        assistant4LastName: data['assistant4_last_name'] as String?,
        assistant5Name: data['assistant5_name'] as String?,
        assistant5LastName: data['assistant5_last_name'] as String?,
        assistant6Name: data['assistant6_name'] as String?,
        assistant6LastName: data['assistant6_last_name'] as String?,
        loadingType2: data['loading_type2'] as String?,
        availability: data['availability'] as String?,
        noBarcodes: getDataList(data['no_barcodes']),
        repeatedBarcodes: getDataList(data['repeated_barcodes']),
        damageMark: data['damage_mark'] as String?,
        warehouse: data['warehouse'] as String?,
        quantityAvailable: castToType<int>(data['quantity_available']),
        barcodes: getDataList(data['barcodes']),
        good: data['good'] as String?,
        goodDescription: data['good_description'] as String?,
        packaging: data['packaging'] as String?,
        client: data['client'] as String?,
        custom: data['custom'] as String?,
        associatedOrders: getDataList(data['associated_orders']),
        createdAt2: data['created_at2'] as String?,
        etaDate2: data['eta_date2'] as String?,
        etaI2: data['eta_i2'] as String?,
        etaF2: data['eta_f2'] as String?,
        arrival2: data['arrival2'] as String?,
        start2: data['start2'] as String?,
        stop2: data['stop2'] as String?,
        admin: data['admin'] as String?,
        assistant1: data['assistant1'] as String?,
        assistant2: data['assistant2'] as String?,
        assistant3: data['assistant3'] as String?,
        assistant4: data['assistant4'] as String?,
        assistant5: data['assistant5'] as String?,
        assistant6: data['assistant6'] as String?,
        associatedOrder: data['associated_order'] as String?,
        warehousePositionName: data['warehouse_position_name'] as String?,
        taricCode: data['taric_code'] as String?,
        customsPercentage: castToType<double>(data['customs_percentage']),
        euroOrDolar: data['euro_or_dolar'] as String?,
        exchangeRateUsed: castToType<double>(data['exchange_rate_used']),
        initCost: castToType<double>(data['init_cost']),
        exchangedCost: castToType<double>(data['exchanged_cost']),
        valuePerUnit: castToType<double>(data['value_per_unit']),
        customPercentagePerCost:
            castToType<double>(data['custom_percentage_per_cost']),
        acumulatedCustomsPercentages:
            castToType<double>(data['acumulated_customs_percentages']),
        currentCustomsWarranty:
            castToType<double>(data['current_customs_warranty']),
        remainingCustomsThreshold:
            castToType<double>(data['remaining_customs_threshold']),
        euros: castToType<double>(data['euros']),
        dolars: castToType<double>(data['dolars']),
        weightBalance: castToType<double>(data['weight_balance']),
        unit: castToType<int>(data['unit']),
        responsible: data['responsible'] as String?,
        loadingGate: data['loading_gate'] as String?,
        groupConsumedThreshold:
            castToType<double>(data['group_consumed_threshold']),
      );

  static OrderWarehouseRowStruct? maybeFromMap(dynamic data) => data is Map
      ? OrderWarehouseRowStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'order_no': _orderNo,
        'client_name': _clientName,
        'inv_status': _invStatus,
        'acepted': _acepted,
        'precheck': _precheck,
        'checked': _checked,
        'warehouse_name': _warehouseName,
        'order_status': _orderStatus,
        'flow': _flow,
        'licence_plate': _licencePlate,
        'improvement': _improvement,
        'container_no': _containerNo,
        'quantity': _quantity,
        'packaging_name': _packagingName,
        'weight': _weight,
        'pallet_position': _palletPosition,
        'universal_ref_no': _universalRefNo,
        'fms_ref': _fmsRef,
        'load_ref_dvh': _loadRefDvh,
        'custom_name': _customName,
        'internal_ref_custom': _internalRefCustom,
        'comment': _comment,
        'documents': _documents,
        'item': _item,
        'opis_blaga': _opisBlaga,
        'loading_type': _loadingType,
        'other_manipulation': _otherManipulation,
        'responsible_name': _responsibleName,
        'responsible_last_name': _responsibleLastName,
        'assistant1_name': _assistant1Name,
        'assistant1_last_name': _assistant1LastName,
        'assistant2_name': _assistant2Name,
        'assistant2_last_name': _assistant2LastName,
        'admin_name': _adminName,
        'admin_last_name': _adminLastName,
        'internal_accounting': _internalAccounting,
        'details': _details,
        'loading_gate_ramp': _loadingGateRamp,
        'loading_sequence': _loadingSequence,
        'assistant3_name': _assistant3Name,
        'assistant3_last_name': _assistant3LastName,
        'assistant4_name': _assistant4Name,
        'assistant4_last_name': _assistant4LastName,
        'assistant5_name': _assistant5Name,
        'assistant5_last_name': _assistant5LastName,
        'assistant6_name': _assistant6Name,
        'assistant6_last_name': _assistant6LastName,
        'loading_type2': _loadingType2,
        'availability': _availability,
        'no_barcodes': _noBarcodes,
        'repeated_barcodes': _repeatedBarcodes,
        'damage_mark': _damageMark,
        'warehouse': _warehouse,
        'quantity_available': _quantityAvailable,
        'barcodes': _barcodes,
        'good': _good,
        'good_description': _goodDescription,
        'packaging': _packaging,
        'client': _client,
        'custom': _custom,
        'associated_orders': _associatedOrders,
        'created_at2': _createdAt2,
        'eta_date2': _etaDate2,
        'eta_i2': _etaI2,
        'eta_f2': _etaF2,
        'arrival2': _arrival2,
        'start2': _start2,
        'stop2': _stop2,
        'admin': _admin,
        'assistant1': _assistant1,
        'assistant2': _assistant2,
        'assistant3': _assistant3,
        'assistant4': _assistant4,
        'assistant5': _assistant5,
        'assistant6': _assistant6,
        'associated_order': _associatedOrder,
        'warehouse_position_name': _warehousePositionName,
        'taric_code': _taricCode,
        'customs_percentage': _customsPercentage,
        'euro_or_dolar': _euroOrDolar,
        'exchange_rate_used': _exchangeRateUsed,
        'init_cost': _initCost,
        'exchanged_cost': _exchangedCost,
        'value_per_unit': _valuePerUnit,
        'custom_percentage_per_cost': _customPercentagePerCost,
        'acumulated_customs_percentages': _acumulatedCustomsPercentages,
        'current_customs_warranty': _currentCustomsWarranty,
        'remaining_customs_threshold': _remainingCustomsThreshold,
        'euros': _euros,
        'dolars': _dolars,
        'weight_balance': _weightBalance,
        'unit': _unit,
        'responsible': _responsible,
        'loading_gate': _loadingGate,
        'group_consumed_threshold': _groupConsumedThreshold,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
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
        'inv_status': serializeParam(
          _invStatus,
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
        'warehouse_name': serializeParam(
          _warehouseName,
          ParamType.String,
        ),
        'order_status': serializeParam(
          _orderStatus,
          ParamType.String,
        ),
        'flow': serializeParam(
          _flow,
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
        'pallet_position': serializeParam(
          _palletPosition,
          ParamType.double,
        ),
        'universal_ref_no': serializeParam(
          _universalRefNo,
          ParamType.String,
        ),
        'fms_ref': serializeParam(
          _fmsRef,
          ParamType.String,
        ),
        'load_ref_dvh': serializeParam(
          _loadRefDvh,
          ParamType.String,
        ),
        'custom_name': serializeParam(
          _customName,
          ParamType.String,
        ),
        'internal_ref_custom': serializeParam(
          _internalRefCustom,
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
        'item': serializeParam(
          _item,
          ParamType.String,
        ),
        'opis_blaga': serializeParam(
          _opisBlaga,
          ParamType.String,
        ),
        'loading_type': serializeParam(
          _loadingType,
          ParamType.String,
        ),
        'other_manipulation': serializeParam(
          _otherManipulation,
          ParamType.String,
        ),
        'responsible_name': serializeParam(
          _responsibleName,
          ParamType.String,
        ),
        'responsible_last_name': serializeParam(
          _responsibleLastName,
          ParamType.String,
        ),
        'assistant1_name': serializeParam(
          _assistant1Name,
          ParamType.String,
        ),
        'assistant1_last_name': serializeParam(
          _assistant1LastName,
          ParamType.String,
        ),
        'assistant2_name': serializeParam(
          _assistant2Name,
          ParamType.String,
        ),
        'assistant2_last_name': serializeParam(
          _assistant2LastName,
          ParamType.String,
        ),
        'admin_name': serializeParam(
          _adminName,
          ParamType.String,
        ),
        'admin_last_name': serializeParam(
          _adminLastName,
          ParamType.String,
        ),
        'internal_accounting': serializeParam(
          _internalAccounting,
          ParamType.String,
        ),
        'details': serializeParam(
          _details,
          ParamType.int,
        ),
        'loading_gate_ramp': serializeParam(
          _loadingGateRamp,
          ParamType.String,
        ),
        'loading_sequence': serializeParam(
          _loadingSequence,
          ParamType.int,
        ),
        'assistant3_name': serializeParam(
          _assistant3Name,
          ParamType.String,
        ),
        'assistant3_last_name': serializeParam(
          _assistant3LastName,
          ParamType.String,
        ),
        'assistant4_name': serializeParam(
          _assistant4Name,
          ParamType.String,
        ),
        'assistant4_last_name': serializeParam(
          _assistant4LastName,
          ParamType.String,
        ),
        'assistant5_name': serializeParam(
          _assistant5Name,
          ParamType.String,
        ),
        'assistant5_last_name': serializeParam(
          _assistant5LastName,
          ParamType.String,
        ),
        'assistant6_name': serializeParam(
          _assistant6Name,
          ParamType.String,
        ),
        'assistant6_last_name': serializeParam(
          _assistant6LastName,
          ParamType.String,
        ),
        'loading_type2': serializeParam(
          _loadingType2,
          ParamType.String,
        ),
        'availability': serializeParam(
          _availability,
          ParamType.String,
        ),
        'no_barcodes': serializeParam(
          _noBarcodes,
          ParamType.String,
          isList: true,
        ),
        'repeated_barcodes': serializeParam(
          _repeatedBarcodes,
          ParamType.String,
          isList: true,
        ),
        'damage_mark': serializeParam(
          _damageMark,
          ParamType.String,
        ),
        'warehouse': serializeParam(
          _warehouse,
          ParamType.String,
        ),
        'quantity_available': serializeParam(
          _quantityAvailable,
          ParamType.int,
        ),
        'barcodes': serializeParam(
          _barcodes,
          ParamType.String,
          isList: true,
        ),
        'good': serializeParam(
          _good,
          ParamType.String,
        ),
        'good_description': serializeParam(
          _goodDescription,
          ParamType.String,
        ),
        'packaging': serializeParam(
          _packaging,
          ParamType.String,
        ),
        'client': serializeParam(
          _client,
          ParamType.String,
        ),
        'custom': serializeParam(
          _custom,
          ParamType.String,
        ),
        'associated_orders': serializeParam(
          _associatedOrders,
          ParamType.String,
          isList: true,
        ),
        'created_at2': serializeParam(
          _createdAt2,
          ParamType.String,
        ),
        'eta_date2': serializeParam(
          _etaDate2,
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
        'arrival2': serializeParam(
          _arrival2,
          ParamType.String,
        ),
        'start2': serializeParam(
          _start2,
          ParamType.String,
        ),
        'stop2': serializeParam(
          _stop2,
          ParamType.String,
        ),
        'admin': serializeParam(
          _admin,
          ParamType.String,
        ),
        'assistant1': serializeParam(
          _assistant1,
          ParamType.String,
        ),
        'assistant2': serializeParam(
          _assistant2,
          ParamType.String,
        ),
        'assistant3': serializeParam(
          _assistant3,
          ParamType.String,
        ),
        'assistant4': serializeParam(
          _assistant4,
          ParamType.String,
        ),
        'assistant5': serializeParam(
          _assistant5,
          ParamType.String,
        ),
        'assistant6': serializeParam(
          _assistant6,
          ParamType.String,
        ),
        'associated_order': serializeParam(
          _associatedOrder,
          ParamType.String,
        ),
        'warehouse_position_name': serializeParam(
          _warehousePositionName,
          ParamType.String,
        ),
        'taric_code': serializeParam(
          _taricCode,
          ParamType.String,
        ),
        'customs_percentage': serializeParam(
          _customsPercentage,
          ParamType.double,
        ),
        'euro_or_dolar': serializeParam(
          _euroOrDolar,
          ParamType.String,
        ),
        'exchange_rate_used': serializeParam(
          _exchangeRateUsed,
          ParamType.double,
        ),
        'init_cost': serializeParam(
          _initCost,
          ParamType.double,
        ),
        'exchanged_cost': serializeParam(
          _exchangedCost,
          ParamType.double,
        ),
        'value_per_unit': serializeParam(
          _valuePerUnit,
          ParamType.double,
        ),
        'custom_percentage_per_cost': serializeParam(
          _customPercentagePerCost,
          ParamType.double,
        ),
        'acumulated_customs_percentages': serializeParam(
          _acumulatedCustomsPercentages,
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
        'euros': serializeParam(
          _euros,
          ParamType.double,
        ),
        'dolars': serializeParam(
          _dolars,
          ParamType.double,
        ),
        'weight_balance': serializeParam(
          _weightBalance,
          ParamType.double,
        ),
        'unit': serializeParam(
          _unit,
          ParamType.int,
        ),
        'responsible': serializeParam(
          _responsible,
          ParamType.String,
        ),
        'loading_gate': serializeParam(
          _loadingGate,
          ParamType.String,
        ),
        'group_consumed_threshold': serializeParam(
          _groupConsumedThreshold,
          ParamType.double,
        ),
      }.withoutNulls;

  static OrderWarehouseRowStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      OrderWarehouseRowStruct(
        id: deserializeParam(
          data['id'],
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
        invStatus: deserializeParam(
          data['inv_status'],
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
        warehouseName: deserializeParam(
          data['warehouse_name'],
          ParamType.String,
          false,
        ),
        orderStatus: deserializeParam(
          data['order_status'],
          ParamType.String,
          false,
        ),
        flow: deserializeParam(
          data['flow'],
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
        palletPosition: deserializeParam(
          data['pallet_position'],
          ParamType.double,
          false,
        ),
        universalRefNo: deserializeParam(
          data['universal_ref_no'],
          ParamType.String,
          false,
        ),
        fmsRef: deserializeParam(
          data['fms_ref'],
          ParamType.String,
          false,
        ),
        loadRefDvh: deserializeParam(
          data['load_ref_dvh'],
          ParamType.String,
          false,
        ),
        customName: deserializeParam(
          data['custom_name'],
          ParamType.String,
          false,
        ),
        internalRefCustom: deserializeParam(
          data['internal_ref_custom'],
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
        item: deserializeParam(
          data['item'],
          ParamType.String,
          false,
        ),
        opisBlaga: deserializeParam(
          data['opis_blaga'],
          ParamType.String,
          false,
        ),
        loadingType: deserializeParam(
          data['loading_type'],
          ParamType.String,
          false,
        ),
        otherManipulation: deserializeParam(
          data['other_manipulation'],
          ParamType.String,
          false,
        ),
        responsibleName: deserializeParam(
          data['responsible_name'],
          ParamType.String,
          false,
        ),
        responsibleLastName: deserializeParam(
          data['responsible_last_name'],
          ParamType.String,
          false,
        ),
        assistant1Name: deserializeParam(
          data['assistant1_name'],
          ParamType.String,
          false,
        ),
        assistant1LastName: deserializeParam(
          data['assistant1_last_name'],
          ParamType.String,
          false,
        ),
        assistant2Name: deserializeParam(
          data['assistant2_name'],
          ParamType.String,
          false,
        ),
        assistant2LastName: deserializeParam(
          data['assistant2_last_name'],
          ParamType.String,
          false,
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
        internalAccounting: deserializeParam(
          data['internal_accounting'],
          ParamType.String,
          false,
        ),
        details: deserializeParam(
          data['details'],
          ParamType.int,
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
        assistant3Name: deserializeParam(
          data['assistant3_name'],
          ParamType.String,
          false,
        ),
        assistant3LastName: deserializeParam(
          data['assistant3_last_name'],
          ParamType.String,
          false,
        ),
        assistant4Name: deserializeParam(
          data['assistant4_name'],
          ParamType.String,
          false,
        ),
        assistant4LastName: deserializeParam(
          data['assistant4_last_name'],
          ParamType.String,
          false,
        ),
        assistant5Name: deserializeParam(
          data['assistant5_name'],
          ParamType.String,
          false,
        ),
        assistant5LastName: deserializeParam(
          data['assistant5_last_name'],
          ParamType.String,
          false,
        ),
        assistant6Name: deserializeParam(
          data['assistant6_name'],
          ParamType.String,
          false,
        ),
        assistant6LastName: deserializeParam(
          data['assistant6_last_name'],
          ParamType.String,
          false,
        ),
        loadingType2: deserializeParam(
          data['loading_type2'],
          ParamType.String,
          false,
        ),
        availability: deserializeParam(
          data['availability'],
          ParamType.String,
          false,
        ),
        noBarcodes: deserializeParam<String>(
          data['no_barcodes'],
          ParamType.String,
          true,
        ),
        repeatedBarcodes: deserializeParam<String>(
          data['repeated_barcodes'],
          ParamType.String,
          true,
        ),
        damageMark: deserializeParam(
          data['damage_mark'],
          ParamType.String,
          false,
        ),
        warehouse: deserializeParam(
          data['warehouse'],
          ParamType.String,
          false,
        ),
        quantityAvailable: deserializeParam(
          data['quantity_available'],
          ParamType.int,
          false,
        ),
        barcodes: deserializeParam<String>(
          data['barcodes'],
          ParamType.String,
          true,
        ),
        good: deserializeParam(
          data['good'],
          ParamType.String,
          false,
        ),
        goodDescription: deserializeParam(
          data['good_description'],
          ParamType.String,
          false,
        ),
        packaging: deserializeParam(
          data['packaging'],
          ParamType.String,
          false,
        ),
        client: deserializeParam(
          data['client'],
          ParamType.String,
          false,
        ),
        custom: deserializeParam(
          data['custom'],
          ParamType.String,
          false,
        ),
        associatedOrders: deserializeParam<String>(
          data['associated_orders'],
          ParamType.String,
          true,
        ),
        createdAt2: deserializeParam(
          data['created_at2'],
          ParamType.String,
          false,
        ),
        etaDate2: deserializeParam(
          data['eta_date2'],
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
        arrival2: deserializeParam(
          data['arrival2'],
          ParamType.String,
          false,
        ),
        start2: deserializeParam(
          data['start2'],
          ParamType.String,
          false,
        ),
        stop2: deserializeParam(
          data['stop2'],
          ParamType.String,
          false,
        ),
        admin: deserializeParam(
          data['admin'],
          ParamType.String,
          false,
        ),
        assistant1: deserializeParam(
          data['assistant1'],
          ParamType.String,
          false,
        ),
        assistant2: deserializeParam(
          data['assistant2'],
          ParamType.String,
          false,
        ),
        assistant3: deserializeParam(
          data['assistant3'],
          ParamType.String,
          false,
        ),
        assistant4: deserializeParam(
          data['assistant4'],
          ParamType.String,
          false,
        ),
        assistant5: deserializeParam(
          data['assistant5'],
          ParamType.String,
          false,
        ),
        assistant6: deserializeParam(
          data['assistant6'],
          ParamType.String,
          false,
        ),
        associatedOrder: deserializeParam(
          data['associated_order'],
          ParamType.String,
          false,
        ),
        warehousePositionName: deserializeParam(
          data['warehouse_position_name'],
          ParamType.String,
          false,
        ),
        taricCode: deserializeParam(
          data['taric_code'],
          ParamType.String,
          false,
        ),
        customsPercentage: deserializeParam(
          data['customs_percentage'],
          ParamType.double,
          false,
        ),
        euroOrDolar: deserializeParam(
          data['euro_or_dolar'],
          ParamType.String,
          false,
        ),
        exchangeRateUsed: deserializeParam(
          data['exchange_rate_used'],
          ParamType.double,
          false,
        ),
        initCost: deserializeParam(
          data['init_cost'],
          ParamType.double,
          false,
        ),
        exchangedCost: deserializeParam(
          data['exchanged_cost'],
          ParamType.double,
          false,
        ),
        valuePerUnit: deserializeParam(
          data['value_per_unit'],
          ParamType.double,
          false,
        ),
        customPercentagePerCost: deserializeParam(
          data['custom_percentage_per_cost'],
          ParamType.double,
          false,
        ),
        acumulatedCustomsPercentages: deserializeParam(
          data['acumulated_customs_percentages'],
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
        euros: deserializeParam(
          data['euros'],
          ParamType.double,
          false,
        ),
        dolars: deserializeParam(
          data['dolars'],
          ParamType.double,
          false,
        ),
        weightBalance: deserializeParam(
          data['weight_balance'],
          ParamType.double,
          false,
        ),
        unit: deserializeParam(
          data['unit'],
          ParamType.int,
          false,
        ),
        responsible: deserializeParam(
          data['responsible'],
          ParamType.String,
          false,
        ),
        loadingGate: deserializeParam(
          data['loading_gate'],
          ParamType.String,
          false,
        ),
        groupConsumedThreshold: deserializeParam(
          data['group_consumed_threshold'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'OrderWarehouseRowStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is OrderWarehouseRowStruct &&
        id == other.id &&
        orderNo == other.orderNo &&
        clientName == other.clientName &&
        invStatus == other.invStatus &&
        acepted == other.acepted &&
        precheck == other.precheck &&
        checked == other.checked &&
        warehouseName == other.warehouseName &&
        orderStatus == other.orderStatus &&
        flow == other.flow &&
        licencePlate == other.licencePlate &&
        improvement == other.improvement &&
        containerNo == other.containerNo &&
        quantity == other.quantity &&
        packagingName == other.packagingName &&
        weight == other.weight &&
        palletPosition == other.palletPosition &&
        universalRefNo == other.universalRefNo &&
        fmsRef == other.fmsRef &&
        loadRefDvh == other.loadRefDvh &&
        customName == other.customName &&
        internalRefCustom == other.internalRefCustom &&
        comment == other.comment &&
        listEquality.equals(documents, other.documents) &&
        item == other.item &&
        opisBlaga == other.opisBlaga &&
        loadingType == other.loadingType &&
        otherManipulation == other.otherManipulation &&
        responsibleName == other.responsibleName &&
        responsibleLastName == other.responsibleLastName &&
        assistant1Name == other.assistant1Name &&
        assistant1LastName == other.assistant1LastName &&
        assistant2Name == other.assistant2Name &&
        assistant2LastName == other.assistant2LastName &&
        adminName == other.adminName &&
        adminLastName == other.adminLastName &&
        internalAccounting == other.internalAccounting &&
        details == other.details &&
        loadingGateRamp == other.loadingGateRamp &&
        loadingSequence == other.loadingSequence &&
        assistant3Name == other.assistant3Name &&
        assistant3LastName == other.assistant3LastName &&
        assistant4Name == other.assistant4Name &&
        assistant4LastName == other.assistant4LastName &&
        assistant5Name == other.assistant5Name &&
        assistant5LastName == other.assistant5LastName &&
        assistant6Name == other.assistant6Name &&
        assistant6LastName == other.assistant6LastName &&
        loadingType2 == other.loadingType2 &&
        availability == other.availability &&
        listEquality.equals(noBarcodes, other.noBarcodes) &&
        listEquality.equals(repeatedBarcodes, other.repeatedBarcodes) &&
        damageMark == other.damageMark &&
        warehouse == other.warehouse &&
        quantityAvailable == other.quantityAvailable &&
        listEquality.equals(barcodes, other.barcodes) &&
        good == other.good &&
        goodDescription == other.goodDescription &&
        packaging == other.packaging &&
        client == other.client &&
        custom == other.custom &&
        listEquality.equals(associatedOrders, other.associatedOrders) &&
        createdAt2 == other.createdAt2 &&
        etaDate2 == other.etaDate2 &&
        etaI2 == other.etaI2 &&
        etaF2 == other.etaF2 &&
        arrival2 == other.arrival2 &&
        start2 == other.start2 &&
        stop2 == other.stop2 &&
        admin == other.admin &&
        assistant1 == other.assistant1 &&
        assistant2 == other.assistant2 &&
        assistant3 == other.assistant3 &&
        assistant4 == other.assistant4 &&
        assistant5 == other.assistant5 &&
        assistant6 == other.assistant6 &&
        associatedOrder == other.associatedOrder &&
        warehousePositionName == other.warehousePositionName &&
        taricCode == other.taricCode &&
        customsPercentage == other.customsPercentage &&
        euroOrDolar == other.euroOrDolar &&
        exchangeRateUsed == other.exchangeRateUsed &&
        initCost == other.initCost &&
        exchangedCost == other.exchangedCost &&
        valuePerUnit == other.valuePerUnit &&
        customPercentagePerCost == other.customPercentagePerCost &&
        acumulatedCustomsPercentages == other.acumulatedCustomsPercentages &&
        currentCustomsWarranty == other.currentCustomsWarranty &&
        remainingCustomsThreshold == other.remainingCustomsThreshold &&
        euros == other.euros &&
        dolars == other.dolars &&
        weightBalance == other.weightBalance &&
        unit == other.unit &&
        responsible == other.responsible &&
        loadingGate == other.loadingGate &&
        groupConsumedThreshold == other.groupConsumedThreshold;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        orderNo,
        clientName,
        invStatus,
        acepted,
        precheck,
        checked,
        warehouseName,
        orderStatus,
        flow,
        licencePlate,
        improvement,
        containerNo,
        quantity,
        packagingName,
        weight,
        palletPosition,
        universalRefNo,
        fmsRef,
        loadRefDvh,
        customName,
        internalRefCustom,
        comment,
        documents,
        item,
        opisBlaga,
        loadingType,
        otherManipulation,
        responsibleName,
        responsibleLastName,
        assistant1Name,
        assistant1LastName,
        assistant2Name,
        assistant2LastName,
        adminName,
        adminLastName,
        internalAccounting,
        details,
        loadingGateRamp,
        loadingSequence,
        assistant3Name,
        assistant3LastName,
        assistant4Name,
        assistant4LastName,
        assistant5Name,
        assistant5LastName,
        assistant6Name,
        assistant6LastName,
        loadingType2,
        availability,
        noBarcodes,
        repeatedBarcodes,
        damageMark,
        warehouse,
        quantityAvailable,
        barcodes,
        good,
        goodDescription,
        packaging,
        client,
        custom,
        associatedOrders,
        createdAt2,
        etaDate2,
        etaI2,
        etaF2,
        arrival2,
        start2,
        stop2,
        admin,
        assistant1,
        assistant2,
        assistant3,
        assistant4,
        assistant5,
        assistant6,
        associatedOrder,
        warehousePositionName,
        taricCode,
        customsPercentage,
        euroOrDolar,
        exchangeRateUsed,
        initCost,
        exchangedCost,
        valuePerUnit,
        customPercentagePerCost,
        acumulatedCustomsPercentages,
        currentCustomsWarranty,
        remainingCustomsThreshold,
        euros,
        dolars,
        weightBalance,
        unit,
        responsible,
        loadingGate,
        groupConsumedThreshold
      ]);
}

OrderWarehouseRowStruct createOrderWarehouseRowStruct({
  String? id,
  String? orderNo,
  String? clientName,
  String? invStatus,
  bool? acepted,
  bool? precheck,
  bool? checked,
  String? warehouseName,
  String? orderStatus,
  String? flow,
  String? licencePlate,
  String? improvement,
  String? containerNo,
  int? quantity,
  String? packagingName,
  int? weight,
  double? palletPosition,
  String? universalRefNo,
  String? fmsRef,
  String? loadRefDvh,
  String? customName,
  String? internalRefCustom,
  String? comment,
  String? item,
  String? opisBlaga,
  String? loadingType,
  String? otherManipulation,
  String? responsibleName,
  String? responsibleLastName,
  String? assistant1Name,
  String? assistant1LastName,
  String? assistant2Name,
  String? assistant2LastName,
  String? adminName,
  String? adminLastName,
  String? internalAccounting,
  int? details,
  String? loadingGateRamp,
  int? loadingSequence,
  String? assistant3Name,
  String? assistant3LastName,
  String? assistant4Name,
  String? assistant4LastName,
  String? assistant5Name,
  String? assistant5LastName,
  String? assistant6Name,
  String? assistant6LastName,
  String? loadingType2,
  String? availability,
  String? damageMark,
  String? warehouse,
  int? quantityAvailable,
  String? good,
  String? goodDescription,
  String? packaging,
  String? client,
  String? custom,
  String? createdAt2,
  String? etaDate2,
  String? etaI2,
  String? etaF2,
  String? arrival2,
  String? start2,
  String? stop2,
  String? admin,
  String? assistant1,
  String? assistant2,
  String? assistant3,
  String? assistant4,
  String? assistant5,
  String? assistant6,
  String? associatedOrder,
  String? warehousePositionName,
  String? taricCode,
  double? customsPercentage,
  String? euroOrDolar,
  double? exchangeRateUsed,
  double? initCost,
  double? exchangedCost,
  double? valuePerUnit,
  double? customPercentagePerCost,
  double? acumulatedCustomsPercentages,
  double? currentCustomsWarranty,
  double? remainingCustomsThreshold,
  double? euros,
  double? dolars,
  double? weightBalance,
  int? unit,
  String? responsible,
  String? loadingGate,
  double? groupConsumedThreshold,
}) =>
    OrderWarehouseRowStruct(
      id: id,
      orderNo: orderNo,
      clientName: clientName,
      invStatus: invStatus,
      acepted: acepted,
      precheck: precheck,
      checked: checked,
      warehouseName: warehouseName,
      orderStatus: orderStatus,
      flow: flow,
      licencePlate: licencePlate,
      improvement: improvement,
      containerNo: containerNo,
      quantity: quantity,
      packagingName: packagingName,
      weight: weight,
      palletPosition: palletPosition,
      universalRefNo: universalRefNo,
      fmsRef: fmsRef,
      loadRefDvh: loadRefDvh,
      customName: customName,
      internalRefCustom: internalRefCustom,
      comment: comment,
      item: item,
      opisBlaga: opisBlaga,
      loadingType: loadingType,
      otherManipulation: otherManipulation,
      responsibleName: responsibleName,
      responsibleLastName: responsibleLastName,
      assistant1Name: assistant1Name,
      assistant1LastName: assistant1LastName,
      assistant2Name: assistant2Name,
      assistant2LastName: assistant2LastName,
      adminName: adminName,
      adminLastName: adminLastName,
      internalAccounting: internalAccounting,
      details: details,
      loadingGateRamp: loadingGateRamp,
      loadingSequence: loadingSequence,
      assistant3Name: assistant3Name,
      assistant3LastName: assistant3LastName,
      assistant4Name: assistant4Name,
      assistant4LastName: assistant4LastName,
      assistant5Name: assistant5Name,
      assistant5LastName: assistant5LastName,
      assistant6Name: assistant6Name,
      assistant6LastName: assistant6LastName,
      loadingType2: loadingType2,
      availability: availability,
      damageMark: damageMark,
      warehouse: warehouse,
      quantityAvailable: quantityAvailable,
      good: good,
      goodDescription: goodDescription,
      packaging: packaging,
      client: client,
      custom: custom,
      createdAt2: createdAt2,
      etaDate2: etaDate2,
      etaI2: etaI2,
      etaF2: etaF2,
      arrival2: arrival2,
      start2: start2,
      stop2: stop2,
      admin: admin,
      assistant1: assistant1,
      assistant2: assistant2,
      assistant3: assistant3,
      assistant4: assistant4,
      assistant5: assistant5,
      assistant6: assistant6,
      associatedOrder: associatedOrder,
      warehousePositionName: warehousePositionName,
      taricCode: taricCode,
      customsPercentage: customsPercentage,
      euroOrDolar: euroOrDolar,
      exchangeRateUsed: exchangeRateUsed,
      initCost: initCost,
      exchangedCost: exchangedCost,
      valuePerUnit: valuePerUnit,
      customPercentagePerCost: customPercentagePerCost,
      acumulatedCustomsPercentages: acumulatedCustomsPercentages,
      currentCustomsWarranty: currentCustomsWarranty,
      remainingCustomsThreshold: remainingCustomsThreshold,
      euros: euros,
      dolars: dolars,
      weightBalance: weightBalance,
      unit: unit,
      responsible: responsible,
      loadingGate: loadingGate,
      groupConsumedThreshold: groupConsumedThreshold,
    );
