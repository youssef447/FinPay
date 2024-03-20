import 'package:finpay/data/models/service_details_model.dart';

import 'provider_model.dart';

class ServiceModel {
  late List<Field> fields = [];

  late final ProviderModel provider;
   bool? isProvider;
  late List<ServiceDetailsModel> mySubscribedServices = [];

  ServiceModel.fromJson(Map<String, dynamic> json) {
    fields = (json['fields'] as List<dynamic>)
        .map(
          ((e) => Field.fromJson(e)),
        )
        .toList();

    if (json['provider'] is bool) {
      isProvider = json['provider'];
    } else {
      provider = ProviderModel.fromJson(json['provider']);
    }
    mySubscribedServices = (json['myservices'] as List<dynamic>)
        .map((e) => ServiceDetailsModel.fromJson(e))
        .toList();
  }
}

class Field {
  late final String fieldName;
  late final int fieldId;

  Field.fromJson(Map<String, dynamic> json) {
    fieldName = json['field_name'];
    fieldId = json['id'];
  }
}
