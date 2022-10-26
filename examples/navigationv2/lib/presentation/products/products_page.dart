import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:navigationv2/di/injector.dart';
import 'package:navigationv2/domain/models/product.dart';
import 'package:navigationv2/presentation/products/products_bloc.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Productos"),
      ),
      body: BlocBuilder<ProductsBloc, List<Product>>(
        bloc: getIt<ProductsBloc>()..loadProducts(),
        builder: (ctx, state)=>ListView.builder(
          itemCount: state.length,
          itemBuilder: (ctx, index)=> ListTile(
            title: Text(state[index].name),
            subtitle: Text("\$ ${state[index].price}"),
            onTap: ()=> context.push("/products/detail/${state[index].id}"),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=> context.push("/products/add"),
        child: const Icon(Icons.add),
      ),
    );
  }
}
