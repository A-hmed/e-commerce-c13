import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce_app/core/extensions/connectivity_extensions.dart';
import 'package:ecommerce_app/core/network/api_result.dart';
import 'package:ecommerce_app/core/network/errors.dart';
import 'package:ecommerce_app/features/auth/data/model/request/login_request.dart';
import 'package:ecommerce_app/features/auth/data/model/request/register_request.dart';
import 'package:ecommerce_app/features/auth/data/repository/datasources/auth_remote_datasource/auth_remote_datasource.dart';
import 'package:ecommerce_app/features/auth/domain/repository/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl extends AuthRepo {
  AuthRemoteDataSource authRemoteDataSource;
  Connectivity connectivity;

  AuthRepoImpl(this.authRemoteDataSource, this.connectivity);

  @override
  Future<ApiResult<void>> login(LoginRequest request) async {
    if (await connectivity.isConnected) {
      return authRemoteDataSource.login(request);
    } else {
      return ErrorApiResult(NetworkError());
    }
  }

  @override
  Future<ApiResult<void>> register(RegisterRequest request) async {
    if (await connectivity.isConnected) {
      return authRemoteDataSource.register(request);
    } else {
      return ErrorApiResult(NetworkError());
    }
  }
}
