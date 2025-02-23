import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce_app/core/extensions/connectivity_extension.dart';
import 'package:ecommerce_app/core/network/api_result.dart';
import 'package:ecommerce_app/core/network/errors.dart';
import 'package:ecommerce_app/features/auth/data/model/request/login_request.dart';
import 'package:ecommerce_app/features/auth/data/model/request/register_request.dart';
import 'package:ecommerce_app/features/auth/data/repository/auth_repository/data_sources/auth_remote_datasource/auth_remote_datasource.dart';
import 'package:ecommerce_app/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final Connectivity _connectivity;
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource, this._connectivity);

  @override
  Future<ApiResult<void>> login(LoginRequest request) async {
    if (await _connectivity.isConnected) {
      return await _remoteDataSource.login(request);
    } else {
      return ErrorApiResult(NetworkError());
    }
  }

  @override
  Future<ApiResult<void>> register(RegisterRequest request) async {
    if (await _connectivity.isConnected) {
      return _remoteDataSource.register(request);
    } else {
      return ErrorApiResult(NetworkError());
    }
  }
}
