import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agregar Producto"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Pantalla apra agregar productos"),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => context.pop(),
                child: const Text("Regresar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
