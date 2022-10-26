import 'package:injectable/injectable.dart';
import 'package:navigationv2/domain/models/product.dart';
import 'package:navigationv2/domain/repositories/product_repository.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final List<Product> _data = [
    Product(id: "qwe", name: "Product 1", price: 5000),
    Product(id: "asd", name: "Product 2", price: 3000),
    Product(id: "zxc", name: "Product 3", price: 2000),
    Product(id: "tyu", name: "Product 4", price: 7000),
    Product(id: "ghj", name: "Product 5", price: 8000),
  ];

  @override
  List<Product> getAll() => _data;

  @override
  Product? getById(String? id) =>
      _data.firstWhere((element) => element.id == id);
}
