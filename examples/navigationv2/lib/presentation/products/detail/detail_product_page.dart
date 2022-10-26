import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigationv2/di/injector.dart';
import 'package:navigationv2/domain/models/product.dart';
import 'package:navigationv2/presentation/products/detail/detail_product_bloc.dart';

class DetailProductPage extends StatelessWidget {
  final String? productId;

  const DetailProductPage({
    this.productId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text("Detalle"),),
      body: BlocBuilder<DetailProductBloc, Product?>(
        bloc: getIt<DetailProductBloc>()..getProduct(productId),
        builder: (ctx, state) {
          if (state == null) {
            return const Center(
              child: Text("No se encontro el producto"),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Producto",
                    style: textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    state.name,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
