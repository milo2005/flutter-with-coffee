import 'package:injectable/injectable.dart';

const development = Environment(Environment.dev);
const production = Environment(Environment.prod);
const testing = Environment(Environment.test);

abstract class EnvironmentConfig {
  abstract bool isProduction;
  abstract String baseUrl;
  abstract String apiKey;
  abstract String message;
}


