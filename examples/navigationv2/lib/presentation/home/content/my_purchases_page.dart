import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyPurchasesPage extends StatelessWidget {
  const MyPurchasesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Seccion 1"),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.push("/products"),
              child: const Text("Ver Productos"),
            ),
            ElevatedButton(
              onPressed: () => context.go("/products/detail/qwe"),
              child: const Text("Ver Detalle (go)"),
            ),
          ],
        ),
      ),
    );
  }
}
