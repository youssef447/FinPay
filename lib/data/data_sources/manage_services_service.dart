import 'dart:io';

import 'package:finpay/config/end_points.dart';
import 'package:finpay/config/services/remote/http_helper.dart';
import 'package:finpay/core/utils/globales.dart';
import 'package:http/http.dart';

class Services {
  Future<Response> beProvider(
      {required String name, required String phone, File? img}) async {
    return await HttpHelper.multiFileReqPost(
      providerName: name,
      providerPhone: phone,
      service: true,
      imageFile: img,
      endPointUrl: '${ApiEndPoints.servicesEndPoint}/be-provider.php',
      userToken: currentUser.token,
    );
  }

  Future<Response> addService({required Map<String, dynamic> body}) async {
    print(body);
    return await HttpHelper.postData(
      data: body,
      endPointUrl: '${ApiEndPoints.servicesEndPoint}/service-add.php',
      userToken: currentUser.token,
    );
  }

  Future<Response> getAllServices() async {
    return await HttpHelper.getData(
      endPointUrl: '${ApiEndPoints.servicesEndPoint}/services.php',
      userToken: currentUser.token,
    );
  }

  Future<Response> searchService({required Map<String, dynamic> body}) async {
    return await HttpHelper.getData(
      query: body,
      userToken: currentUser.token,
      endPointUrl: '${ApiEndPoints.servicesEndPoint}/field-services.php',
    );
  }

  Future<Response> deleteService({required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      endPointUrl: '${ApiEndPoints.servicesEndPoint}/service-delete.php',
      query: body,
      userToken: currentUser.token,
    );
  }

  Future<Response> payService({required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      data: body,
      endPointUrl: '${ApiEndPoints.servicesEndPoint}/service-pay.php',
      userToken: currentUser.token,
    );
  }

/* // "{"message":"Successfull transfere!","transaction_id":"150","recipient_id":"2806","transaction_number":"2806ASZJQ812C2YZ2811","success":true}"

  Future<Response> approveMember({required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      data: body,
      endPointUrl: '${ApiEndPoints.servicesEndPoint}/member-approve.php',
      userToken: currentUser.token,
    );
  }

  Future<Response> deleteMember({required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      query: body,
      endPointUrl: '${ApiEndPoints.servicesEndPoint}/member-delete.php',
      userToken: currentUser.token,
    );
  }
 */
  Future<Response> subscribeService(
      {required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      data: body,
      endPointUrl: '${ApiEndPoints.servicesEndPoint}/service-subscribe.php',
      userToken: currentUser.token,
    );
  }

  Future<Response> unSubscribeService(
      {required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      data: body,
      endPointUrl: '${ApiEndPoints.servicesEndPoint}/service-unsubscribe.php',
      userToken: currentUser.token,
    );
  }

  Future<Response> activeAndDeactiveService(
      {required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      query: body,
      endPointUrl: '${ApiEndPoints.servicesEndPoint}/service-status-toggle.php',
      userToken: currentUser.token,
    );
  }

  Future<Response> getServiceDetails(
      {required Map<String, dynamic> body}) async {
    return await HttpHelper.getData(
      query: body,
      endPointUrl: '${ApiEndPoints.servicesEndPoint}/service-details.php',
      userToken: currentUser.token,
    );
  }
}
