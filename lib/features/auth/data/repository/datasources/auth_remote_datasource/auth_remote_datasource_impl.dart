import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/extensions/int_extensions.dart';
import 'package:ecommerce_app/core/network/api_result.dart';
import 'package:ecommerce_app/core/network/errors.dart';
import 'package:ecommerce_app/features/auth/data/model/request/login_request.dart';
import 'package:ecommerce_app/features/auth/data/model/request/register_request.dart';
import 'package:ecommerce_app/features/auth/data/model/response/auth_response.dart';
import 'package:injectable/injectable.dart';

import 'auth_remote_datasource.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final String _loginUrl = "/api/v1/auth/signin";
  final String _registerUrl = "/api/v1/auth/signup";
  final Dio _dio;

  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<ApiResult<AuthResponse>> login(LoginRequest request) async {
    try {
      var serverResponse = await _dio.post(_loginUrl, data: request.toJson());
      var json = serverResponse.data;
      var authResponse = AuthResponse.fromJson(json);
      if (serverResponse.statusCode!.isSuccess) {
        return SuccessApiResult(authResponse);
      } else {
        return ErrorApiResult(ServerError(authResponse.message));
      }
    } catch (e) {
      return ErrorApiResult(ServerError());
    }
  }

  @override
  Future<ApiResult<AuthResponse>> register(RegisterRequest request) async {
    try {
      var serverResponse =
          await _dio.post(_registerUrl, data: request.toJson());
      var json = serverResponse.data;
      var authResponse = AuthResponse.fromJson(json);
      if (serverResponse.statusCode!.isSuccess) {
        return SuccessApiResult(authResponse);
      } else {
        return ErrorApiResult(ServerError(authResponse.message));
      }
    } catch (e) {
      return ErrorApiResult(ServerError());
    }
  }
}
