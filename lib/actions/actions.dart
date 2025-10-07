import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/actions/actions.dart' as action_blocks;
import 'package:flutter/material.dart';

Future startingPage(BuildContext context) async {
  ApiCallResponse? apiCustomsOP;
  ApiCallResponse? apiWarehousesOP;
  ApiCallResponse? apiGoodsOP;

  await Future.wait([
    Future(() async {
      apiCustomsOP = await TablesGroup.customsCall.call(
        userToken: currentJwtToken,
      );

      if ((apiCustomsOP?.succeeded ?? true)) {
        FFAppState().customList = TablesGroup.customsCall
            .customName(
              (apiCustomsOP?.jsonBody ?? ''),
            )!
            .toList()
            .cast<String>();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Customs API call problem.',
              style: TextStyle(),
            ),
            duration: Duration(milliseconds: 4000),
            backgroundColor: FlutterFlowTheme.of(context).secondary,
          ),
        );
      }
    }),
    Future(() async {
      apiWarehousesOP = await TablesGroup.warehouseCall.call(
        userToken: currentJwtToken,
      );

      if ((apiWarehousesOP?.succeeded ?? true)) {
        FFAppState().warehouseList = TablesGroup.warehouseCall
            .warehouseName(
              (apiWarehousesOP?.jsonBody ?? ''),
            )!
            .toList()
            .cast<String>();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Warehouse API call problem.',
              style: TextStyle(),
            ),
            duration: Duration(milliseconds: 4000),
            backgroundColor: FlutterFlowTheme.of(context).secondary,
          ),
        );
      }
    }),
    Future(() async {
      apiGoodsOP = await TablesGroup.goodsCall.call(
        userToken: currentJwtToken,
      );

      if ((apiGoodsOP?.succeeded ?? true)) {
        FFAppState().goodsList = TablesGroup.goodsCall
            .item(
              (apiGoodsOP?.jsonBody ?? ''),
            )!
            .toList()
            .cast<String>();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Goods API call problem.',
              style: TextStyle(),
            ),
            duration: Duration(milliseconds: 4000),
            backgroundColor: FlutterFlowTheme.of(context).secondary,
          ),
        );
      }
    }),
    Future(() async {
      await action_blocks.goodDescriptionApiAction(context);
    }),
    Future(() async {
      await action_blocks.clientApiAction(context);
    }),
    Future(() async {
      await action_blocks.packagingAction(context);
    }),
  ]);
}

Future orderWarehouseAction(BuildContext context) async {
  ApiCallResponse? orderWarehouseApiOP;

  orderWarehouseApiOP = await TablesGroup.orderWarehouseTCall.call(
    orderWarehouseV: () {
      if ((getCurrentRoute(context) == '/orderWarehouse') ||
          (getCurrentRoute(context) == '/')) {
        return FFAppState().orderWarehouseApiV;
      } else if (getCurrentRoute(context) == '/warehouse2') {
        return FFAppState().warehouse2ApiV;
      } else if (getCurrentRoute(context) == '/customs') {
        return FFAppState().customsApiV;
      } else if (getCurrentRoute(context) == '/calendar') {
        return FFAppState().calendarApiV;
      } else if (getCurrentRoute(context) == '/reports') {
        return FFAppState().reportsApiV;
      } else {
        return FFAppState().orderWarehouseApiV;
      }
    }(),
    userToken: currentJwtToken,
  );

  if ((orderWarehouseApiOP.succeeded ?? true)) {
    if ((getCurrentRoute(context) == '/orderWarehouse') ||
        (getCurrentRoute(context) == '/')) {
      final jsonBody = orderWarehouseApiOP.jsonBody;
      if (jsonBody != null && jsonBody is List && jsonBody.isNotEmpty) {
        FFAppState().orderWarehouseAS = ((jsonBody)
                .toList()
                .map<OrderWarehouseRowStruct?>(
                    OrderWarehouseRowStruct.maybeFromMap)
                .toList() as Iterable<OrderWarehouseRowStruct?>)
            .withoutNulls
            .toList()
            .cast<OrderWarehouseRowStruct>();
        FFAppState().orderWarehouseApiOPJsonList =
            jsonBody.toList().cast<dynamic>();
        FFAppState().update(() {});
      }
    } else if (getCurrentRoute(context) == '/warehouse2') {
      final jsonBody = orderWarehouseApiOP.jsonBody;
      if (jsonBody != null && jsonBody is List && jsonBody.isNotEmpty) {
        FFAppState().orderWarehouseAS = ((jsonBody)
                .toList()
                .map<OrderWarehouseRowStruct?>(
                    OrderWarehouseRowStruct.maybeFromMap)
                .toList() as Iterable<OrderWarehouseRowStruct?>)
            .withoutNulls
            .toList()
            .cast<OrderWarehouseRowStruct>();
        FFAppState().warehouse2ApiOPJsonList =
            jsonBody.toList().cast<dynamic>();
        FFAppState().update(() {});
      }
    } else if (getCurrentRoute(context) == '/customs') {
      final jsonBody = orderWarehouseApiOP.jsonBody;
      if (jsonBody != null && jsonBody is List && jsonBody.isNotEmpty) {
        FFAppState().orderWarehouseAS = ((jsonBody)
                .toList()
                .map<OrderWarehouseRowStruct?>(
                    OrderWarehouseRowStruct.maybeFromMap)
                .toList() as Iterable<OrderWarehouseRowStruct?>)
            .withoutNulls
            .toList()
            .cast<OrderWarehouseRowStruct>();
        FFAppState().customsApiOPJsonList = jsonBody.toList().cast<dynamic>();
        FFAppState().update(() {});
      }
    } else if (getCurrentRoute(context) == '/calendar') {
      final jsonBody = orderWarehouseApiOP.jsonBody;
      if (jsonBody != null && jsonBody is List && jsonBody.isNotEmpty) {
        FFAppState().orderWarehouseAS = ((jsonBody)
                .toList()
                .map<OrderWarehouseRowStruct?>(
                    OrderWarehouseRowStruct.maybeFromMap)
                .toList() as Iterable<OrderWarehouseRowStruct?>)
            .withoutNulls
            .toList()
            .cast<OrderWarehouseRowStruct>();
        FFAppState().calendarApiOPJsonList = jsonBody.toList().cast<dynamic>();
        FFAppState().update(() {});
      }
    } else if (getCurrentRoute(context) == '/reports') {
      final jsonBody = orderWarehouseApiOP.jsonBody;
      if (jsonBody != null && jsonBody is List && jsonBody.isNotEmpty) {
        FFAppState().orderWarehouseAS = ((jsonBody)
                .toList()
                .map<OrderWarehouseRowStruct?>(
                    OrderWarehouseRowStruct.maybeFromMap)
                .toList() as Iterable<OrderWarehouseRowStruct?>)
            .withoutNulls
            .toList()
            .cast<OrderWarehouseRowStruct>();
        FFAppState().reportsApiOPJsonList = jsonBody.toList().cast<dynamic>();
        FFAppState().update(() {});
      }
    }
  }
}

Future goodDescriptionApiAction(BuildContext context) async {
  ApiCallResponse? apiGoodDescriptionsOP;

  apiGoodDescriptionsOP = await TablesGroup.goodDescriptionsCall.call(
    goodDescriptionV: FFAppState().goodDescriptionApiV,
    userToken: currentJwtToken,
  );

  if ((apiGoodDescriptionsOP.succeeded ?? true)) {
    FFAppState().goodDescriptionList = ((apiGoodDescriptionsOP.jsonBody ?? '')
            .toList()
            .map<GoodDescriptionRowStruct?>(
                GoodDescriptionRowStruct.maybeFromMap)
            .toList() as Iterable<GoodDescriptionRowStruct?>)
        .withoutNulls
        .toList()
        .cast<GoodDescriptionRowStruct>();
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Good descriptions API call problem.',
          style: TextStyle(),
        ),
        duration: Duration(milliseconds: 4000),
        backgroundColor: FlutterFlowTheme.of(context).secondary,
      ),
    );
  }
}

Future clientApiAction(BuildContext context) async {
  ApiCallResponse? apiClientOP;

  apiClientOP = await TablesGroup.clientsCall.call(
    clientV: FFAppState().clientApiV,
    userToken: currentJwtToken,
  );

  if ((apiClientOP.succeeded ?? true)) {
    FFAppState().clientList = ((apiClientOP.jsonBody ?? '')
            .toList()
            .map<ClientRowStruct?>(ClientRowStruct.maybeFromMap)
            .toList() as Iterable<ClientRowStruct?>)
        .withoutNulls
        .toList()
        .cast<ClientRowStruct>();
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Client API call problem.',
          style: TextStyle(),
        ),
        duration: Duration(milliseconds: 4000),
        backgroundColor: FlutterFlowTheme.of(context).secondary,
      ),
    );
  }
}

Future packagingAction(BuildContext context) async {
  ApiCallResponse? packagingApiOP;

  packagingApiOP = await TablesGroup.packagingCall.call(
    userToken: currentJwtToken,
  );

  if ((packagingApiOP.succeeded ?? true)) {
    FFAppState().packagingList = ((packagingApiOP.jsonBody ?? '')
            .toList()
            .map<PackaingRowStruct?>(PackaingRowStruct.maybeFromMap)
            .toList() as Iterable<PackaingRowStruct?>)
        .withoutNulls
        .map((e) => e.packaging)
        .toList()
        .toList()
        .cast<String>();
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Packaging API call problem.',
          style: TextStyle(),
        ),
        duration: Duration(milliseconds: 4000),
        backgroundColor: FlutterFlowTheme.of(context).secondary,
      ),
    );
  }
}

Future actionLenguage(BuildContext context) async {
  FFAppState().language = FFLocalizations.of(context).getVariableText(
    enText: 'en',
    slText: 'sl',
    esText: 'es',
  );
}

Future exchangeTypeBlock(BuildContext context) async {
  ApiCallResponse? euroToDolarApiOP;

  euroToDolarApiOP = await EuroToDolarCall.call();

  if ((euroToDolarApiOP.succeeded ?? true)) {
    FFAppState().todayExchangeType = valueOrDefault<double>(
      EuroToDolarCall.exchangeType(
        (euroToDolarApiOP.jsonBody ?? ''),
      ),
      0.0,
    );
  }
}
