import 'service_details_model.dart';

class ProviderModel {
  late final String providrname;
  late final int id;
  late final int userId;
  late final String providerImg;
  late final String? phone;
  late final int? isApproved;
  late final int? isConfirmed;
  late final String? registeredAt;
    late List<ServiceDetailsModel> myServices = [];


  ProviderModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    providrname = json["provider_name"];
    userId = json["user_id"];
    providerImg = json["provider_image"];
    phone = json["provider_phone"];
    isApproved = json["approved_provider"];
    isConfirmed = json["confirmed_provider"];
    registeredAt = json['registeredAt'];
    if(json['services']!=null){
      myServices = (json['services'] as List<dynamic>)
        .map((e) => ServiceDetailsModel.fromJson(e))
        .toList();
    }
  }
}
