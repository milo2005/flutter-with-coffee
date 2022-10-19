import 'package:flavors/app.dart';
import 'package:injectable/injectable.dart';

import 'di/injector.dart';

void main() {
  configureDependencies(Environment.prod);
  setupApp();
}