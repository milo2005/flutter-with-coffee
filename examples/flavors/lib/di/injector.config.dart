// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../env/dev_env.dart' as _i5;
import '../env/env_config.dart' as _i3;
import '../env/prod_env.dart' as _i4;

const String _prod = 'prod';
const String _dev = 'dev';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.EnvironmentConfig>(
    () => _i4.ProductionEnvironment(),
    registerFor: {_prod},
  );
  gh.lazySingleton<_i3.EnvironmentConfig>(
    () => _i5.DevEnvironment(),
    registerFor: {_dev},
  );
  return get;
}
