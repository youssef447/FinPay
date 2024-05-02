import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:finpay/config/error_handler.dart';
import 'package:finpay/core/utils/globales.dart';
import 'package:finpay/data/data_sources/user_service.dart';
import 'package:finpay/data/models/notification_model.dart';
import 'package:finpay/data/models/ticket_details_model.dart';
import 'package:finpay/data/models/transaction_model.dart';
import 'package:finpay/data/models/wallet_model.dart';

import '../models/member_model.dart';

class UserRepo {
  final UserServices _service;
  UserRepo({required UserServices service}) : _service = service;

  Future<Either<Failure, List<TransactionModel>>> getTransactions(
      {String? walletId, String? page}) async {
    try {
      final response = await _service.getWalletTransactions(
        body: {'wallet_id': walletId ?? '', 'page': page ?? ''},
      );
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

      if (decodedJson['success'] == true) {
        List<TransactionModel> txnList = [];
        txnList = (decodedJson['data'] as List<dynamic>).map((element) {
          return TransactionModel.fromJson(element);
        }).toList();

        return Right(txnList);
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

  Future<Either<Failure, String>> updateProfile(
      {required String fullName}) async {
    try {
      final response = await _service.updateProfile(
        body: {'full_name': fullName},
      );
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

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

  Future<Either<Failure, String>> createUsername(
      {required String username}) async {
    try {
      final response = await _service.createUsername(
        body: {'username': username, 'id': currentUser.id.toString()},
      );
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

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

  Future<Either<Failure, String>> updatePhone({required String phone}) async {
    try {
      final response = await _service.updatePhone(
        body: {'phone': phone},
      );
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

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

  Future<Either<Failure, String>> updateEmail({required String email}) async {
    try {
      final response = await _service.updateEmail(
        body: {'new_email': email},
      );
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

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

  Future<Either<Failure, String>> updatePassword(
      {required String psswd1, required String psswd2}) async {
    try {
      final response = await _service.updatePassword(
        body: {'new_password': psswd1, 'new_password_confirm': psswd2},
      );
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

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

  Future<Either<Failure, List<WalletModel>>> getmyWallets(
      {String? walletId, String? page}) async {
    try {
      final response = await _service.getMyWallets();
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

      if (decodedJson['success'] == true) {
        List<WalletModel> walletsList = [];
        walletsList = (decodedJson['data'] as List<dynamic>).map((element) {
          return WalletModel.fromJson(element);
        }).toList();

        return Right(walletsList);
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

  Future<Either<Failure, bool>> toggleWallet({
    required String walletId,
  }) async {
    try {
      final response =
          await _service.hideUnhideWallet(body: {'wallet_id': walletId});
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

      if (decodedJson['success'] == true) {
        return const Right(true);
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

  Future<Either<Failure, bool>> toggleTestMode({required bool val}) async {
    try {
      final response = await _service.toggleTestMode(
        body: {'test_mode': val ? '1' : '0'},
      );
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

      if (decodedJson['success'] == true) {
        return Right(val);
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

  Future<Either<Failure, bool>> toggleNotificationsMode(
      {required bool val}) async {
    try {
      final response = await _service.toggleNotification(
        body: {'notifications_on_off': val ? '1' : '0'},
      );
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

      if (decodedJson['success'] == true) {
        return Right(val);
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

  Future<Either<Failure, bool>> togglePinMode({required bool val}) async {
    try {
      final response = await _service.togglePinCode(
        body: {'pincode_status': val ? '1' : '0'},
      );
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

      if (decodedJson['success'] == true) {
        return Right(val);
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

  Future<Either<Failure, List<NotificationModel>>> getMyNotifications(
      {String? walletId, String? page}) async {
    try {
      final response = await _service.getMyNotifications();
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

      if (decodedJson['success'] == true) {
        List<NotificationModel> list = [];
        list = (decodedJson['data'] as List<dynamic>).map((element) {
          return NotificationModel.fromJson(element);
        }).toList();

        return Right(list);
      } else {
        return left(
          ServiceFailure(
            'error getting notifications',
          ),
        );
      }
    } catch (e) {
      return left(
        ServiceFailure(e.toString()),
      );
    }
  }

  Future<Either<Failure, List<TicketModel>>> getTickets(
      {String? walletId, String? page}) async {
    try {
      final response = await _service.getTickets();
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

      if (decodedJson['success'] == true) {
        List<TicketModel> list = [];
        list = (decodedJson['data'] as List<dynamic>).map((element) {
          return TicketModel.fromJson(element);
        }).toList();
        return Right(list);
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

  Future<Either<Failure, TicketModel>> getTicketsDetails({
    required String ticketId,
  }) async {
    try {
      final response =
          await _service.getTicketsDetails(body: {'ticket_id': ticketId});
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));
      if (decodedJson['success'] ?? true) {
        return Right(TicketModel.fromJson(decodedJson['data']));
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

  Future<Either<Failure, String>> createTicket(
      {required String? msg, String? ticketId}) async {
    try {
      final response = await _service
          .createReplyTicket(body: {'message': msg, 'ticket_id': ticketId});
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

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

  Future<Either<Failure, TransactionModel>> getTransactionDetails({
    required String trxnId,
  }) async {
    try {
      final response = await _service
          .getTransactionDetails(body: {'transaction_id': trxnId});
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

      if (decodedJson['success'] == true) {
        return Right(
          TransactionModel.fromJson(
            decodedJson['data'],
          ),
        );
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

  Future<Either<Failure, List<MemberModel>>> getBookingList() async {
    try {
      final response = await _service.getBookingList();
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));
      if (decodedJson['success'] == true) {
        List<MemberModel> list = [];
        list = (decodedJson['data'] as List<dynamic>).map((element) {
          return MemberModel.fromJson(element);
        }).toList();
        return Right(list);
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

  Future<Either<Failure, String>> addToBookingList(
      {required String username, required String nickName}) async {
    try {
      final response = await _service.addToBookingList(
          body: {'member_username': username, 'member_nick_name': nickName});
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

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

  Future<Either<Failure, String>> editBookingList(
      {required String memberId, required String nickName}) async {
    try {
      final response = await _service.editToBookingList(
          body: {'member_nick_name': nickName}, query: {'member_id': memberId});
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

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

  Future<Either<Failure, String>> deleteFromBookingList({
    required String memberId,
  }) async {
    try {
      final response =
          await _service.deleteFromBookingList(query: {'member_id': memberId});
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

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
}
