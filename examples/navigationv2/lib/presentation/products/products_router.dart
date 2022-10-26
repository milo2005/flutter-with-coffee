import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigationv2/app_router.dart';
import 'package:navigationv2/presentation/products/add/add_product_page.dart';
import 'package:navigationv2/presentation/products/detail/detail_product_page.dart';
import 'package:navigationv2/presentation/products/products_page.dart';

final productsRouter = GoRoute(
  path: "/products",
  builder: (ctx, state) => const ProductsPage(),
  routes: [
    GoRoute(
      path: "add",
      builder: (ctx, state) => const AddProductPage(),
    ),
    GoRoute(
      path: "detail/:idProduct",
      builder: (ctx, state) {
        final productId = state.params["idProduct"];
        return DetailProductPage(productId: productId);
      },
    )
  ],
);
