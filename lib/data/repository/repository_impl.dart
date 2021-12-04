import 'package:miseo/data/data_source/remote_data_source.dart';
import 'package:miseo/data/network/error_handler.dart';
import 'package:miseo/data/network/network_info.dart';
import 'package:miseo/domain/model.dart';
import 'package:miseo/data/requests/request.dart';
import 'package:miseo/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:miseo/domain/repository.dart';
import 'package:miseo/data/mapper/mapper.dart';

class RepositoryImpl extends Repository {
  RemoteDataSource _remoteDataSource;
  NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        //user have connection -> call api
        final response = await _remoteDataSource.login(loginRequest);

        if (response.status == ApiInternalStatus.SUCCESS) //sucess
        {
          //return data
          //return right
          return Right(response.toDomain());
        } else {
          //return business logic error
          return Left(Failure(
              response.status ?? ApiInternalStatus.FAILURE,
              response.message ??
                  ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // no connection -> return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
