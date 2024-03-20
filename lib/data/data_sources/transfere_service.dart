import 'package:http/http.dart';

import '../../config/end_points.dart';
import '../../config/services/remote/http_helper.dart';
import '../../core/utils/globales.dart';

class TransfereServices {
  ///wallet_id, money
  Future<Response> generateUserBarCode(
      {required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      data: body,
      endPointUrl:
          '${ApiEndPoints.transferEndPoint}/generate-username-barcode.php',
      userToken: currentUser.token,
    );
  }

  Future<Response> generateTxnCode() async {
    return await HttpHelper.postData(
      endPointUrl:
          '${ApiEndPoints.transferEndPoint}/generate-transaction-code.php',
      userToken: currentUser.token,
    );
  }

  ///{type:value"username" or "transaction_code" or "group" }
  ///username :or transaction_code or group_id, money, wallet
  Future<Response> sendMoney({required Map<String, dynamic> body}) async {

    final response= await HttpHelper.postData(
      data: body,
      endPointUrl: '${ApiEndPoints.transferEndPoint}/transfere-money.php',
      userToken: currentUser.token,
    );
    return response;
  }

  ///code:
  Future<Response> getTxnDetails({required Map<String, dynamic> body}) async {
    return await HttpHelper.getData(
      endPointUrl:
          '${ApiEndPoints.transferEndPoint}/tansaction-code-details.php',
      userToken: currentUser.token,
      query: body,
    );
  }

  ///group_name,group_about
  Future<Response> createGroup({required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      data: body,
      endPointUrl: '${ApiEndPoints.transferEndPoint}/group-create.php',
      userToken: currentUser.token,
    );
  }

  ///group_id
  Future<Response> deleteGroup({required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      data: body,
      endPointUrl: '${ApiEndPoints.transferEndPoint}/group-delete.php',
      userToken: currentUser.token,
    );
  }  Future<Response> deleteMember({required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      data: body,
      endPointUrl: '${ApiEndPoints.transferEndPoint}/group-member-delete.php',
      userToken: currentUser.token,
    );
  }

  ///group_id,member_username,member_nick_name
  Future<Response> addMemeber({required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      data: body,
      endPointUrl: '${ApiEndPoints.transferEndPoint}/group-member-add.php',
      userToken: currentUser.token,
    );
  }

  ///group_name,group_about, query:id:
  Future<Response> editGroup(
      {required Map<String, dynamic> body,
      required Map<String, dynamic> query}) async {
    return await HttpHelper.postData(
      data: body,
      query: query,
      endPointUrl: '${ApiEndPoints.transferEndPoint}/group-edit.php',
      userToken: currentUser.token,
    );
  }

  ///group_id,member_nick_name, query:id:
  Future<Response> editMember(
      {required Map<String, dynamic> body,
      required Map<String, dynamic> query}) async {
    return await HttpHelper.postData(
      data: body,
      query: query,
      endPointUrl: '${ApiEndPoints.transferEndPoint}/group-member-edit.php',
      userToken: currentUser.token,
    );
  }

  /// search:name:
  Future<Response> searchGroup({ Map<String, dynamic>? body}) async {
    return await HttpHelper.getData(
      query: body,
      endPointUrl: '${ApiEndPoints.transferEndPoint}/groups.php',
      userToken: currentUser.token,
    );
  }
   /// search:nickname , group_id:
  Future<Response> searchMemberName({required Map<String, dynamic> body}) async {
    return await HttpHelper.getData(
      query: body,
      endPointUrl: '${ApiEndPoints.transferEndPoint}/group-members.php',
      userToken: currentUser.token,
    );
  }
}
