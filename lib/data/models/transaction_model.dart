import 'package:intl/intl.dart';



class TransactionModel {
  late final int id;
  late final String creationDate;
  final String image = 'assets/images/transaction.svg';
  late final String originalCreationDate;
  late final int walletId;
  String? transactionCode;
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
    transactionCode = json["transaction_code"];
    originalCreationDate = json["creationTime"];
    creationDate = DateFormat('M/d/y, hh:mm aa')
        .format(DateTime.parse(json['creationTime']));
    transactionNumber = json["transaction_number"];
        walletId = json["wallet"]['id'];

    walletCurrency = json["wallet"]['wallet_currency'];
    walletName = json["wallet"]['wallet_name'];

    amount = '${json["amount"]} $walletCurrency';
    sender = TransactorModel.fromJson(json["sender"]);
    recipient = TransactorModel.fromJson(json["recipient"]);


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
