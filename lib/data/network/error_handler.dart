import 'package:dio/dio.dart';
import 'package:miseo/data/network/failure.dart';

import 'failure.dart';

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORIZED,
  NOT_FOUND,
  INTERNAL_SERVER_ERR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

class ErrorHandler implements Exception{
  late Failure failure;

  ErrorHandler.handle(dynamic error){
    if(error is DioError){
      //dio error -> error from response
      failure = _handleError(error);
    }else{
      //default error
      failure = DataSource.DEFAULT.getFailure();

    }
  }

  Failure _handleError(DioError error){
    switch(error.type){
      
      case DioErrorType.connectTimeout:
        return DataSource.CONNECT_TIMEOUT.getFailure();
      case DioErrorType.sendTimeout:
        return DataSource.SEND_TIMEOUT.getFailure();
      case DioErrorType.receiveTimeout:
        return DataSource.RECEIVE_TIMEOUT.getFailure();
      case DioErrorType.response:
        switch(error.response?.statusCode){
          case ResponseCode.BAD_REQUEST:
            return DataSource.BAD_REQUEST.getFailure();
          case ResponseCode.FORBIDDEN:
            return DataSource.FORBIDDEN.getFailure();
          case ResponseCode.UNAUTHORIZED:
            return DataSource.UNAUTHORIZED.getFailure();
          case ResponseCode.NOT_FOUND:
            return DataSource.NOT_FOUND.getFailure();
          case ResponseCode.INTERNAL_SERVER_ERR:
            return DataSource.INTERNAL_SERVER_ERR.getFailure();
          default:
            return DataSource.DEFAULT.getFailure();
        }
      case DioErrorType.cancel:
        return DataSource.CANCEL.getFailure();
      case DioErrorType.other:
        return DataSource.DEFAULT.getFailure();
    }
  }

  }


extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTHORIZED:
        return Failure(ResponseCode.UNAUTHORIZED, ResponseMessage.UNAUTHORIZED);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERR, ResponseMessage.INTERNAL_SERVER_ERR);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.RECEIVE_TIMEOUT:
        return Failure(ResponseCode.RECEIVE_TIMEOUT, ResponseMessage.RECEIVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION, ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
      default:
        return Failure(ResponseCode.DEFAULT,ResponseMessage.DEFAULT);
    }
  }
}

class ResponseCode {
  //API STATUS CODES
  static const int SUCCESS = 200; // Success with content
  static const int NO_CONTENT = 201; // Success with no content
  static const int BAD_REQUEST = 400; // Failure , API api rejected the request
  static const int FORBIDDEN = 403; // Failure , API api rejected the request
  static const int UNAUTHORIZED = 401; // Failure, user is Unauthorized
  static const int NOT_FOUND =
      404; // Failure, api url is not correct and not found
  static const int INTERNAL_SERVER_ERR =
      500; //Failure, crash happend in server site

  //LOCAL STATUS CODES
  static const int DEFAULT = -1;
  static const int CONNECT_TIMEOUT = -2;
  static const int CANCEL = -3;
  static const int RECEIVE_TIMEOUT = -4;
  static const int SEND_TIMEOUT = -5;
  static const int CACHE_ERROR = -6;
  static const int NO_INTERNET_CONNECTION = -7;
}

class ResponseMessage {
  //API STATUS CODES
  static const String SUCCESS = "success"; // Success with content
  static const String NO_CONTENT =
      "success with no content"; // Success with no content
  static const String BAD_REQUEST =
      "Bad request, try again later "; // Failure , API api rejected the request
  static const String FORBIDDEN =
      "forbidden request, try again later"; // Failure , API api rejected the request
  static const String UNAUTHORIZED =
      "user is unauthorizeds, you have no access"; // Failure, user is Unauthorized
  static const String NOT_FOUND =
      "Url is not found, try again later"; // Failure, api url is not correct and not found
  static const String INTERNAL_SERVER_ERR =
      "something went wrong, try again later"; //Failure, crash happend in server site

  //LOCAL STATUS CODES
  static const String DEFAULT = "something went wrong, try again later";
  static const String CONNECT_TIMEOUT = "time out error, try again later";
  static const String CANCEL = "request was cancelled, try again later";
  static const String RECEIVE_TIMEOUT = "time out error, try again later";
  static const String SEND_TIMEOUT = "time out error, try again later";
  static const String CACHE_ERROR = "cache error, try again later";
  static const String NO_INTERNET_CONNECTION =
      "Please check your internet connection";
}

class ApiInternalStatus{
  static const int SUCCESS = 0;
  static const int FAILURE = -1;
  
}