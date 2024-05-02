import 'package:intl/intl.dart';

class TransactionCodeDetailsModel {
  late final int id;
    int? walletId;
  late final String? creationDate;
  final String image = 'assets/images/transaction.svg';

    String? amount;
  String? walletCurrency = 'N/A';
  String? walletName;
  late final String? username;
  late final String? type;

  TransactionCodeDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    if (json['wallet'] != false) {
      if(json['wallet']['created_at']!=null){
      creationDate = DateFormat('M/d/y, hh:mm aa')
          .format(DateTime.parse(json['wallet']['created_at']));
      }
      walletCurrency = json["wallet"]['wallet_currency'];
      walletName = json["wallet"]['wallet_name'];
      walletId=json["wallet"]['id'];
    }
    amount = json["money"];
    username = json["username"];

    type = json["type"] ?? 'N/A';
  }
}

/* {
    "data": {
        "id": 197,
        "user_id": 2865,
        "transaction_code": "SEAB4ZMRFPZ14KA",
        "type": "username",
        "money": "10",
        "username": "Jo64",
        "wallet": {
            "id": 1,
            "wallet_name": "x",
            "wallet_currency": "x",
            "price": "100000",
            "default_wallet": 1,
            "test_wallet": 1,
            "created_at": "2022-02-25 22:22:00",
            "updated_at": "2022-02-25 22:29:27",
            "deleted_at": null
        }
    },
    "success": true
} */



