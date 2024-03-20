import 'package:get/get.dart';

import 'transaction_model.dart';

class WalletModel {
  late final int id;
  late final int walletId;
  late final String name;
  late final String? createdAt;
  late final String? lastUpdateDate;

  late final String price;
  late final String currency;

  late RxBool hidden;
  late int testMode;
  List<TransactionModel>transactionList=[];
/* 
  WalletModel({
    required this.id,
    required this.walletId,
    required this.name,
    this.createdAt,
    this.lastUpdateDate,
    // required this.lastChargingSource,
    this.price = '0.00',
    required this.currency,
    this.testMode,
  }); */

  WalletModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    walletId = json["wallet_id"];
    name = json["wallet_name"];
    currency = json["wallet_currency"];
    createdAt = json["created_at"];
    lastUpdateDate = json["updated_at"];
    price = json["price"];
    hidden = (json["hidden"]as bool).obs;
    testMode = json["test_mode"];

  }
}
