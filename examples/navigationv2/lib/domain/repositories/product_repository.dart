import 'package:navigationv2/domain/models/product.dart';

abstract class ProductRepository {

  List<Product> getAll();
  Product? getById(String? id);
}