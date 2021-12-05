import 'package:dartz/dartz.dart';
import 'package:miseo/data/network/error_handler.dart';

class Failure {
  int code; // 404 , 400 ...
  String message; // error message

  Failure(this.code, this.message);
}

class DefaultFailure extends Failure{
  DefaultFailure(): super(ResponseCode.DEFAULT,ResponseMessage.DEFAULT);
}