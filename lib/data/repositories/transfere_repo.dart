import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:finpay/data/data_sources/transfere_service.dart';

import '../../config/error_handler.dart';
import '../models/group_model.dart';
import '../models/transaction_code_details_model.dart';

class TransferRepo {
  final TransfereServices _service;
  TransferRepo({required TransfereServices service}) : _service = service;

  Future<Either<Failure, List<GroupModel>>> searchGroup() async {
    try {
      final response = await _service.searchGroup();
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

      if (decodedJson['success'] == true) {
        final list = (decodedJson['data'] as List<dynamic>).map((element) {
          return GroupModel.fromJson(element);
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
    Future<Either<Failure, List<GroupMemberModel>>> searchGroupMembers({required String groupId,String?memberName}) async {
    try {
      final response = await _service.searchMemberName(body: {
        'group_id':groupId,'search':memberName,
      });
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

      if (decodedJson['success'] == true) {
        final list = (decodedJson['data'] as List<dynamic>).map((element) {
          return GroupMemberModel.fromJson(element);
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

  Future<Either<Failure, String>> addGroup({
    required String groupName,
    String? groupAbout,
  }) async {
    try {
      final response = await _service.createGroup(body: {
        'group_name': groupName,
        'group_about': groupAbout,
      });
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
Future<Either<Failure, String>> addGroupMember({
    required String userName,
    required String nickName,
    required String groupId,
  }) async {
    try {
      final response = await _service.addMemeber(body: {
        'member_username': userName,
        'member_nick_name': nickName,
         'group_id':groupId,
      });
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
  Future<Either<Failure, String>> editGroup({
    required String groupName,
    required String groupId,
    String? groupAbout,
  }) async {
    try {
      final response = await _service.editGroup(body: {
        'group_name': groupName,
        'group_about': groupAbout,
      }, query: {
        'id': groupId,
      });
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
Future<Either<Failure, String>> editGroupMember({
    required String nickName,
    required String groupMemberId,
    required String groupId,
  }) async {
    try {
      final response = await _service.editMember(body: {
        'member_nick_name': nickName,
        'group_id': groupId,
      }, query: {
        'id': groupMemberId,
      });
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
  Future<Either<Failure, String>> deleteGroup({
    required String groupId,
  }) async {
    try {
      final response = await _service.deleteGroup(
        body: {
          'group_id': groupId,
        },
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
Future<Either<Failure, String>> deleteGroupMember({
    required String groupMemberId,
  }) async {
    try {
      final response = await _service.deleteMember(
        body: {
          'group_member_id': groupMemberId,
        },
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
  Future<Either<Failure, String>> generateTransfereCode() async {
    try {
      final response = await _service.generateTxnCode();
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

      if (decodedJson['success'] == true) {
        return Right(decodedJson['transaction_code']);
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

  Future<Either<Failure, TransactionCodeDetailsModel>> getTrxnDetailsViaCode(
      {required String code}) async {
    try {
      final response = await _service.getTxnDetails(body: {'code': code});
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

      if (decodedJson['success'] == true) {
        return Right(
          TransactionCodeDetailsModel.fromJson(
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

  Future<Either<Failure, String>> generateUserBarcode({
    required String money,
    required String wallet,
  }) async {
    try {
      final response = await _service
          .generateUserBarCode(body: {'money': money, 'wallet': wallet});
      final decodedJson =
          json.decode(const Utf8Codec().decode(response.bodyBytes));

      if (decodedJson['success'] == true) {
        return Right(
          decodedJson['username_barcode'],
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

  ///return transaction_number or success message if it's group tnx
  Future<Either<Failure, String>> transfereMoney({
    required String type,
    required String money,
    required String walletId,
    required String recipient,
  }) async {
    try {
      final response = await _service.sendMoney(
        body: {
          'type': type,
          'money': money,
          'wallet': walletId,
          if (type == 'group') 'group_id': recipient,
          if (type == 'transaction_code') 'transaction_code': recipient,
          if (type == 'username') 'username': recipient,
        },
      );
      final decodedJson = json.decode(
        const Utf8Codec().decode(response.bodyBytes),
      );

      if (decodedJson['success'] == true) {
        return Right(type == 'group'
            ? decodedJson['message']
            : decodedJson['transaction_number']);
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
