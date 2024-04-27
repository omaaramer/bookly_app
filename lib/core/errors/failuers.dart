import 'package:dio/dio.dart';

abstract class Failure {
  final String errormessage;

  Failure({required this.errormessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errormessage});
  factory ServerFailure.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(errormessage: 'Connection Timeout');

      case DioExceptionType.sendTimeout:
        return ServerFailure(errormessage: 'Send Timeout');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errormessage: 'Connection Timeout');
      case DioExceptionType.badCertificate:
        return ServerFailure(errormessage: 'Bad Certificate');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioException.response!.data, dioException.response!.statusCode!);
      case DioExceptionType.cancel:
        return ServerFailure(errormessage: 'Cancel');
      case DioExceptionType.connectionError:
        return ServerFailure(errormessage: 'Connection Error');
      case DioExceptionType.unknown:
        if (dioException.message!.contains('SocketException')) {
          return ServerFailure(errormessage: 'No Internet Connection');
        }
        return ServerFailure(errormessage: 'Unexpected Error');
      default:
        return ServerFailure(errormessage: 'Oops something went wrong');
    }
  }
  factory ServerFailure.fromResponse(dynamic response, int statusCode) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(errormessage: response['error']['message']);
    }
    switch (statusCode) {
      case 404:
        return ServerFailure(errormessage: 'Not Found');
      case 500:
        return ServerFailure(errormessage: 'Internal Server Error');
      default:
        return ServerFailure(errormessage: 'Oops something went wrong');
    }
  }
}
