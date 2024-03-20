import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FakeTransactionModel {
  final Color? background;
  final String image = 'assets/images/transaction.svg';
  final String? title;

  final String? subTitle;
  final String? price;

  final String? time;

  FakeTransactionModel(
      this.background, this.title, this.subTitle, this.price, this.time);
}

class TransactionModel {
  late final int id;
  late final String creationDate;
  final String image = 'assets/images/transaction.svg';
  late final String originalCreationDate;

  late final String transactionNumber;
  late final String amount;
  late final String walletCurrency;
  late final String walletName;
  late final String transactionType;
  late final TransactorModel sender;
  late final TransactorModel recipient;
  late final String? type;

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    originalCreationDate=json["creationTime"];
    creationDate = DateFormat('M/d/y, hh:mm aa')
        .format(DateTime.parse(json['creationTime']));
    transactionNumber = json["transaction_number"];
    walletCurrency = json["wallet"]['wallet_currency'];

    amount = '${json["amount"]} $walletCurrency';
    sender = TransactorModel.fromJson(json["sender"]);
    recipient = TransactorModel.fromJson(json["recipient"]);

    walletName = json["wallet"]['wallet_name'];

    transactionType = json["transaction_type"];
  }
}

class TransactorModel {
  late final String fullName;
  late final String? userName;
  late final int id;
  TransactorModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    fullName = json["full_name"];
    userName = json["user_name"];
  }
}
