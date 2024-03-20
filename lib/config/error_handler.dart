abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class ServiceFailure extends Failure {
  ServiceFailure(super.errMessage);
/*  factory ServerFailure.fromhttpError(HttpException httpError) {
    return ServerFailure(
      httpError.message,
    );
  } */

  factory ServiceFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServiceFailure(response['error']['message']);
    } else if (statusCode == 404) {
      return ServiceFailure('Your request not found, Please try later!');
    } else if (statusCode == 500) {
      return ServiceFailure('Internal Server error, Please try later');
    } else {
      return ServiceFailure('Opps There was an Error, Please try again');
    }
  }
}
