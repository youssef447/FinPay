import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../config/error_handler.dart';
import '../data_sources/trade_service.dart';
import '../models/trader_model.dart';

class TraderRepo {
  final TradeService _service;
  TraderRepo({required TradeService service}) : _service = service;

  Future<Either<Failure, String>> joinAsTrader(
      {required String traderName, File? traderImgFile}) async {
    try {
      final response = await _service.joinAsTrader(
          traderName: traderName, img: traderImgFile);
      final decodedJson = json.decode(
        const Utf8Codec().decode(response.bodyBytes),
      );

      if (decodedJson['success'] == true) {
        return Right(decodedJson['message']);
      } else {
        return left(
           ServiceFailure(decodedJson['message']),
        );
      }
    } catch (e) {
      return left(
        ServiceFailure(e.toString()),
      );
    }
  }

  ///return transaction_number or success message if it's group tnx
  Future<Either<Failure, List<dynamic>>> getTrades({
    String? search,
  }) async {
    try {
      final response = await _service.getTrades(
        body: {
          'search': search,
        },
      );
      final decodedJson = json.decode(
        const Utf8Codec().decode(response.bodyBytes),
      );

      if (decodedJson['success'] == true) {
        return Right([
          decodedJson['data']['trader'] != false
              ? TraderModel.fromJson(
                  decodedJson['data']['trader'],
                )
              : false,
          (decodedJson['data']['services'] as List<dynamic>)
              .map(
                (e) => TraderServicesModel.fromJson(e),
              )
              .toList(),
        ]);
      } else {
        return left(
          ServiceFailure(
            decodedJson['message'],
          ),
        );
      }
    } catch (e) {
      return left(
        ServiceFailure(e.toString()),
      );
    }
  }

  Future<Either<Failure, String>> addTradeService({
    required String exchangeRate,
    required String fromWallet,
    required String toWallet,
  }) async {
    try {
      final response = await _service.addTradeService(
        body: {
          'exchange_rate': exchangeRate,
          'to_wallet': toWallet,
          'from_wallet': fromWallet,
        },
      );
      final decodedJson = json.decode(
        const Utf8Codec().decode(response.bodyBytes),
      );

      if (decodedJson['success'] == true) {
        return Right(decodedJson['message']);
      } else {
        return left(
          ServiceFailure(
            decodedJson['message'],
          ),
        );
      }
    } catch (e) {
      return left(
        ServiceFailure(e.toString()),
      );
    }
  }

  Future<Either<Failure, String>> exchangeTradement({
    required String exchangeRate,
    required String tradeId,
  }) async {
    try {
      final response = await _service.exchangeTradement(
        body: {
          'exchanged_amount': exchangeRate,
          'trade_service_id': tradeId,
        },
      );
      final decodedJson = json.decode(
        const Utf8Codec().decode(response.bodyBytes),
      );

      if (decodedJson['success'] == true) {
        return Right(decodedJson['message']);
      } else {
        return left(
          ServiceFailure(
            decodedJson['message'],
          ),
        );
      }
    } catch (e) {
      return left(
        ServiceFailure(e.toString()),
      );
    }
  }

  Future<Either<Failure, String>> deactivateAll() async {
    try {
      final response = await _service.deactivateAll();

      final decodedJson = json.decode(
        const Utf8Codec().decode(response.bodyBytes),
      );

      if (decodedJson['success'] == true) {
        return Right(decodedJson['message']);
      } else {
        return left(
           ServiceFailure(decodedJson['message']),
        );
      }
    } catch (e) {
      return left(
        ServiceFailure(e.toString()),
      );
    }
  }

  Future<Either<Failure, String>> activateAll() async {
    try {
      final response = await _service.activateAll();

      final decodedJson = json.decode(
        const Utf8Codec().decode(response.bodyBytes),
      );

      if (decodedJson['success'] == true) {
        return Right(decodedJson['message']);
      } else {
        return left(
           ServiceFailure(decodedJson['message']),
        );
      }
    } catch (e) {
      return left(
        ServiceFailure(e.toString()),
      );
    }
  }

  Future<Either<Failure, String>> activateTradeService(
      {required String tradeId}) async {
    try {
      final response = await _service
          .activateTradeService(body: {'trade_service_id': tradeId});

      final decodedJson = json.decode(
        const Utf8Codec().decode(response.bodyBytes),
      );

      if (decodedJson['success'] == true) {
        return Right(decodedJson['message']);
      } else {
        return left(
           ServiceFailure(decodedJson['message']),
        );
      }
    } catch (e) {
      return left(
        ServiceFailure(e.toString()),
      );
    }
  }

  Future<Either<Failure, String>> deactivateTradeService(
      {required String tradeId}) async {
    try {
      final response = await _service
          .dactivateTradeService(body: {'trade_service_id': tradeId});

      final decodedJson = json.decode(
        const Utf8Codec().decode(response.bodyBytes),
      );

      if (decodedJson['success'] == true) {
        return Right(decodedJson['message']);
      } else {
        return left(
           ServiceFailure(decodedJson['message']),
        );
      }
    } catch (e) {
      return left(
        ServiceFailure(e.toString()),
      );
    }
  }

  Future<Either<Failure, String>> editTradeService(
      {required String tradeId, required String exchangeRate}) async {
    try {
      final response = await _service.editTradeService(
        body: {'exchange_rate': exchangeRate},
        query: {'id': tradeId},
      );

      final decodedJson = json.decode(
        const Utf8Codec().decode(response.bodyBytes),
      );
      if (decodedJson['success'] == true) {
        return Right(decodedJson['message']);
      } else {
        return left(
           ServiceFailure(decodedJson['message']),
        );
      }
    } catch (e) {
      return left(
        ServiceFailure(e.toString()),
      );
    }
  }

  Future<Either<Failure, String>> deleteTradeService(
      {required String tradeId}) async {
    try {
      final response = await _service
          .deleteTradeService(body: {'trade_service_id': tradeId});

      final decodedJson = json.decode(
        const Utf8Codec().decode(response.bodyBytes),
      );

      if (decodedJson['success'] == true) {
        return Right(decodedJson['message']);
      } else {
        return left(
           ServiceFailure(decodedJson['message']),
        );
      }
    } catch (e) {
      return left(
        ServiceFailure(e.toString()),
      );
    }
  }
}
