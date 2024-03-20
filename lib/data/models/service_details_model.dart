import 'provider_model.dart';

class ServiceDetailsModel {
  late final int id;
  late final String name;
  late final String image;
  late final String creationTime;
  late final String description;
  late final String address;
  late final String amount;
  late final String? providerName;

  late final String walletCurrency, fieldName;
  late bool active;
  late final bool approved;
  late final bool subscribed;

  ///only available in myServices not field Services
  late final ProviderModel? provider;
  late final String city;

  ServiceDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["service_name"];
    image = json["service_image"];
    creationTime = json["creationTime"];
    description = json["description"];
    address = json["address"];
    amount = json["amount"];
    active = json['active'] == 1 ? true : false;
    city = json['city']['city_name'];
    approved = json['approved'] == 1 ? true : false;
    walletCurrency = json['wallet']['wallet_currency'];
    fieldName = json['field']['field_name'];
    provider = json['provider'] != null
        ? ProviderModel.fromJson(json['provider'])
        : null;
    providerName = json['provider_name'];
  }
}
