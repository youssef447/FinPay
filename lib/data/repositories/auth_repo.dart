import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:finpay/data/data_sources/auth_service.dart';
import 'package:finpay/data/models/user_model.dart';
import 'package:http/http.dart';

import '../../config/error_handler.dart';
import '../../config/services/local/cach_helper.dart';
import '../../core/utils/globales.dart';

class UserAuthRepo {
  late final AuthService _authService;
  UserAuthRepo({required AuthService authService}) : _authService = authService;

  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await _authService.login(
        body: {
          'email': email,
          'password': password,
          if (fcmToken != null) 'platform': 'android',
          if (fcmToken != null) 'platform_token': fcmToken
        },
      );
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

      if (decodedJson['success'] == false) {
        return Left(
          ServiceFailure(decodedJson['message']),
        );
      }
      await CacheHelper.saveSecureData(
        key: 'user',
        value: json.encode(
          decodedJson['user'],
        ),
      );
      currentUser = UserModel.fromJson(
        decodedJson['user'],
      );
      return Right(currentUser);
    } catch (e) {
      return left(
        ServiceFailure(e.toString()),
      );
    }
  }

  Future<Either<Failure, UserModel>> socialLogin({
    required String email,
  }) async {
    try {
      final response = await _authService.socialLogin(
        body: {'email': email, 'platform_token': 'LJUj3jjw8KL932mwlq'},
      );
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));
      if (decodedJson['success'] == false) {
        return Left(
          ServiceFailure(decodedJson['message']),
        );
      }
      await CacheHelper.saveSecureData(
        key: 'user',
        value: json.encode(
          decodedJson['user'],
        ),
      );
      currentUser = UserModel.fromJson(
        decodedJson['user'],
      );
      return Right(currentUser);
    } catch (e) {
      return left(
        ServiceFailure(e.toString()),
      );
    }
    /*  return Right(
        UserModel.fromJson(
          decodedJson['user'],
        ),
      );
    } catch (e) {
      return left(
        ServiceFailure(
          e.toString(),
        ),
      );
    } */
  }

  Future<Either<Failure, String>> logup({
    required String fullName,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      Response response = await _authService.logup(
        body: {
          'full_name': fullName,
          'email': email,
          'username': username,
          'password': password,
        },
      );
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

      if (decodedJson['success'] == false) {
        return Left(
          ServiceFailure(decodedJson['message']),
        );
      }
      return Right(
        decodedJson['message'],
      );
    } catch (e) {
      return left(
        ServiceFailure(e.toString()),
      );
    }
  }

  Future<Either<Failure, String>> sendVerificationEmail({
    required String email,
  }) async {
    try {
      final response = await _authService.sendEmailVerification(
        body: {'email': email},
      );
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));
      if (decodedJson['success'] == false) {
        return Left(
          ServiceFailure(decodedJson['message']),
        );
      }
      return Right(decodedJson['user_id'].toString());
    } catch (e) {
      return left(
        ServiceFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, String>> verifyEmailCode({
    required String id,
    required String code,
  }) async {
    try {
      final response = await _authService.verifyEmailCode(
        body: {
          'id': id,
          'code': code,
        },
      );
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));
      if (decodedJson['success'] == false) {
        return Left(
          ServiceFailure(decodedJson['message']),
        );
      }
      return Right(decodedJson['message']);
    } catch (e) {
      return left(
        ServiceFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, String>> createPin(
      {required String id, required String pin}) async {
    try {
      final response = await _authService.createPin(
        body: {'id': id, 'pin': pin},
      );
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));
      if (decodedJson['success'] == false) {
        return Left(
          ServiceFailure(decodedJson['message']),
        );
      }
      return Right(decodedJson['message']);
    } catch (e) {
      return left(
        ServiceFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, String>> verifyPin({required String pin}) async {
    try {
      final response = await _authService.verifyPin(
        body: {'code': pin},
      );
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));
      if (decodedJson['success'] == false) {
        return Left(
          ServiceFailure(decodedJson['message']),
        );
      }
      return Right(decodedJson['message']);
    } on SocketException catch (_) {
      return left(
        ServiceFailure(
          'connection error',
        ),
      );
    } on TimeoutException catch (_) {
      return left(
        ServiceFailure(
          'connection Time Out',
        ),
      );
    } catch (e) {
      return left(
        ServiceFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, String>> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      final response = await _authService.sendPasswordResetEmail(
        body: {'email': email},
      );
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));
      if (decodedJson['success'] == false) {
        return Left(
          ServiceFailure(decodedJson['message']),
        );
      }
      return Right(decodedJson['message']);
    } catch (e) {
      return left(
        ServiceFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, String>> verifyResetPass({
    required String email,
    required String code,
  }) async {
    try {
      final response = await _authService.verifyResetPass(
        body: {'email': email, 'code': code},
      );
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));
      if (decodedJson['success'] == false) {
        return Left(
          ServiceFailure(decodedJson['message']),
        );
      }
      return Right(decodedJson['message']);
    } catch (e) {
      return left(
        ServiceFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, String>> resetPass({
    required String email,
    required String password,
    required String code,
  }) async {
    try {
      final response = await _authService.resetPass(
        body: {'email': email, 'password': password, 'code': code},
      );
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));
      if (decodedJson['success'] == false) {
        return Left(
          ServiceFailure(decodedJson['message']),
        );
      }
      return Right(decodedJson['message']);
    } catch (e) {
      return left(
        ServiceFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, String>> logout() async {
    try {
      final response = await _authService.logOut(
        body: {
          'id': currentUser.id.toString(),
        },
      );
      final decodedJson = json.decode(
        const Utf8Codec().decode(response.bodyBytes),
      );

      if (decodedJson['success'] == false) {
        return Left(
          ServiceFailure(decodedJson['message']),
        );
      }
      await CacheHelper.removeSecureData(key: 'user');

      return Right(decodedJson['message']);
    } catch (e) {
      return left(
        ServiceFailure(
          e.toString(),
        ),
      );
    }
  }
}
