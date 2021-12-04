import 'package:miseo/app/functions.dart';
import 'package:miseo/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:miseo/data/requests/request.dart';
import 'package:miseo/domain/model/model.dart';
import 'package:miseo/domain/repository/repository.dart';
import 'package:miseo/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput,Authentication>{

  Repository _repository;
  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(LoginUseCaseInput input) async {

    DeviceInfo deviceInfo = await getDeviceDetails();
    return await _repository.login(LoginRequest(input.email, input.password, deviceInfo.identifier, deviceInfo.name));
  }
  
}

class LoginUseCaseInput{
  String email;
  String password;
  LoginUseCaseInput(this.email,this.password);
}