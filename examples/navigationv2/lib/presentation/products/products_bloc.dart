import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:navigationv2/domain/models/product.dart';
import 'package:navigationv2/domain/repositories/product_repository.dart';

@injectable
class ProductsBloc extends Cubit<List<Product>>{
  final ProductRepository _repository;
  ProductsBloc(this._repository):super([]);

  loadProducts(){
    emit(_repository.getAll());
  }
}