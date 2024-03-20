import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:finpay/data/data_sources/manage_services_service.dart';
import 'package:finpay/data/models/service_details_model.dart';
import 'package:finpay/data/models/services_model.dart';

import '../../config/error_handler.dart';

class ServiceRepo {
  final Services _service;
  ServiceRepo({required Services service}) : _service = service;

  Future<Either<Failure, String>> beProvider(
      {required String name, required String phone, File? img}) async {
    try {
      final response = await _service.beProvider(
        name: name,
        phone: phone,
        img: img,
      );

      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

      return Right(
        decodedJson['message'],
      );
    } catch (e) {
      return left(
        ServiceFailure(e.toString()),
      );
    }
  }

  Future<Either<Failure, ServiceModel>> getAvailableServices() async {
    try {
      final response = await _service.getAllServices();

      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

      if (decodedJson['success'] == true) {
        return Right(
          ServiceModel.fromJson(decodedJson['data']),
        );
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

  Future<Either<Failure, List<ServiceDetailsModel>>> getFieldServices(
      {required String fieldId}) async {
    try {
      final response =
          await _service.searchService(body: {'field_id': fieldId});

      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

      if (decodedJson['success'] == true) {
        return Right(
          (decodedJson['data'] as List<dynamic>)
              .map((e) => ServiceDetailsModel.fromJson(e))
              .toList(),
        );
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

  Future<Either<Failure, ServiceDetailsModel>> getMyServicesDetails(
      {required String serviceId}) async {
    try {
      final response =
          await _service.getServiceDetails(body: {'service_id': serviceId});

      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

      if (decodedJson['success'] == true) {
        final model =
            ServiceDetailsModel.fromJson(decodedJson['data']['service']);
        model.subscribed = decodedJson['data']['subscribed'] ?? false;
        return Right(model);
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

  Future<Either<Failure, String>> subscribe({required String serviceId}) async {
    try {
      final response =
          await _service.subscribeService(body: {'service_id': serviceId});

      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

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

  Future<Either<Failure, String>> unsubscribe(
      {required String serviceId}) async {
    try {
      final response =
          await _service.unSubscribeService(body: {'service_id': serviceId});

      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

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

  Future<Either<Failure, String>> payService(
      {required String serviceId}) async {
    try {
      final response =
          await _service.payService(body: {'service_id': serviceId});

      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

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

  Future<Either<Failure, String>> toggleService(
      {required String serviceId}) async {
    try {
      final response = await _service
          .activeAndDeactiveService(body: {'service_id': serviceId});

      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

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

  Future<Either<Failure, String>> deleteService(
      {required String serviceId}) async {
    try {
      final response =
          await _service.deleteService(body: {'service_id': serviceId});

      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

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

  Future<Either<Failure, String>> addService({
    String? serviceNameEn,
    String? serviceNameAr,
    String? description,
    String? address,
    String? cityNameEn,
    required String amount,
        required String fieldName,

    required String walletId,
    required String fieldId,
  }) async {


    try {
      final response = await _service.addService(body: {
        'field[id]': fieldId,
        'wallet_id': walletId,
        'amount': amount,
        'city[city_name]': cityNameEn,
        'service_name_en': serviceNameEn,
        'service_name_ar': serviceNameAr,
        'field[field_name]': fieldName,
        'address': address,
        'description': description,
      });

      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

      if (decodedJson['success'] == true) {
        return Right(decodedJson['message']);
      } else {
        if (decodedJson['message'].toString().contains('pending')) {
          return Right(decodedJson['message']);
        } else {
          return left(
            ServiceFailure(decodedJson['message']),
          );
        }
      }
    } catch (e) {
      return left(
        ServiceFailure(e.toString()),
      );
    }
  }
}
