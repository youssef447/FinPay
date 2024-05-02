import 'package:finpay/config/end_points.dart';
import 'package:finpay/config/services/remote/http_helper.dart';
import 'package:finpay/core/utils/globales.dart';
import 'package:http/http.dart';

class UserServices {
  Future<Response> getTickets() async {
    return await HttpHelper.getData(
      endPointUrl: '${ApiEndPoints.usersEndPoint}/tickets.php',
      userToken: currentUser.token,
    );
  }

  Future<Response> getTicketsDetails(
      {required Map<String, dynamic> body}) async {
    return await HttpHelper.getData(
      query: body,
      endPointUrl: '${ApiEndPoints.usersEndPoint}/ticket-details.php',
      userToken: currentUser.token,
    );
  }

  Future<Response> createReplyTicket(
      {required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      data: body,
      endPointUrl: '${ApiEndPoints.usersEndPoint}/ticket-add.php',
      userToken: currentUser.token,
    );
  }

  Future<Response> toggleTestMode({required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      data: body,
      endPointUrl: '${ApiEndPoints.usersEndPoint}/test-mode-toggle.php',
      userToken: currentUser.token,
    );
  }

  Future<Response> toggleNotification(
      {required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      data: body,
      endPointUrl: '${ApiEndPoints.usersEndPoint}/notifications-toggle.php',
      userToken: currentUser.token,
    );
  }

  Future<Response> getMyNotifications() async {
    return await HttpHelper.getData(
      endPointUrl: '${ApiEndPoints.usersEndPoint}/notifications.php',
      userToken: currentUser.token,
    );
  }

  Future<Response> togglePinCode({required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      data: body,
      endPointUrl: '${ApiEndPoints.usersEndPoint}/pincode-toggle.php',
      userToken: currentUser.token,
    );
  }

  ///full_name
  Future<Response> updateProfile({required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
        endPointUrl: '${ApiEndPoints.usersEndPoint}/profile-update.php',
        data: body,
        bearedUserToken: currentUser.token);
  }

  ///phone, dialCode,isoCode
  Future<Response> updatePhone({required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      data: body,
      endPointUrl: '${ApiEndPoints.usersEndPoint}/update-phone.php',
      bearedUserToken: currentUser.token,
    );
  }

  ///new_email
  Future<Response> updateEmail({required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
        data: body,
        endPointUrl: '${ApiEndPoints.usersEndPoint}/update-email.php',
        bearedUserToken: currentUser.token);
  }

  ///{new_password: , new_password_confirm:}
  Future<Response> updatePassword({required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
        data: body,
        endPointUrl: '${ApiEndPoints.usersEndPoint}/update-password.php',
        bearedUserToken: currentUser.token);
  }

  Future<Response> sendPasswordVerification(
      {required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
        data: body,
        endPointUrl: '${ApiEndPoints.usersEndPoint}/verify-password.php',
        bearedUserToken: currentUser.token);
  }

  Future<Response> verifyPasswordCode(
      {required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      data: body,
      endPointUrl: '${ApiEndPoints.usersEndPoint}/verify-code.php',
      userToken: currentUser.token,
    );
  }

  Future<Response> addUserToBookingList(
      {required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      data: body,
      endPointUrl: '${ApiEndPoints.usersEndPoint}/members-book-add.php',
      userToken: currentUser.token,
    );
  }

  Future<Response> searchUserFromBookingList(
      {Map<String, dynamic>? body}) async {
    return await HttpHelper.getData(
      query: body,
      endPointUrl: '${ApiEndPoints.usersEndPoint}/members-book.php',
      userToken: currentUser.token,
    );
  }

  // wallets
  Future<Response> getMyWallets() async {
    return await HttpHelper.getData(
      endPointUrl: '${ApiEndPoints.usersEndPoint}/my-wallets.php',
      userToken: currentUser.token,
    );
  }

  ///{transaction_id:}required
  Future<Response> getTransactionDetails({Map<String, dynamic>? body}) async {
    return await HttpHelper.getData(
      query: body,
      endPointUrl: '${ApiEndPoints.usersEndPoint}/transaction-details.php',
      userToken: currentUser.token,
    );
  }

  ///{wallet_id:,page:} optional
  Future<Response> getWalletTransactions({Map<String, dynamic>? body}) async {
    return await HttpHelper.getData(
      query: body,
      endPointUrl: '${ApiEndPoints.usersEndPoint}/transactions.php',
      userToken: currentUser.token,
    );
  }

  Future<Response> hideUnhideWallet(
      {required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      data: body,
      endPointUrl: '${ApiEndPoints.usersEndPoint}/wallet-toggle.php',
      userToken: currentUser.token,
    );
  }

  Future<Response> createUsername({required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      data: body,
      endPointUrl: '${ApiEndPoints.authEndPoint}/create-username.php',
      userToken: currentUser.token,
    );
  }

  Future<Response> getBookingList({Map<String, dynamic>? query}) async {
    return await HttpHelper.getData(
      query: query,
      endPointUrl: '${ApiEndPoints.usersEndPoint}/members-book.php',
      userToken: currentUser.token,
    );
  }

  ///member_username, member_nick_name
  Future<Response> addToBookingList(
      {required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      data: body,
      endPointUrl: '${ApiEndPoints.usersEndPoint}/members-book-add.php',
      userToken: currentUser.token,
    );
  }

  ///body :member_nick_name,query: member_id
  Future<Response> editToBookingList({
    required Map<String, dynamic> body,
    required Map<String, dynamic> query,
  }) async {
    return await HttpHelper.postData(
      data: body,
      query: query,
      endPointUrl: '${ApiEndPoints.usersEndPoint}/members-book-edit.php',
      userToken: currentUser.token,
    );
  }

  ///query: member_id
  Future<Response> deleteFromBookingList({
    required Map<String, dynamic> query,
  }) async {
    return await HttpHelper.postData(
      query: query,
      endPointUrl: '${ApiEndPoints.usersEndPoint}/members-book-delete.php',
      userToken: currentUser.token,
    );
  }
}
