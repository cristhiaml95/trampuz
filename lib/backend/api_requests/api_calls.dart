import 'dart:convert';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start tables Group Code

class TablesGroup {
  static String getBaseUrl({
    String? userToken = '',
  }) =>
      'https://xvpkpgmwllqgytdtlnts.supabase.co/rest/v1/';
  static Map<String, String> headers = {
    'apikey':
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh2cGtwZ213bGxxZ3l0ZHRsbnRzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDU3MDM0NTQsImV4cCI6MjAyMTI3OTQ1NH0.DPS7em_M28tXdHs4wN7AW_DHUKXqLIrSnjbMsnFNDzI',
    'Authorization': 'Bearer [userToken]',
  };
  static ClientsCall clientsCall = ClientsCall();
  static OrderNoCall orderNoCall = OrderNoCall();
  static OrderWarehouseTCall orderWarehouseTCall = OrderWarehouseTCall();
  static WarehouseCall warehouseCall = WarehouseCall();
  static CustomsCall customsCall = CustomsCall();
  static GoodsCall goodsCall = GoodsCall();
  static GoodDescriptionsCall goodDescriptionsCall = GoodDescriptionsCall();
  static UsersCall usersCall = UsersCall();
  static DetailsCall detailsCall = DetailsCall();
  static PackagingCall packagingCall = PackagingCall();
  static ManipulationCall manipulationCall = ManipulationCall();
  static RefreshOrderLevelCalculatedColumnsCall
      refreshOrderLevelCalculatedColumnsCall =
      RefreshOrderLevelCalculatedColumnsCall();
  static DetailsViewCall detailsViewCall = DetailsViewCall();
}

class ClientsCall {
  Future<ApiCallResponse> call({
    String? clientV = '',
    String? userToken = '',
  }) async {
    final baseUrl = TablesGroup.getBaseUrl(
      userToken: userToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'clients',
      apiUrl: '${baseUrl}clients?select=id,client&client=ilike.*${clientV}*',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh2cGtwZ213bGxxZ3l0ZHRsbnRzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDU3MDM0NTQsImV4cCI6MjAyMTI3OTQ1NH0.DPS7em_M28tXdHs4wN7AW_DHUKXqLIrSnjbMsnFNDzI',
        'Authorization': 'Bearer ${userToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? clientId(dynamic response) => (getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? clientName(dynamic response) => (getJsonField(
        response,
        r'''$[:].client''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class OrderNoCall {
  Future<ApiCallResponse> call({
    String? orderNoV = 'order=crono.desc.nullslast',
    String? userToken = '',
  }) async {
    final baseUrl = TablesGroup.getBaseUrl(
      userToken: userToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'orderNo',
      apiUrl:
          '${baseUrl}order_level?select=order_no,licence_plate,pallet_position,universal_ref_no,fms_ref,load_ref_dvh,internal_ref_custom,container_no&${orderNoV}',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh2cGtwZ213bGxxZ3l0ZHRsbnRzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDU3MDM0NTQsImV4cCI6MjAyMTI3OTQ1NH0.DPS7em_M28tXdHs4wN7AW_DHUKXqLIrSnjbMsnFNDzI',
        'Authorization': 'Bearer ${userToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? orderNo(dynamic response) => (getJsonField(
        response,
        r'''$[:].order_no''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? licence(dynamic response) => (getJsonField(
        response,
        r'''$[:].licence_plate''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<double>? palletPosition(dynamic response) => (getJsonField(
        response,
        r'''$[:].pallet_position''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();
  List<String>? uniRefNo(dynamic response) => (getJsonField(
        response,
        r'''$[:].universal_ref_no''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? fmsRef(dynamic response) => (getJsonField(
        response,
        r'''$[:].fms_ref''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? loadRefDvh(dynamic response) => (getJsonField(
        response,
        r'''$[:].load_ref_dvh''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? internalRefCustom(dynamic response) => (getJsonField(
        response,
        r'''$[:].internal_ref_custom''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? container(dynamic response) => (getJsonField(
        response,
        r'''$[:].container_no''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class OrderWarehouseTCall {
  Future<ApiCallResponse> call({
    String? orderWarehouseV =
        'is_deleted=eq.false&availability=neq.consumed&order=crono.desc.nullslast&limit=50',
    String? userToken = '',
  }) async {
    final baseUrl = TablesGroup.getBaseUrl(
      userToken: userToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'orderWarehouseT',
      apiUrl:
          '${baseUrl}order_level?select=order_no,client_name,inv_status,acepted,precheck,checked,warehouse_name,order_status,eta_date,flow,licence_plate,improvement,container_no,quantity,packaging_name,weight,pallet_position,universal_ref_no,fms_ref,load_ref_dvh,custom_name,internal_ref_custom,comment,documents,item,opis_blaga,loading_type,other_manipulation,responsible_name,responsible_last_name,assistant1_name,assistant1_last_name,assistant2_name,assistant2_last_name,admin_name,admin_last_name,internal_accounting,details,loading_gate_ramp,loading_sequence,assistant3_name,assistant3_last_name,assistant4_name,assistant4_last_name,assistant5_name,assistant5_last_name,assistant6_name,assistant6_last_name,loading_type2,associated_orders,no_barcodes,repeated_barcodes,availability,damage_mark,id,warehouse,quantity_available,barcodes,good,good_description,packaging,client,custom,eta_date2,eta_i2,eta_i,eta_f2,eta_f,arrival2,start2,stop2,created_at2,admin,assistant1,assistant2,assistant3,assistant4,assistant5,assistant6,associated_order,taric_code,customs_percentage,euro_or_dolar,exchange_rate_used,init_cost,exchanged_cost,value_per_unit,custom_percentage_per_cost,acumulated_customs_percentages,current_customs_warranty,remaining_customs_threshold,euros,dolars,weight_balance,warehouse_position_name,loading_gate,responsible,unit,group_consumed_threshold&${orderWarehouseV}',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh2cGtwZ213bGxxZ3l0ZHRsbnRzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDU3MDM0NTQsImV4cCI6MjAyMTI3OTQ1NH0.DPS7em_M28tXdHs4wN7AW_DHUKXqLIrSnjbMsnFNDzI',
        'Authorization': 'Bearer ${userToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? orderNo(dynamic response) => (getJsonField(
        response,
        r'''$[:].order_no''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? licence(dynamic response) => (getJsonField(
        response,
        r'''$[:].licence_plate''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<double>? palletPosition(dynamic response) => (getJsonField(
        response,
        r'''$[:].pallet_position''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();
  List<String>? uniRefNo(dynamic response) => (getJsonField(
        response,
        r'''$[:].universal_ref_no''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? fmsRef(dynamic response) => (getJsonField(
        response,
        r'''$[:].fms_ref''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? loadRefDvh(dynamic response) => (getJsonField(
        response,
        r'''$[:].load_ref_dvh''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? internalRefCustom(dynamic response) => (getJsonField(
        response,
        r'''$[:].internal_ref_custom''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? container(dynamic response) => (getJsonField(
        response,
        r'''$[:].container_no''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? clientName(dynamic response) => (getJsonField(
        response,
        r'''$[:].client_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? invStatus(dynamic response) => (getJsonField(
        response,
        r'''$[:].inv_status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<bool>? acepted(dynamic response) => (getJsonField(
        response,
        r'''$[:].acepted''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  List<bool>? precheck(dynamic response) => (getJsonField(
        response,
        r'''$[:].precheck''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  List<String>? warehouseName(dynamic response) => (getJsonField(
        response,
        r'''$[:].warehouse_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<bool>? checked(dynamic response) => (getJsonField(
        response,
        r'''$[:].checked''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  List<String>? orderStatus(dynamic response) => (getJsonField(
        response,
        r'''$[:].order_status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? etaDate(dynamic response) => (getJsonField(
        response,
        r'''$[:].eta_date''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? flow(dynamic response) => (getJsonField(
        response,
        r'''$[:].flow''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? improvement(dynamic response) => (getJsonField(
        response,
        r'''$[:].improvement''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? quantity(dynamic response) => (getJsonField(
        response,
        r'''$[:].quantity''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? packagingName(dynamic response) => (getJsonField(
        response,
        r'''$[:].packaging_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? weight(dynamic response) => (getJsonField(
        response,
        r'''$[:].weight''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? customName(dynamic response) => (getJsonField(
        response,
        r'''$[:].custom_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? comment(dynamic response) => (getJsonField(
        response,
        r'''$[:].comment''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List? documents(dynamic response) => getJsonField(
        response,
        r'''$[:].documents''',
        true,
      ) as List?;
  List<String>? item(dynamic response) => (getJsonField(
        response,
        r'''$[:].item''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? opisBlaga(dynamic response) => (getJsonField(
        response,
        r'''$[:].opis_blaga''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? loadingType(dynamic response) => (getJsonField(
        response,
        r'''$[:].loading_type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? otherManipulation(dynamic response) => (getJsonField(
        response,
        r'''$[:].other_manipulation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? responsibleName(dynamic response) => (getJsonField(
        response,
        r'''$[:].responsible_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? responsibleLastName(dynamic response) => (getJsonField(
        response,
        r'''$[:].responsible_last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? assistant1Name(dynamic response) => (getJsonField(
        response,
        r'''$[:].assistant1_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? assistant1LastName(dynamic response) => (getJsonField(
        response,
        r'''$[:].assistant1_last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? assistant2Name(dynamic response) => (getJsonField(
        response,
        r'''$[:].assistant2_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? assistant2LastName(dynamic response) => (getJsonField(
        response,
        r'''$[:].assistant2_last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? adminName(dynamic response) => (getJsonField(
        response,
        r'''$[:].admin_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? adminLastName(dynamic response) => (getJsonField(
        response,
        r'''$[:].admin_last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? internalAccounting(dynamic response) => (getJsonField(
        response,
        r'''$[:].internal_accounting''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? details(dynamic response) => (getJsonField(
        response,
        r'''$[:].details''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? loadingGateRamp(dynamic response) => (getJsonField(
        response,
        r'''$[:].loading_gate_ramp''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? loadingSequence(dynamic response) => (getJsonField(
        response,
        r'''$[:].loading_sequence''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List<String>? assistant3Name(dynamic response) => (getJsonField(
        response,
        r'''$[:].assistant3_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? assistant3LastName(dynamic response) => (getJsonField(
        response,
        r'''$[:].assistant3_last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? assistant4Name(dynamic response) => (getJsonField(
        response,
        r'''$[:].assistant4_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? assistant4LastName(dynamic response) => (getJsonField(
        response,
        r'''$[:].assistant4_last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? assistant5Name(dynamic response) => (getJsonField(
        response,
        r'''$[:].assistant5_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? assistant5LastName(dynamic response) => (getJsonField(
        response,
        r'''$[:].assistant5_last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? assistant6Name(dynamic response) => (getJsonField(
        response,
        r'''$[:].assistant6_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? assistant6LastName(dynamic response) => (getJsonField(
        response,
        r'''$[:].assistant6_last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? loadingType2(dynamic response) => (getJsonField(
        response,
        r'''$[:].loading_type2''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List? associatedOrders(dynamic response) => getJsonField(
        response,
        r'''$[:].associated_orders''',
        true,
      ) as List?;
  List? noBarcodes(dynamic response) => getJsonField(
        response,
        r'''$[:].no_barcodes''',
        true,
      ) as List?;
  List? repeatedBarcodes(dynamic response) => getJsonField(
        response,
        r'''$[:].repeated_barcodes''',
        true,
      ) as List?;
  List<String>? availability(dynamic response) => (getJsonField(
        response,
        r'''$[:].availability''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? damageMark(dynamic response) => (getJsonField(
        response,
        r'''$[:].damage_mark''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? id(dynamic response) => (getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? warehouse(dynamic response) => (getJsonField(
        response,
        r'''$[:].warehouse''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<int>? quantityAvailable(dynamic response) => (getJsonField(
        response,
        r'''$[:].quantity_available''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  List? barcodes(dynamic response) => getJsonField(
        response,
        r'''$[:].barcodes''',
        true,
      ) as List?;
  List<String>? good(dynamic response) => (getJsonField(
        response,
        r'''$[:].good''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? goodDescription(dynamic response) => (getJsonField(
        response,
        r'''$[:].good_description''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? packaging(dynamic response) => (getJsonField(
        response,
        r'''$[:].packaging''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? client(dynamic response) => (getJsonField(
        response,
        r'''$[:].client''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? custom(dynamic response) => (getJsonField(
        response,
        r'''$[:].custom''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class WarehouseCall {
  Future<ApiCallResponse> call({
    String? userToken = '',
  }) async {
    final baseUrl = TablesGroup.getBaseUrl(
      userToken: userToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'warehouse',
      apiUrl: '${baseUrl}warehouses?select=id,warehouse',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh2cGtwZ213bGxxZ3l0ZHRsbnRzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDU3MDM0NTQsImV4cCI6MjAyMTI3OTQ1NH0.DPS7em_M28tXdHs4wN7AW_DHUKXqLIrSnjbMsnFNDzI',
        'Authorization': 'Bearer ${userToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? warehouseId(dynamic response) => (getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? warehouseName(dynamic response) => (getJsonField(
        response,
        r'''$[:].warehouse''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class CustomsCall {
  Future<ApiCallResponse> call({
    String? userToken = '',
  }) async {
    final baseUrl = TablesGroup.getBaseUrl(
      userToken: userToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'customs',
      apiUrl: '${baseUrl}customs?select=id,custom',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh2cGtwZ213bGxxZ3l0ZHRsbnRzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDU3MDM0NTQsImV4cCI6MjAyMTI3OTQ1NH0.DPS7em_M28tXdHs4wN7AW_DHUKXqLIrSnjbMsnFNDzI',
        'Authorization': 'Bearer ${userToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? customId(dynamic response) => (getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? customName(dynamic response) => (getJsonField(
        response,
        r'''$[:].custom''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GoodsCall {
  Future<ApiCallResponse> call({
    String? userToken = '',
  }) async {
    final baseUrl = TablesGroup.getBaseUrl(
      userToken: userToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'goods',
      apiUrl: '${baseUrl}goods?select=id,item',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh2cGtwZ213bGxxZ3l0ZHRsbnRzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDU3MDM0NTQsImV4cCI6MjAyMTI3OTQ1NH0.DPS7em_M28tXdHs4wN7AW_DHUKXqLIrSnjbMsnFNDzI',
        'Authorization': 'Bearer ${userToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? customId(dynamic response) => (getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? item(dynamic response) => (getJsonField(
        response,
        r'''$[:].item''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GoodDescriptionsCall {
  Future<ApiCallResponse> call({
    String? goodDescriptionV = '',
    String? userToken = '',
  }) async {
    final baseUrl = TablesGroup.getBaseUrl(
      userToken: userToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'goodDescriptions',
      apiUrl:
          '${baseUrl}good_descriptions?select=id,opis_blaga&opis_blaga=ilike.*${goodDescriptionV}*',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh2cGtwZ213bGxxZ3l0ZHRsbnRzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDU3MDM0NTQsImV4cCI6MjAyMTI3OTQ1NH0.DPS7em_M28tXdHs4wN7AW_DHUKXqLIrSnjbMsnFNDzI',
        'Authorization': 'Bearer ${userToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UsersCall {
  Future<ApiCallResponse> call({
    String? userToken = '',
  }) async {
    final baseUrl = TablesGroup.getBaseUrl(
      userToken: userToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'users',
      apiUrl: '${baseUrl}users?select=id,email,name,last_name',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh2cGtwZ213bGxxZ3l0ZHRsbnRzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDU3MDM0NTQsImV4cCI6MjAyMTI3OTQ1NH0.DPS7em_M28tXdHs4wN7AW_DHUKXqLIrSnjbMsnFNDzI',
        'Authorization': 'Bearer ${userToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? userId(dynamic response) => (getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? email(dynamic response) => (getJsonField(
        response,
        r'''$[:].email''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? name(dynamic response) => (getJsonField(
        response,
        r'''$[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? lastName(dynamic response) => (getJsonField(
        response,
        r'''$[:].last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class DetailsCall {
  Future<ApiCallResponse> call({
    String? detailsV = 'order=created_at.asc',
    String? userToken = '',
  }) async {
    final baseUrl = TablesGroup.getBaseUrl(
      userToken: userToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'details',
      apiUrl:
          '${baseUrl}details_view?select=barcode_out,barcode,order_id,id&${detailsV}',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh2cGtwZ213bGxxZ3l0ZHRsbnRzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDU3MDM0NTQsImV4cCI6MjAyMTI3OTQ1NH0.DPS7em_M28tXdHs4wN7AW_DHUKXqLIrSnjbMsnFNDzI',
        'Authorization': 'Bearer ${userToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? barcodeOut(dynamic response) => (getJsonField(
        response,
        r'''$[:].barcode_out''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? barcode(dynamic response) => (getJsonField(
        response,
        r'''$[:].barcode''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class PackagingCall {
  Future<ApiCallResponse> call({
    String? userToken = '',
  }) async {
    final baseUrl = TablesGroup.getBaseUrl(
      userToken: userToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'packaging',
      apiUrl: '${baseUrl}packaging?select=id,packaging',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh2cGtwZ213bGxxZ3l0ZHRsbnRzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDU3MDM0NTQsImV4cCI6MjAyMTI3OTQ1NH0.DPS7em_M28tXdHs4wN7AW_DHUKXqLIrSnjbMsnFNDzI',
        'Authorization': 'Bearer ${userToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? packagingName(dynamic response) => (getJsonField(
        response,
        r'''$[:].packaging''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class ManipulationCall {
  Future<ApiCallResponse> call({
    String? userToken = '',
  }) async {
    final baseUrl = TablesGroup.getBaseUrl(
      userToken: userToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'manipulation',
      apiUrl: '${baseUrl}manipulations?select=id,manipulation',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh2cGtwZ213bGxxZ3l0ZHRsbnRzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDU3MDM0NTQsImV4cCI6MjAyMTI3OTQ1NH0.DPS7em_M28tXdHs4wN7AW_DHUKXqLIrSnjbMsnFNDzI',
        'Authorization': 'Bearer ${userToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? manipulation(dynamic response) => (getJsonField(
        response,
        r'''$[:].manipulation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class RefreshOrderLevelCalculatedColumnsCall {
  Future<ApiCallResponse> call({
    String? rowId = '',
    String? userToken = '',
  }) async {
    final baseUrl = TablesGroup.getBaseUrl(
      userToken: userToken,
    );

    final ffApiRequestBody = '''
{
  "row_id": "${rowId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'refreshOrderLevelCalculatedColumns',
      apiUrl: '${baseUrl}rpc/refresh_order_level_calculated_columns_v2',
      callType: ApiCallType.POST,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh2cGtwZ213bGxxZ3l0ZHRsbnRzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDU3MDM0NTQsImV4cCI6MjAyMTI3OTQ1NH0.DPS7em_M28tXdHs4wN7AW_DHUKXqLIrSnjbMsnFNDzI',
        'Authorization': 'Bearer ${userToken}',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DetailsViewCall {
  Future<ApiCallResponse> call({
    String? orderId = '',
    String? userToken = '',
  }) async {
    final baseUrl = TablesGroup.getBaseUrl(
      userToken: userToken,
    );

    return ApiManager.instance.makeApiCall(
      callName: 'detailsView',
      apiUrl: '${baseUrl}details_view?select=*&order_id=eq.${orderId}',
      callType: ApiCallType.GET,
      headers: {
        'apikey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh2cGtwZ213bGxxZ3l0ZHRsbnRzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDU3MDM0NTQsImV4cCI6MjAyMTI3OTQ1NH0.DPS7em_M28tXdHs4wN7AW_DHUKXqLIrSnjbMsnFNDzI',
        'Authorization': 'Bearer ${userToken}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End tables Group Code

class EuroToDolarCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'euroToDolar',
      apiUrl:
          'https://xvpkpgmwllqgytdtlnts.supabase.co/functions/v1/exchange-rate',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static double? exchangeType(dynamic response) =>
      castToType<double>(getJsonField(
        response,
        r'''$.data[:].value''',
      ));
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
