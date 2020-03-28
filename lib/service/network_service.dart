import 'package:credicxo/constants/urls.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class NetworkService {
  static final NetworkService _singleton = NetworkService._internal();

  factory NetworkService() {
    return _singleton;
  }

  NetworkService._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: URLs().base,
      connectTimeout: 10000, //10 seconds
      receiveTimeout: 10000, //10 seconds
      sendTimeout: 10000, //10 seconds
    );
    _dio = Dio(options);
  }

  Dio _dio;

  Future<dynamic> get(String path) async {
    var responseJSON;
    try {
      Response<Map> response = await _dio.get(path);
      responseJSON = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioError catch (e) {
      if (e.type == DioErrorType.DEFAULT) {
        throw FetchDataException('No Internet connection');
      } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
        throw FetchDataException('Slow Internet connection');
      }
      print(e.toString());
    } catch (e) {
      print(e.toString());
      throw e;
    }
    return responseJSON;
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.data.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

class AppException implements Exception {
  final message;
  final prefix;

  AppException([this.message, this.prefix]);

  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String message]) : super(message, "Invalid Input: ");
}
