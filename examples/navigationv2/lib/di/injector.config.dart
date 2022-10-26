// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/auth_repository_impl.dart' as _i4;
import '../data/product_repository_impl.dart' as _i8;
import '../domain/repositories/auth_repository.dart' as _i3;
import '../domain/repositories/product_repository.dart' as _i7;
import '../domain/usescases/auth/is_logged_usecase.dart' as _i5;
import '../domain/usescases/auth/login_usecase.dart' as _i6;
import '../domain/usescases/products/all_products_usecase.dart' as _i10;
import '../domain/usescases/products/product_by_id_usecase.dart' as _i13;
import '../presentation/login/login_bloc.dart' as _i12;
import '../presentation/products/detail/detail_product_bloc.dart' as _i11;
import '../presentation/products/products_bloc.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

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
  gh.lazySingleton<_i3.AuthRepository>(() => _i4.AuthRepositoryImpl());
  gh.lazySingleton<_i5.IsLoggedUseCase>(
      () => _i5.IsLoggedUseCase(get<_i3.AuthRepository>()));
  gh.lazySingleton<_i6.LoginUseCase>(
      () => _i6.LoginUseCase(get<_i3.AuthRepository>()));
  gh.lazySingleton<_i7.ProductRepository>(() => _i8.ProductRepositoryImpl());
  gh.factory<_i9.ProductsBloc>(
      () => _i9.ProductsBloc(get<_i7.ProductRepository>()));
  gh.lazySingleton<_i10.AllProductsUseCase>(
      () => _i10.AllProductsUseCase(get<_i7.ProductRepository>()));
  gh.factory<_i11.DetailProductBloc>(
      () => _i11.DetailProductBloc(get<_i7.ProductRepository>()));
  gh.factory<_i12.LoginBloc>(() => _i12.LoginBloc(get<_i6.LoginUseCase>()));
  gh.lazySingleton<_i13.ProductByIdUseCase>(
      () => _i13.ProductByIdUseCase(get<_i7.ProductRepository>()));
  return get;
}
