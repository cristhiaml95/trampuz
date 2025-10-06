import '../database.dart';

class VistaOrderLevelExtendedTable
    extends SupabaseTable<VistaOrderLevelExtendedRow> {
  @override
  String get tableName => 'vista_order_level_extended';

  @override
  VistaOrderLevelExtendedRow createRow(Map<String, dynamic> data) =>
      VistaOrderLevelExtendedRow(data);
}

class VistaOrderLevelExtendedRow extends SupabaseDataRow {
  VistaOrderLevelExtendedRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => VistaOrderLevelExtendedTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get createdAt2 => getField<String>('created_at2');
  set createdAt2(String? value) => setField<String>('created_at2', value);

  String? get invStatus => getField<String>('inv_status');
  set invStatus(String? value) => setField<String>('inv_status', value);

  String? get orderNo => getField<String>('order_no');
  set orderNo(String? value) => setField<String>('order_no', value);

  String? get flow => getField<String>('flow');
  set flow(String? value) => setField<String>('flow', value);

  String? get orderStatus => getField<String>('order_status');
  set orderStatus(String? value) => setField<String>('order_status', value);

  String? get admin => getField<String>('admin');
  set admin(String? value) => setField<String>('admin', value);

  String? get warehouse => getField<String>('warehouse');
  set warehouse(String? value) => setField<String>('warehouse', value);

  DateTime? get etaDate => getField<DateTime>('eta_date');
  set etaDate(DateTime? value) => setField<DateTime>('eta_date', value);

  PostgresTime? get etaI => getField<PostgresTime>('eta_i');
  set etaI(PostgresTime? value) => setField<PostgresTime>('eta_i', value);

  PostgresTime? get etaF => getField<PostgresTime>('eta_f');
  set etaF(PostgresTime? value) => setField<PostgresTime>('eta_f', value);

  PostgresTime? get arrival => getField<PostgresTime>('arrival');
  set arrival(PostgresTime? value) => setField<PostgresTime>('arrival', value);

  PostgresTime? get start => getField<PostgresTime>('start');
  set start(PostgresTime? value) => setField<PostgresTime>('start', value);

  PostgresTime? get stop => getField<PostgresTime>('stop');
  set stop(PostgresTime? value) => setField<PostgresTime>('stop', value);

  String? get etaDate2 => getField<String>('eta_date2');
  set etaDate2(String? value) => setField<String>('eta_date2', value);

  String? get etaI2 => getField<String>('eta_i2');
  set etaI2(String? value) => setField<String>('eta_i2', value);

  String? get etaF2 => getField<String>('eta_f2');
  set etaF2(String? value) => setField<String>('eta_f2', value);

  String? get arrival2 => getField<String>('arrival2');
  set arrival2(String? value) => setField<String>('arrival2', value);

  String? get start2 => getField<String>('start2');
  set start2(String? value) => setField<String>('start2', value);

  String? get stop2 => getField<String>('stop2');
  set stop2(String? value) => setField<String>('stop2', value);

  String? get loadingGate => getField<String>('loading_gate');
  set loadingGate(String? value) => setField<String>('loading_gate', value);

  int? get loadingSequence => getField<int>('loading_sequence');
  set loadingSequence(int? value) => setField<int>('loading_sequence', value);

  String? get licencePlate => getField<String>('licence_plate');
  set licencePlate(String? value) => setField<String>('licence_plate', value);

  int? get quantity => getField<int>('quantity');
  set quantity(int? value) => setField<int>('quantity', value);

  double? get palletPosition => getField<double>('pallet_position');
  set palletPosition(double? value) =>
      setField<double>('pallet_position', value);

  int? get unit => getField<int>('unit');
  set unit(int? value) => setField<int>('unit', value);

  int? get weight => getField<int>('weight');
  set weight(int? value) => setField<int>('weight', value);

  String? get containerNo => getField<String>('container_no');
  set containerNo(String? value) => setField<String>('container_no', value);

  String? get improvement => getField<String>('improvement');
  set improvement(String? value) => setField<String>('improvement', value);

  String? get custom => getField<String>('custom');
  set custom(String? value) => setField<String>('custom', value);

  String? get responsible => getField<String>('responsible');
  set responsible(String? value) => setField<String>('responsible', value);

  String? get assistant1 => getField<String>('assistant1');
  set assistant1(String? value) => setField<String>('assistant1', value);

  String? get assistant2 => getField<String>('assistant2');
  set assistant2(String? value) => setField<String>('assistant2', value);

  String? get assistant3 => getField<String>('assistant3');
  set assistant3(String? value) => setField<String>('assistant3', value);

  String? get assistant4 => getField<String>('assistant4');
  set assistant4(String? value) => setField<String>('assistant4', value);

  String? get assistant5 => getField<String>('assistant5');
  set assistant5(String? value) => setField<String>('assistant5', value);

  String? get assistant6 => getField<String>('assistant6');
  set assistant6(String? value) => setField<String>('assistant6', value);

  String? get fmsRef => getField<String>('fms_ref');
  set fmsRef(String? value) => setField<String>('fms_ref', value);

  String? get loadRefDvh => getField<String>('load_ref_dvh');
  set loadRefDvh(String? value) => setField<String>('load_ref_dvh', value);

  String? get damageMark => getField<String>('damage_mark');
  set damageMark(String? value) => setField<String>('damage_mark', value);

  String? get universalRefNo => getField<String>('universal_ref_no');
  set universalRefNo(String? value) =>
      setField<String>('universal_ref_no', value);

  String? get comment => getField<String>('comment');
  set comment(String? value) => setField<String>('comment', value);

  String? get otherManipulation => getField<String>('other_manipulation');
  set otherManipulation(String? value) =>
      setField<String>('other_manipulation', value);

  String? get loadingType => getField<String>('loading_type');
  set loadingType(String? value) => setField<String>('loading_type', value);

  String? get loadingType2 => getField<String>('loading_type2');
  set loadingType2(String? value) => setField<String>('loading_type2', value);

  String? get document => getField<String>('document');
  set document(String? value) => setField<String>('document', value);

  String? get internalAccounting => getField<String>('internal_accounting');
  set internalAccounting(String? value) =>
      setField<String>('internal_accounting', value);

  String? get internalRefCustom => getField<String>('internal_ref_custom');
  set internalRefCustom(String? value) =>
      setField<String>('internal_ref_custom', value);

  int? get crono => getField<int>('crono');
  set crono(int? value) => setField<int>('crono', value);

  String? get client => getField<String>('client');
  set client(String? value) => setField<String>('client', value);

  String? get good => getField<String>('good');
  set good(String? value) => setField<String>('good', value);

  String? get goodDescription => getField<String>('good_description');
  set goodDescription(String? value) =>
      setField<String>('good_description', value);

  String? get packaging => getField<String>('packaging');
  set packaging(String? value) => setField<String>('packaging', value);

  List<String> get documents => getListField<String>('documents');
  set documents(List<String>? value) =>
      setListField<String>('documents', value);

  bool? get acepted => getField<bool>('acepted');
  set acepted(bool? value) => setField<bool>('acepted', value);

  bool? get checked => getField<bool>('checked');
  set checked(bool? value) => setField<bool>('checked', value);

  List<String> get barcodes => getListField<String>('barcodes');
  set barcodes(List<String>? value) => setListField<String>('barcodes', value);

  bool? get precheck => getField<bool>('precheck');
  set precheck(bool? value) => setField<bool>('precheck', value);

  List<String> get noBarcodes => getListField<String>('no_barcodes');
  set noBarcodes(List<String>? value) =>
      setListField<String>('no_barcodes', value);

  List<String> get repeatedBarcodes =>
      getListField<String>('repeated_barcodes');
  set repeatedBarcodes(List<String>? value) =>
      setListField<String>('repeated_barcodes', value);

  bool? get isDeleted => getField<bool>('is_deleted');
  set isDeleted(bool? value) => setField<bool>('is_deleted', value);

  DateTime? get deleteDatetime => getField<DateTime>('delete_datetime');
  set deleteDatetime(DateTime? value) =>
      setField<DateTime>('delete_datetime', value);

  String? get deleterUser => getField<String>('deleter_user');
  set deleterUser(String? value) => setField<String>('deleter_user', value);

  double? get quantityAvailable => getField<double>('quantity_available');
  set quantityAvailable(double? value) =>
      setField<double>('quantity_available', value);

  double? get detailsAvailable => getField<double>('details_available');
  set detailsAvailable(double? value) =>
      setField<double>('details_available', value);

  List<String> get associatedOrders =>
      getListField<String>('associated_orders');
  set associatedOrders(List<String>? value) =>
      setListField<String>('associated_orders', value);

  List<String> get associatedOrdersIds =>
      getListField<String>('associated_orders_ids');
  set associatedOrdersIds(List<String>? value) =>
      setListField<String>('associated_orders_ids', value);

  String? get availability => getField<String>('availability');
  set availability(String? value) => setField<String>('availability', value);

  String? get adminName => getField<String>('admin_name');
  set adminName(String? value) => setField<String>('admin_name', value);

  String? get adminLastName => getField<String>('admin_last_name');
  set adminLastName(String? value) =>
      setField<String>('admin_last_name', value);

  String? get adminUserType => getField<String>('admin_user_type');
  set adminUserType(String? value) =>
      setField<String>('admin_user_type', value);

  String? get adminImage => getField<String>('admin_image');
  set adminImage(String? value) => setField<String>('admin_image', value);

  String? get adminEmail => getField<String>('admin_email');
  set adminEmail(String? value) => setField<String>('admin_email', value);

  String? get clientName => getField<String>('client_name');
  set clientName(String? value) => setField<String>('client_name', value);

  String? get clientCity => getField<String>('client_city');
  set clientCity(String? value) => setField<String>('client_city', value);

  String? get clientCountry => getField<String>('client_country');
  set clientCountry(String? value) => setField<String>('client_country', value);

  String? get warehouseName => getField<String>('warehouse_name');
  set warehouseName(String? value) => setField<String>('warehouse_name', value);

  String? get loadingGateRamp => getField<String>('loading_gate_ramp');
  set loadingGateRamp(String? value) =>
      setField<String>('loading_gate_ramp', value);

  String? get customName => getField<String>('custom_name');
  set customName(String? value) => setField<String>('custom_name', value);

  String? get responsibleName => getField<String>('responsible_name');
  set responsibleName(String? value) =>
      setField<String>('responsible_name', value);

  String? get responsibleLastName => getField<String>('responsible_last_name');
  set responsibleLastName(String? value) =>
      setField<String>('responsible_last_name', value);

  String? get assistant1Name => getField<String>('assistant1_name');
  set assistant1Name(String? value) =>
      setField<String>('assistant1_name', value);

  String? get assistant1LastName => getField<String>('assistant1_last_name');
  set assistant1LastName(String? value) =>
      setField<String>('assistant1_last_name', value);

  String? get assistant2Name => getField<String>('assistant2_name');
  set assistant2Name(String? value) =>
      setField<String>('assistant2_name', value);

  String? get assistant2LastName => getField<String>('assistant2_last_name');
  set assistant2LastName(String? value) =>
      setField<String>('assistant2_last_name', value);

  String? get assistant3Name => getField<String>('assistant3_name');
  set assistant3Name(String? value) =>
      setField<String>('assistant3_name', value);

  String? get assistant3LastName => getField<String>('assistant3_last_name');
  set assistant3LastName(String? value) =>
      setField<String>('assistant3_last_name', value);

  String? get assistant4Name => getField<String>('assistant4_name');
  set assistant4Name(String? value) =>
      setField<String>('assistant4_name', value);

  String? get assistant4LastName => getField<String>('assistant4_last_name');
  set assistant4LastName(String? value) =>
      setField<String>('assistant4_last_name', value);

  String? get assistant5Name => getField<String>('assistant5_name');
  set assistant5Name(String? value) =>
      setField<String>('assistant5_name', value);

  String? get assistant5LastName => getField<String>('assistant5_last_name');
  set assistant5LastName(String? value) =>
      setField<String>('assistant5_last_name', value);

  String? get assistant6Name => getField<String>('assistant6_name');
  set assistant6Name(String? value) =>
      setField<String>('assistant6_name', value);

  String? get assistant6LastName => getField<String>('assistant6_last_name');
  set assistant6LastName(String? value) =>
      setField<String>('assistant6_last_name', value);

  String? get item => getField<String>('item');
  set item(String? value) => setField<String>('item', value);

  String? get opisBlaga => getField<String>('opis_blaga');
  set opisBlaga(String? value) => setField<String>('opis_blaga', value);

  String? get packagingName => getField<String>('packaging_name');
  set packagingName(String? value) => setField<String>('packaging_name', value);

  int? get details => getField<int>('details');
  set details(int? value) => setField<int>('details', value);

  List<String> get barcodeList => getListField<String>('barcode_list');
  set barcodeList(List<String>? value) =>
      setListField<String>('barcode_list', value);

  String? get taricCode => getField<String>('taric_code');
  set taricCode(String? value) => setField<String>('taric_code', value);

  double? get exchangedCost => getField<double>('exchanged_cost');
  set exchangedCost(double? value) => setField<double>('exchanged_cost', value);

  double? get valuePerUnit => getField<double>('value_per_unit');
  set valuePerUnit(double? value) => setField<double>('value_per_unit', value);

  double? get customPercentagePerCost =>
      getField<double>('custom_percentage_per_cost');
  set customPercentagePerCost(double? value) =>
      setField<double>('custom_percentage_per_cost', value);

  double? get acumulatedCustomsPercentages =>
      getField<double>('acumulated_customs_percentages');
  set acumulatedCustomsPercentages(double? value) =>
      setField<double>('acumulated_customs_percentages', value);

  double? get remainingCustomsThreshold =>
      getField<double>('remaining_customs_threshold');
  set remainingCustomsThreshold(double? value) =>
      setField<double>('remaining_customs_threshold', value);

  double? get customsPercentage => getField<double>('customs_percentage');
  set customsPercentage(double? value) =>
      setField<double>('customs_percentage', value);

  double? get initCost => getField<double>('init_cost');
  set initCost(double? value) => setField<double>('init_cost', value);

  String? get euroOrDolar => getField<String>('euro_or_dolar');
  set euroOrDolar(String? value) => setField<String>('euro_or_dolar', value);

  double? get exchangeRateUsed => getField<double>('exchange_rate_used');
  set exchangeRateUsed(double? value) =>
      setField<double>('exchange_rate_used', value);

  double? get dolars => getField<double>('dolars');
  set dolars(double? value) => setField<double>('dolars', value);

  double? get euros => getField<double>('euros');
  set euros(double? value) => setField<double>('euros', value);

  double? get currentCustomsWarranty =>
      getField<double>('current_customs_warranty');
  set currentCustomsWarranty(double? value) =>
      setField<double>('current_customs_warranty', value);

  double? get weightBalance => getField<double>('weight_balance');
  set weightBalance(double? value) => setField<double>('weight_balance', value);
}
