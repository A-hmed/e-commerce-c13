import 'package:ecommerce_app/core/network/api_result.dart';
import 'package:ecommerce_app/features/auth/data/model/request/login_request.dart';
import 'package:ecommerce_app/features/auth/domain/repository/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final AuthRepo _repo;

  LoginUseCase(this._repo);

  Future<ApiResult<void>> execute(LoginRequest request) => _repo.login(request);
}
