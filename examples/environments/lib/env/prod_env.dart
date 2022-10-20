import 'package:environments/env/env_config.dart';
import 'package:injectable/injectable.dart';

@production
@LazySingleton(as: EnvironmentConfig)
class ProductionEnvironment implements EnvironmentConfig {
  @override
  String apiKey = "prod api key";

  @override
  String baseUrl = "prod url";

  @override
  bool isProduction = true;

  @override
  String message = "Production Environment";
}
