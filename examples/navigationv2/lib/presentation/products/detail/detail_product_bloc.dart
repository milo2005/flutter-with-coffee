import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:navigationv2/domain/models/product.dart';

import '../../../domain/repositories/product_repository.dart';

@injectable
class DetailProductBloc extends Cubit<Product?>{
  final ProductRepository _repository;
  DetailProductBloc(this._repository):super(null);

  getProduct(String? productId){
    emit(_repository.getById(productId));
  }
}