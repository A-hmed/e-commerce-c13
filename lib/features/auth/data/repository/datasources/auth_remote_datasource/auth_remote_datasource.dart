import 'package:ecommerce_app/core/network/api_result.dart';
import 'package:ecommerce_app/features/auth/data/model/request/login_request.dart';
import 'package:ecommerce_app/features/auth/data/model/request/register_request.dart';
import 'package:ecommerce_app/features/auth/data/model/response/auth_response.dart';

abstract class AuthRemoteDataSource {
  Future<ApiResult<AuthResponse>> login(LoginRequest request);

  Future<ApiResult<AuthResponse>> register(RegisterRequest request);
}
