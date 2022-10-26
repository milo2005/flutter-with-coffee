import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:navigationv2/domain/usescases/auth/login_usecase.dart';

enum LoginState {success, initial, loading}

@injectable
class LoginBloc extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  LoginBloc(this._loginUseCase):super(LoginState.initial);

  login() async {
    emit(LoginState.loading);
    await _loginUseCase();
    emit(LoginState.success);
  }
}
