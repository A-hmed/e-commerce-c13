import 'package:ecommerce_app/core/network/api_result.dart';
import 'package:ecommerce_app/features/auth/data/model/request/login_request.dart';
import 'package:ecommerce_app/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<ApiResult<void>> execute(LoginRequest request) {
    return _repository.login(request);
  }
}
