import 'package:injectable/injectable.dart';
import 'package:navigationv2/domain/repositories/auth_repository.dart';

@lazySingleton
class IsLoggedUseCase {

  final AuthRepository _repository;
  IsLoggedUseCase(this._repository);

  bool call(){
    return _repository.isLogged();
  }
}
