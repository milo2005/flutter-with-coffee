import 'package:flavors/env/env_config.dart';
import 'package:injectable/injectable.dart';

@development
@LazySingleton(as: EnvironmentConfig)
class DevEnvironment implements EnvironmentConfig {
  @override
  String apiKey = "dev api key";

  @override
  String baseUrl = "dev url";

  @override
  bool isProduction = false;

  @override
  String message = "Dev Environment";
}
