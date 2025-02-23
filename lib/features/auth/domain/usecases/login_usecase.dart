import 'package:ecommerce_app/core/network/api_result.dart';
import 'package:ecommerce_app/features/auth/data/model/request/login_request.dart';
import 'package:ecommerce_app/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<ApiResult<void>> execute(LoginRequest request) =>
      _repository.login(request);
}
