import 'package:injectable/injectable.dart';
import 'package:navigationv2/domain/repositories/auth_repository.dart';

@lazySingleton
class LoginUseCase {
  final AuthRepository _repository;
  LoginUseCase(this._repository);

  Future call() async {
    await Future.delayed(const Duration(seconds: 1));
    _repository.login();
  }
}