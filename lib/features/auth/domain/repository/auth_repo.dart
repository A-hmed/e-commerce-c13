import 'package:ecommerce_app/core/network/api_result.dart';
import 'package:ecommerce_app/features/auth/data/model/request/login_request.dart';
import 'package:ecommerce_app/features/auth/data/model/request/register_request.dart';

abstract class AuthRepo {
  Future<ApiResult<void>> login(LoginRequest request);

  Future<ApiResult<void>> register(RegisterRequest request);
}
