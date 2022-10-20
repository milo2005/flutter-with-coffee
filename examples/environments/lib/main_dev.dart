import 'package:environments/app.dart';
import 'package:environments/di/injector.dart';
import 'package:injectable/injectable.dart';

void main() {
  configureDependencies(Environment.dev);
  setupApp();
}