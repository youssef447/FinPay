import 'dart:io';

import 'package:http/http.dart';

import '../../config/end_points.dart';
import '../../config/services/remote/http_helper.dart';
import '../../core/utils/globales.dart';

class TradeService {
  Future<Response> getTrades({Map<String, dynamic>? body}) async {
    final response = await HttpHelper.getData(
      query: body,
      endPointUrl: '${ApiEndPoints.tradingEndPoint}/trading.php',
      userToken: currentUser.token,
    );
    return response;
  }

    Future<Response> exchangeTradement({Map<String, dynamic>? body}) async {
    final response = await HttpHelper.postData(
      data: body,
      endPointUrl: '${ApiEndPoints.tradingEndPoint}/exchange-money.php',
      userToken: currentUser.token,
    );
    return response;
  }

  ///trader_image,trader_name
  Future<Response> joinAsTrader({required String traderName, File? img}) async {
    return await HttpHelper.multiFileReqPost(
      traderName: traderName,
      imageFile: img,
      endPointUrl: '${ApiEndPoints.tradingEndPoint}/join-as-trader.php',
      userToken: currentUser.token,
    );
  }

  ///from_wallet ,to_wallet,exchange_rate
  Future<Response> addTradeService({required Map<String, dynamic> body}) async {
    final response = await HttpHelper.postData(
      data: body,
      endPointUrl: '${ApiEndPoints.tradingEndPoint}/add-trade-service.php',
      userToken: currentUser.token,
    );
    return response;
  }

  ///query id which is alose trade_service_id:

  Future<Response> editTradeService({
    required Map<String, dynamic> body,
    required Map<String, dynamic> query,
  }) async {
    final response = await HttpHelper.postData(
      query: query,
      data: body,
      endPointUrl: '${ApiEndPoints.tradingEndPoint}/edit-trade-service.php',
      userToken: currentUser.token,
    );
    return response;
  }

   ///query trade_service_id:
  Future<Response> deleteTradeService(
      {required Map<String, dynamic> body}) async {
    final response = await HttpHelper.postData(
      query: body,
      endPointUrl: '${ApiEndPoints.tradingEndPoint}/delete-trade-service.php',
      userToken: currentUser.token,
    );
    return response;
  } 

  ///query trade_service_id:
  Future<Response> dactivateTradeService(
      {required Map<String, dynamic> body}) async {
    final response = await HttpHelper.postData(
      query: body,
      endPointUrl:
          '${ApiEndPoints.tradingEndPoint}/deactivate-trade-service.php',
      userToken: currentUser.token,
    );
    return response;
  }

  ///query trade_service_id:
  Future<Response> activateTradeService(
      {required Map<String, dynamic> body}) async {
    final response = await HttpHelper.postData(
      query: body,
      endPointUrl: '${ApiEndPoints.tradingEndPoint}/activate-trade-service.php',
      userToken: currentUser.token,
    );
    return response;
  }

  Future<Response> activateAll() async {
    final response = await HttpHelper.postData(
      endPointUrl:
          '${ApiEndPoints.tradingEndPoint}/activate-all-trade-service.php',
      userToken: currentUser.token,
    );
    return response;
  }

  Future<Response> deactivateAll() async {
    final response = await HttpHelper.postData(
      endPointUrl:
          '${ApiEndPoints.tradingEndPoint}/deactivate-all-trade-service.php',
      userToken: currentUser.token,
    );
    return response;
  }

}
