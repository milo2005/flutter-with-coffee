import 'package:injectable/injectable.dart';
import 'package:navigationv2/domain/models/product.dart';
import 'package:navigationv2/domain/repositories/product_repository.dart';

@lazySingleton
class AllProductsUseCase {
  final ProductRepository _repository;
  AllProductsUseCase(this._repository);

  List<Product> call() => _repository.getAll();
}
