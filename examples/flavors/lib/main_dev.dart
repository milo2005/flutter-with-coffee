import 'package:flavors/app.dart';
import 'package:flavors/di/injector.dart';
import 'package:injectable/injectable.dart';

void main() {
  configureDependencies(Environment.dev);
  setupApp();
}