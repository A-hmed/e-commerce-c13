import 'package:ecommerce_app/core/network/api_result.dart';
import 'package:ecommerce_app/features/auth/data/model/request/register_request.dart';
import 'package:ecommerce_app/features/auth/domain/repository/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUseCase {
  final AuthRepo _repo;

  RegisterUseCase(this._repo);

  Future<ApiResult<void>> execute(RegisterRequest request) =>
      _repo.register(request);
}
