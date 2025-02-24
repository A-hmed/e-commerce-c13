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

import '../../features/auth/data/repository/auth_repo_impl.dart' as _i751;
import '../../features/auth/data/repository/datasources/auth_remote_datasource/auth_remote_datasource.dart'
    as _i364;
import '../../features/auth/data/repository/datasources/auth_remote_datasource/auth_remote_datasource_impl.dart'
    as _i237;
import '../../features/auth/domain/repository/auth_repo.dart' as _i976;
import '../../features/auth/domain/usecase/login_usecase.dart' as _i911;
import '../../features/auth/domain/usecase/register_usecase.dart' as _i769;
import '../../features/auth/presentation/screens/sign_in/cubit/signin_cubit.dart'
    as _i833;
import '../utils/app_prefernces.dart' as _i114;
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
    gh.factory<_i895.Connectivity>(() => diModule.getConnectivity());
    gh.singleton<_i361.Dio>(() => diModule.getDio());
    gh.singleton<_i114.AppPreferences>(() => _i114.AppPreferences());
    gh.factory<_i364.AuthRemoteDataSource>(() => _i237.AuthRemoteDataSourceImpl(
          gh<_i361.Dio>(),
          gh<_i114.AppPreferences>(),
        ));
    gh.factory<_i976.AuthRepo>(() => _i751.AuthRepoImpl(
          gh<_i364.AuthRemoteDataSource>(),
          gh<_i895.Connectivity>(),
        ));
    gh.factory<_i911.LoginUseCase>(
        () => _i911.LoginUseCase(gh<_i976.AuthRepo>()));
    gh.factory<_i769.RegisterUseCase>(
        () => _i769.RegisterUseCase(gh<_i976.AuthRepo>()));
    gh.factory<_i833.SignInCubit>(
        () => _i833.SignInCubit(gh<_i911.LoginUseCase>()));
    return this;
  }
}

class _$DiModule extends _i211.DiModule {}
