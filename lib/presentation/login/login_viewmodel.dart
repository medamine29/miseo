import 'dart:async';

import 'package:miseo/domain/usecase/login_usecase.dart';
import 'package:miseo/presentation/base/baseviewmodel.dart';
import 'package:miseo/presentation/common/freezed_data_classes.dart';
import 'package:miseo/presentation/common/state_renderer/state_renderer.dart';
import 'package:miseo/presentation/common/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();

  var loginObject = LoginObject("", "");

  LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidStreamController.close();
  }

  @override
  void start() {
    // view tells state renderer , show the content of the screen
    inputState.add(ContentState());
  }

  //inputs

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    _validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    _validate();
  }

  @override
  login() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.POPUP_LOADING_STATE));
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.userName, loginObject.password)))
        .fold(
            (failure) => {
                  //left -> Failure
                  inputState.add(ErrorState(StateRendererType.POPUP_ERROR_STATE, failure.message))
                },
            (data) => {
                  //right -> Success --> data
                  inputState.add(ContentState())
                  //navigate to main screen after the login success
                });
  }

  //outputs

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((username) => _isUserNameValid(username));

  @override
  Stream<bool> get outputAreAllInputsValid =>
      _areAllInputsValidStreamController.stream
          .map((_) => _areAllInputsValid());

  //private functions
  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String username) {
    return username.isNotEmpty;
  }

  bool _areAllInputsValid() {
    return (_isPasswordValid(loginObject.password) &&
        _isUserNameValid(loginObject.userName));
  }

  _validate() {
    inputAreAllInputsValid.add(null);
  }
}

abstract class LoginViewModelInputs {
  // functions
  setUserName(String username);
  setPassword(String password);
  login();
  // sinks
  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputAreAllInputsValid;
}

abstract class LoginViewModelOutputs {
  // streams
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputAreAllInputsValid;
}
