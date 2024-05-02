class TraderModel {
  late final int id;
  late final int userId;
  late final String registeredAt;
  List<TraderServicesModel> myServices = [];

  TraderModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["user_id"];
    registeredAt = json["registeredAt"];

    myServices = (json["myservices"] as List<dynamic>).map((service) {
      return TraderServicesModel.fromJson(service);
    }).toList();
  }
}

class TraderServicesModel {
  late final int id;
  late final int traderId;
  late final String traderName;
  late final String traderPic;
  late String exchangeRate;
  late final String toWalletName;
  late final int toWalletId;

  late final int fromWalletId;

  late final String fromWalletName;
  late final String toWalletCurrency;
  late final String fromWalletCurrency;
  late final String traderAmount;
  late final String creationTime;
  late bool active;

  TraderServicesModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    traderId = json["trader_id"];
    traderName = json["trader_name"];
    traderPic = json["trader_image"];
    exchangeRate = json["exchange_rate"];
    toWalletName = (json["to_wallet"]['wallet_name']);
    toWalletId = (json["to_wallet"]['id']);
    fromWalletId = (json["from_wallet"]['id']);

    fromWalletName = (json["from_wallet"]['wallet_name']);
    toWalletCurrency = (json["to_wallet"]['wallet_currency']);
    fromWalletCurrency = (json["from_wallet"]['wallet_currency']);
    traderAmount = json["trader_amount"];
    creationTime = json['creationTime'];
    active = json["active"] == 1 ? true : false;
  }
}

// "trader": {
//             "id": "6",
//             "user_id": "2810",
//             "registeredAt": "19-06-2023",
//             "myservices": [
//                 {
//                     "id": "6",
//                     "trader_id": "6",
//                     "from_wallet": {
//                         "id": "24",
//                         "wallet_name": "dodo",
//                         "wallet_currency": "do"
//                     },
//                     "to_wallet": {
//                         "id": "25",
//                         "wallet_name": "soso",
//                         "wallet_currency": "so"
//                     },
//                     "exchange_rate": "15",
//                     "creationTime": "20-06-2023",
//                     "active": "1",
//                     "test_mode": "1",
//                     "trader_name": "orcaTrader",
//                     "trader_image": "https://paytome.net/apis/images/traders/no_image.png\t",
//                     "trader_amount": "5000"
//                 }
//             ]
//         },