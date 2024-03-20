import 'package:http/http.dart';

import '../../config/end_points.dart';
import '../../config/services/remote/http_helper.dart';
import '../../core/utils/globales.dart';

class TopupService {
  /* Future<Response> addBranch({required Map<String, dynamic> body}) async {
    return await HttpHelper.postData(
      endPointUrl: '${ApiEndPoints.branchesEndPoint}/add-new-branch.php',
      userToken: currentUser.token,
    );
  } */

  Future<Response> getBranches() async {
    return await HttpHelper.getData(
      endPointUrl: '${ApiEndPoints.branchesEndPoint}/branches.php',
      userToken: currentUser.token,
    );
  }
}
