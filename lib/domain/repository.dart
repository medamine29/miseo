import 'package:dartz/dartz.dart';
import 'package:miseo/data/network/failure.dart';
import 'package:miseo/data/requests/request.dart';
import 'package:miseo/domain/model.dart';

abstract class Repository{
  Future<Either<Failure,Authentication>> login(LoginRequest loginRequest);
}