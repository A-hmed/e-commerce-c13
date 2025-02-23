import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/network/api_result.dart';
import 'package:ecommerce_app/core/network/errors.dart';
import 'package:ecommerce_app/core/utils/shared_prefrences_helper.dart';
import 'package:ecommerce_app/features/auth/data/model/request/login_request.dart';
import 'package:ecommerce_app/features/auth/data/model/request/register_request.dart';
import 'package:ecommerce_app/features/auth/data/model/response/auth_response.dart';
import 'package:ecommerce_app/features/auth/data/repository/auth_repository/data_sources/auth_remote_datasource/auth_remote_datasource.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final Dio _dio;
  final SharedPreferencesHelper _sharedPreferencesHelper;

  AuthRemoteDataSourceImpl(this._dio, this._sharedPreferencesHelper);

  final String _loginUrl = "/api/v1/auth/signin";
  final String _registerUrl = "/api/v1/auth/signup";

  @override
  Future<ApiResult<AuthResponse>> login(LoginRequest request) async {
    try {
      Response serverResponse =
          await _dio.post(_loginUrl, data: request.toJson());

      AuthResponse myResponse = AuthResponse.fromJson(serverResponse.data);

      if (serverResponse.statusCode! >= 200 &&
          serverResponse.statusCode! < 300) {
        await _sharedPreferencesHelper.saveUser(myResponse.user);
        await _sharedPreferencesHelper.saveToken(myResponse.token);
        return SuccessApiResult<AuthResponse>(myResponse);
      } else {
        return ErrorApiResult(ServerError(myResponse.message));
      }
    } catch (e) {
      return ErrorApiResult(ServerError());
    }
  }

  @override
  Future<ApiResult<AuthResponse>> register(RegisterRequest request) async {
    try {
      Response serverResponse =
          await _dio.post(_registerUrl, data: request.toJson());
      AuthResponse myResponse = AuthResponse.fromJson(serverResponse.data);

      if (serverResponse.statusCode! >= 200 &&
          serverResponse.statusCode! < 300) {
        await _sharedPreferencesHelper.saveUser(myResponse.user);
        await _sharedPreferencesHelper.saveToken(myResponse.token);
        return SuccessApiResult<AuthResponse>(myResponse);
      } else {
        return ErrorApiResult(ServerError(myResponse.message ?? ""));
      }
    } catch (e) {
      return ErrorApiResult(ServerError());
    }
  }
}
