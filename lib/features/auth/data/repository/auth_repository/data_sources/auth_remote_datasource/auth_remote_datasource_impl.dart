import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/network/api_result.dart';
import 'package:ecommerce_app/core/network/errors.dart';
import 'package:ecommerce_app/features/auth/data/model/request/login_request.dart';
import 'package:ecommerce_app/features/auth/data/model/request/register_request.dart';
import 'package:ecommerce_app/features/auth/data/model/response/auth_response.dart';
import 'package:ecommerce_app/features/auth/data/repository/auth_repository/data_sources/auth_remote_datasource/auth_remote_datasource.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  Dio _dio;

  AuthRemoteDataSourceImpl(this._dio);

  final String _loginUrl = "/api/v1/auth/signin";
  final String _registerUrl = "/api/v1/auth/signup";

  Future<ApiResult<AuthResponse>> login(LoginRequest request) async {
    try {
      Response serverResponse =
          await _dio.post(_loginUrl, data: request.toJson());

      AuthResponse myResponse = AuthResponse.fromJson(serverResponse.data);

      if (serverResponse.statusCode! >= 200 &&
          serverResponse.statusCode! < 300) {
        return SuccessApiResult<AuthResponse>(myResponse);
      } else {
        return ErrorApiResult(ServerError(myResponse.message));
      }
    } catch (e) {
      return ErrorApiResult(ServerError());
    }
  }

  Future<ApiResult<AuthResponse>> register(RegisterRequest request) async {
    try {
      Response serverResponse =
          await _dio.post(_registerUrl, data: request.toJson());
      AuthResponse myResponse = AuthResponse.fromJson(serverResponse.data);

      if (serverResponse.statusCode! >= 200 &&
          serverResponse.statusCode! < 300) {
        return SuccessApiResult<AuthResponse>(myResponse);
      } else {
        return ErrorApiResult(ServerError(myResponse.message ?? ""));
      }
    } catch (e) {
      return ErrorApiResult(ServerError());
    }
  }
}
