import 'dart:io';

import 'package:finpay/config/end_points.dart';
import 'package:finpay/core/utils/globales.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  HttpHelper._();

  static Future<http.Response> postData({
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    required String endPointUrl,
    String? userToken,
    String? bearedUserToken,
  }) async {
    var url = Uri.https(
      'paytome.net',
      '/apis/$endPointUrl',
      query,
    );
    return await http.post(
      url,
      body: data,
      headers: {
        'lang': language,
        'api-token': ApiEndPoints.apiToken,
        'token': userToken ?? '',
        'Authorization': 'Bearer $bearedUserToken'
      },
    );
  }

  static Future<http.Response> getData({
    Map<String, dynamic>? query,
    required String endPointUrl,
    String? userToken,
    String? bearedUserToken,
    bool? authBearer,
  }) async {
    var url = Uri.https(
      'paytome.net',
      '/apis/$endPointUrl',
      query,
    );
    return await http.get(
      url,
      headers: {
        'lang': language,
        'api-token': ApiEndPoints.apiToken,
        'token': userToken ?? '',
        if (authBearer ?? false) 'Authorization': 'Bearer $bearedUserToken'
      },
    );
  }

  static Future<http.Response> multiFileReqPost({
    String? traderName,
    String? providerName,
    String? providerPhone,
    required String endPointUrl,
    bool? service,
    File? imageFile,
    String? userToken,
    bool? authBearer,
  }) async {
    var url = Uri.https(
      'paytome.net',
      '/apis/$endPointUrl',
    );

    var request = http.MultipartRequest("POST", url);
    if (service ?? false) {
      request.fields['provider_name'] = providerName!;
      request.fields['provider_phone'] = providerPhone!;
    } else {
      request.fields['trader_name'] = traderName!;
    }

    if (imageFile != null) {
      var multipartFileSign = await http.MultipartFile.fromPath(
        service ?? false ? 'provider_image' : 'trader_image',
        imageFile.path,
      );

      // add file to multipart
      request.files.add(multipartFileSign);
    }
    request.headers.addAll({
      'lang': language,
      'api-token': ApiEndPoints.apiToken,
      'token': userToken ?? '',
      if (authBearer ?? false) 'Authorization': 'Bearer $userToken'
    });

    // send

    final response = await request.send();
    final responed = await http.Response.fromStream(response);
    return responed;
  }
}
