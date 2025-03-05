// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/repository/auth_repository/auth_repository_impl.dart'
    as _i859;
import '../../features/auth/data/repository/auth_repository/data_sources/auth_remote_datasource/auth_remote_datasource.dart'
    as _i367;
import '../../features/auth/data/repository/auth_repository/data_sources/auth_remote_datasource/auth_remote_datasource_impl.dart'
    as _i298;
import '../../features/auth/domain/repository/auth_repository.dart' as _i961;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188;
import '../../features/auth/domain/usecases/register_usecase.dart' as _i941;
import '../../features/auth/presentation/screens/sign_in/cubit/signIn_cubit.dart'
    as _i965;
import '../../features/main_layout/data/mappers/category_mapper.dart' as _i988;
import '../../features/main_layout/data/mappers/product_mapper.dart' as _i358;
import '../../features/main_layout/data/repository/home_repository/datasources/home_remote_datasource.dart'
    as _i379;
import '../../features/main_layout/data/repository/home_repository/datasources/home_remote_datasource_impl.dart'
    as _i293;
import '../../features/main_layout/data/repository/home_repository/home_repoistory_impl.dart'
    as _i895;
import '../../features/main_layout/domain/repository/home_repoistory.dart'
    as _i63;
import '../../features/main_layout/domain/use_case/get_categories_usecase.dart'
    as _i70;
import '../../features/main_layout/domain/use_case/get_products_usecase.dart'
    as _i671;
import '../../features/main_layout/presentation/home/presentation/cubit/home_cubit.dart'
    as _i199;
import '../utils/shared_prefrences_helper.dart' as _i419;
import 'di_module.dart' as _i211;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final diModule = _$DiModule();
    gh.factory<_i988.CategoryMapper>(() => _i988.CategoryMapper());
    gh.singleton<_i361.Dio>(() => diModule.initDio());
    gh.singleton<_i895.Connectivity>(() => diModule.getConnectivity());
    gh.singleton<_i419.SharedPreferencesHelper>(
        () => _i419.SharedPreferencesHelper());
    gh.factory<_i379.HomeRemoteDataSource>(
        () => _i293.HomeRemoteDataSourceImpl(gh<_i361.Dio>()));
    gh.factory<_i367.AuthRemoteDataSource>(() => _i298.AuthRemoteDataSourceImpl(
          gh<_i361.Dio>(),
          gh<_i419.SharedPreferencesHelper>(),
        ));
    gh.factory<_i358.ProductMapper>(
        () => _i358.ProductMapper(gh<_i988.CategoryMapper>()));
    gh.factory<_i961.AuthRepository>(() => _i859.AuthRepositoryImpl(
          gh<_i367.AuthRemoteDataSource>(),
          gh<_i895.Connectivity>(),
        ));
    gh.factory<_i188.LoginUseCase>(
        () => _i188.LoginUseCase(gh<_i961.AuthRepository>()));
    gh.factory<_i941.RegisterUseCase>(
        () => _i941.RegisterUseCase(gh<_i961.AuthRepository>()));
    gh.factory<_i965.SignInCubit>(
        () => _i965.SignInCubit(gh<_i188.LoginUseCase>()));
    gh.factory<_i63.HomeRepository>(() => _i895.HomeRepositoryImpl(
          gh<_i379.HomeRemoteDataSource>(),
          gh<_i895.Connectivity>(),
          gh<_i988.CategoryMapper>(),
          gh<_i358.ProductMapper>(),
        ));
    gh.factory<_i70.GetCategoriesUseCase>(
        () => _i70.GetCategoriesUseCase(gh<_i63.HomeRepository>()));
    gh.factory<_i671.GetProductsUseCase>(
        () => _i671.GetProductsUseCase(gh<_i63.HomeRepository>()));
    gh.factory<_i199.HomeCubit>(() => _i199.HomeCubit(
          gh<_i671.GetProductsUseCase>(),
          gh<_i70.GetCategoriesUseCase>(),
        ));
    return this;
  }
}

class _$DiModule extends _i211.DiModule {}
