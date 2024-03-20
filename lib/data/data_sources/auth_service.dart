import 'package:finpay/config/end_points.dart';
import 'package:finpay/config/services/remote/http_helper.dart';
import 'package:http/http.dart';

import '../../core/utils/globales.dart';

class AuthService {
  
  Future<Response> login({required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      endPointUrl: '${ApiEndPoints.authEndPoint}/login.php',
      data: body,
    );
  }

  
  Future<Response> logOut({required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      endPointUrl: '${ApiEndPoints.authEndPoint}/logout.php',
      data: body,
      userToken: currentUser.token,
    );
  }

  
  Future<Response> logup({required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      endPointUrl: '${ApiEndPoints.authEndPoint}/register.php',
      data: body,
    );
  }

  
  Future<Response> sendPasswordResetEmail(
      {required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      endPointUrl: '${ApiEndPoints.authEndPoint}/send-pass-reset-code.php',
      data: body,
    );
  }

  
  Future<Response> verifyResetPass({required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      endPointUrl: '${ApiEndPoints.authEndPoint}/verify-reset-password.php',
      data: body,
    );
  }

  
  Future<Response> resetPass({required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      endPointUrl: '${ApiEndPoints.authEndPoint}/reset-password.php',
      data: body,
    );
  }

  
  Future<Response> socialLogin({required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      endPointUrl: '${ApiEndPoints.authEndPoint}/social-login.php',
      data: body,
    );
  }

  
  Future<Response> sendEmailVerification(
      {required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      endPointUrl: '${ApiEndPoints.authEndPoint}/send-verification-code.php',
      data: body,
    );
  }

  
  Future<Response> verifyEmailCode({required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      endPointUrl: '${ApiEndPoints.authEndPoint}/verify-email.php',
      data: body,
    );
  }

  
  Future<Response> createPin({required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      endPointUrl: '${ApiEndPoints.authEndPoint}/create-pin.php',
      data: body,
    );
  }

  
  Future<Response> verifyPin({required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      endPointUrl: '${ApiEndPoints.authEndPoint}/verify-pin-code.php',
      data: body,
      userToken: currentUser.token,
    );
  }
}
