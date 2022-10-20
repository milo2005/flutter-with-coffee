import 'package:environments/di/injector.dart';
import 'package:environments/env/env_config.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final env = getIt<EnvironmentConfig>();
    return Scaffold(
      appBar: AppBar(
        title: Text(env.isProduction ? "Production" : "Development"),
      ),
      body: Center(
        child: Text(env.message),
      ),
    );
  }
}
