import 'package:injectable/injectable.dart';
import 'package:navigationv2/domain/models/product.dart';
import 'package:navigationv2/domain/repositories/product_repository.dart';

@lazySingleton
class ProductByIdUseCase {
  final ProductRepository _repository;
  ProductByIdUseCase(this._repository);

  Product? call(String productId) => _repository.getById(productId);
}
