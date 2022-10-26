import 'package:injectable/injectable.dart';
import 'package:navigationv2/domain/repositories/auth_repository.dart';


@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {

  bool _isLogged = false;

  @override
  bool isLogged() => _isLogged;

  @override
  login() {
    _isLogged = true;
  }
}