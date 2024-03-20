import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:finpay/data/models/branch_model.dart';

import '../../config/error_handler.dart';
import '../data_sources/topup_service.dart';

class TopupRepo {
  final TopupService _service;
  TopupRepo({required TopupService service}) : _service = service;

  Future<Either<Failure, List<BranchModel>>> getBranches() async {
    try {
      final response = await _service.getBranches();

      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));
      if (decodedJson['success'] == true) {
        return Right(
          (decodedJson['data'] as List<dynamic>)
              .map((e) => BranchModel.fromJson(e))
              .toList(),
        );
      } else {
        return Left(ServiceFailure(decodedJson['message']));
      }
    } catch (e) {
      return left(
        ServiceFailure(e.toString()),
      );
    }
  }
}
